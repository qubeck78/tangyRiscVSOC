#include "main.h"
#include <cstring>
#include <climits>

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/gfJPEG.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h" 
#include "../gfxLib/ff.h" 

//#define _MODE640

extern BSP_T        *bsp;


extern tgfTextOverlay        con;
tgfBitmap            screen;
tgfBitmap            background;
tgfBitmap            fileBmp;


char buf[128];
char lfnBuf[ 512 + 16];

tosDir              dir;
tosDirItem          dirItem;

int animLeds( int j )
{   
        switch( j % 2 )
        {
            case 0:
                bsp->gpoPort |= 0x00f0;
                bsp->gpoPort ^= 0x0010;
            
                break;

            case 1:

                bsp->gpoPort |= 0x00f0;
                bsp->gpoPort ^= 0x0020;
            
                break;

/*          case 2:
            
                bsp->gpoPort |= 0x00f0;
                bsp->gpoPort ^= 0x0040;

                break; 

            case 3:
        
                bsp->gpoPort |= 0x00f0;
                bsp->gpoPort ^= 0x0080;

                break;
*/
        }
        
    return 0;
} 



int slideshow()
{
    int             rv;
    int             i;
    int             led;
    volatile ulong  j;
    short           x;
    short           y;
    char            extension[8];
    tosUIEvent      event;

    led = 0;
    
    do{
        
        #ifdef _GFXLIB_SDL

        rv = osDirOpen( &dir, (char*)"./img" );

        #else

        rv = osDirOpen( &dir, (char*)"0:img" );

        #endif

        do
        {
            rv = osDirRead( &dir, &dirItem );

            if( rv ) 
            {
                break; // Error or end of dir
            }

            
            if ( dirItem.type != OS_DIRITEM_DIR )
            {

                i = strlen( dirItem.name );
            
                if( i >= 4 )
                {
                    extension[0] = dirItem.name[ i - 4 ];
                    extension[1] = dirItem.name[ i - 3 ];
                    extension[2] = dirItem.name[ i - 2 ];
                    extension[3] = dirItem.name[ i - 1 ];
                    extension[4] = 0;
                    
                    if( ( strcmp( extension, ".jpg" ) == 0 ) || ( strcmp( extension, ".gbm" ) == 0 ) )
                    {
                    
                        animLeds( led++ );
                        
                        strcpy( buf, "img/" );
                        strcat( buf, dirItem.name );

                        con.textAttributes = 0x0f;
                        toCls( &con );
                        con.textAttributes  = 0x8f;

                        toPrintF( &con, (char*)"Loading:%s", dirItem.name );

                        if( dirItem.name[ i - 3 ] == 'g' )
                        {
                            gfLoadBitmapFS( &fileBmp, buf );
                        }
                        else
                        {
                            gfLoadJPEGFS( &fileBmp, buf );                      
                        }
                        
                        if( screen.width > 320 )
                        {                       
                            x  = ((ulong)randomNumber() ) % 320;
                            y  = ((ulong)randomNumber() ) % 240;
                            
                        }
                        else
                        {
                        
                            x = ( screen.width / 2 ) - ( fileBmp.width / 2);
                            y = ( screen.height / 2 ) - ( fileBmp.height / 2 );
                        }

                        for( i = 0; i < 256; i += 16 )
                        {       
                            do{}while( ! bsp->videoVSync ); 
                            gfBlitBitmapA( &screen, &fileBmp, x, y, i );
                        }
                        
                        
                        gfBlitBitmap( &screen, &fileBmp, x, y );

                        osFree( fileBmp.buffer );
                        
                        fileBmp.buffer          = NULL;
                        con.textAttributes      = 0x0f;
                        
                        toCls( &con );
                        con.textAttributes      = 0x8f;
                        
                        toPrintF( &con, (char*)"%s %d\n", dirItem.name, dirItem.size );
                        
                        for( i = 0; i < 100; i++ )
                        {
                            delayMs( 100 );
                                            
                            if( !osGetUIEvent( &event ) )
                            { 
                                if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
                                {
                                    switch( event.arg1 )
                                    {
                                    
                                        case _KEYCODE_PAUSE:

                                            reboot();
                                            break; 

                                        case _KEYCODE_F1:

                                            if( screen.width == 320 )
                                            {
                                                //switch to 640x480
                                                screen.width    = 640;
                                                screen.rowWidth = 640;
                                                screen.height   = 480;

                                                setVideoMode( _VIDEOMODE_640_TEXT80_OVER_GFX );
                                            
                                                gfFillRect( &screen, 0, 0, screen.width - 1, screen.height - 1 , gfColor( 0, 0, 0 ) ); 

                                                //exit delay loop
                                                i = 100;
                                            }
                                            else
                                            {
                                                //switch to 320x240
                                                screen.width    = 320;
                                                screen.rowWidth = 320;
                                                screen.height   = 240;

                                                setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );

                                                gfFillRect( &screen, 0, 0, screen.width - 1, screen.height - 1 , gfColor( 0, 0, 0 ) ); 

                                                //exit delay loop
                                                i = 100;
                                            }

                                            break;

                                        default:

                                            //exit delay loop
                                            i = 100;
                                            break;
                                    }
                                }

                            }
                        }
                    }
                }
            }
            
        }while( 1 );
    
        osDirClose( &dir );

    }while( 1 );

}



int main()
{
    int i;
    int rv;
    
    volatile int j;
        
    bspInit();
        

    #ifdef _MODE640
    
    setVideoMode( _VIDEOMODE_640_TEXT80_OVER_GFX );

    //alloc screen buffers
    screen.width            = 640;  
    screen.rowWidth         = 640;  
    screen.height           = 480;  
    
    #else
    
    setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );

    //alloc screen buffers
    screen.width            = 320;
    screen.rowWidth         = 320;
    screen.height           = 240;
    
    #endif

    toCls( &con );
    toPrint( &con, (char*)"Slideshow\n" );

    
    screen.flags            = 0;
    screen.transparentColor = 0;

    //always alloc 640x480 to allow screenmode switching
    screen.buffer           = osAlloc( 640 * 480 * 2, OS_ALLOC_MEMF_CHIP ); 
    
    if( screen.buffer == NULL )
    {
        toPrint( &con, (char*)"\nCan't alloc screen\n" );
        do{}while( 1 );
    } 
        
    
    //display first buffer
    
    gfDisplayBitmap( &screen );

    gfFillRect( &screen, 0, 0, screen.width - 1, screen.height - 1 , gfColor( 0, 0, 0 ) ); 
    
    //init events queue
    osUIEventsInit();  

    //init filesystem
    rv = osFInit();


    if( rv )
    {
        toPrint( &con, ( char* )"SD init error!" );
        
        do{
        }while( 1 );        
    }
    else
    {
        toPrint( &con, ( char* )"SD init ok\n" );
    }
        


    slideshow();

} 