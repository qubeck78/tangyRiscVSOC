#include "main.h"
#include <cstring>
#include <climits>

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"

#include "../gfxLib/osUIEvents.h"


extern tgfTextOverlay   con;
tgfBitmap               screen;


int animLeds( int j )
{   

    #if defined( _GFXLIB_RISCV_FATFS )
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

        }

    #endif      
    return 0;
} 


//mandelbrot browser: https://mandel.gart.nz/
int mandelbrot( tgfBitmap *bmp, float xmin, float ymin, float dx, float dy )
{
    int     x;
    int     y;
    
    float   ci;
    float   cr;
    float   zr;
    float   zi;
    float   zrr;
    float   zii;
    float   zri;
    
    int     iter;
    
    ushort  r;
    ushort  g;
    ushort  b;
    
    ci = ymin;
    
    for( y = 0; y < bmp->height; y++ )
    {
    
        animLeds( y );
        
        cr = xmin;
        
        for( x = 0; x < bmp->width; x++ )
        {
        
            zr = cr;
            zi = ci;
            
            iter = 32;
            
            while( iter > 0 )
            {
            
                zrr = zr * zr;
                zii = zi * zi;
                zri = 2.0 * ( zr * zi );
                
                zr = zrr - zii + cr;
                zi = zri + ci;
                
                if( zrr + zii > 4.0 )
                {
                    break;
                }
                iter--;
            
            }
        
            if( iter == 0 )
            {
                r = 0;
                g = 0;
                b = 0;
            }
            else
            {
        
                r = ( 32 - iter ) << 3;
                g = 0;
                b = r;
            }
            gfPlot( bmp, x, y, gfColor( r, g, b ) );
            
            cr += dx;
            
        }
        
        ci += dy;
    }

    return 0;
}

int ffMandelbrot( tgfBitmap *bmp, ushort colorMask, float xmin, float ymin, float dx, float dy )
{
    int     x;
    int     y;
    
    float   ci;
    float   cr;
    float   zr;
    float   zi;
    float   zrr;
    float   zii;
    float   zri;
    
    float   zrmzi;
    
    int     iter;
    ushort  color;
    
    ushort  r;
    ushort  g;
    ushort  b;
    
    
    if( ( colorMask & 3 ) == 0 )
    {
        colorMask = 1;
    }
    
    ci = ymin;
    
    for( y = 0; y < bmp->height; y++ )
    {
        animLeds( y );
        
        cr = xmin;
        
        for( x = 0; x < bmp->width; x++ )
        {
        
            zr = cr;
            zi = ci;
            
            iter = 32;
            
            while( iter > 0 )
            {
            
                zrr = ffMul( zr, zr );
                //zrr = zr * zr;
                zii = ffMul( zi, zi );
                
                //zii = zi * zi;
            
                zrmzi   = ffMul( zr, zi );
                zri     = ffMul( 2.0f, zrmzi );
                
                //zri = 2.0f * ( zr * zi );
                
                zr      = ffSub( zrr, zii );
                zr      = ffAdd( zr, cr );
                
                //zr = zrr - zii + cr;
                
                zi      = ffAdd( zri, ci );
                //zi = zri + ci;
                
                if( ffAdd( zrr, zii ) > 4.0f )
//              if( zrr + zii > 4.0f )
                {
                    break;
                }
                iter--;
            
            }
        
            if( iter == 0 )
            {
                color = 0;
            }
            else
            {
                color = ( 32 - iter ) << 3;
            }

            if( colorMask & 1 )
            {
                r = color;
            }
            else
            {
                r = 0;
            }
            
            if( colorMask & 2 )
            {
                g = color;
            }
            else
            {
                g = 0;
            }
            
            if( colorMask & 4 )
            {
                b = color;
            }
            else
            {
                b = 0;
            }

            gfPlot( bmp, x, y, gfColor( r, g, b ) );

            cr = ffAdd( cr, dx );
            //cr += dx;
            
        }
        
        ci = ffAdd( ci, dy );
        //ci += dy;
    }

    return 0;
}

int main()
{
    ulong       i;
    int         rv;
    ulong       startTicks;
    ulong       endTicks;
    tosUIEvent  event; 

    bspInit();

    
    setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );
    
    //alloc screen buffers
    screen.width            = 320;
    screen.rowWidth         = 512;
    screen.height           = 240;
    
    
    screen.flags            = 0;
    screen.transparentColor = 0;
    screen.buffer           = osAlloc( screen.rowWidth * screen.height * 2, OS_ALLOC_MEMF_CHIP );
    
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
    
    startTicks = getTicks();

    ffMandelbrot( &screen, 7, -2.0f, -1.0f, 0.0085f, 0.0085f );

    endTicks = getTicks();

    toPrintF( &con, (char*)"Time: %d ms", endTicks - startTicks );

    delayMs( 30000 );

    con.textAttributes = 0x0f;

    toCls( &con );

    con.textAttributes = 0x8f;
        
    do
    {
        ffMandelbrot( &screen, ( randomNumber() >> 7 ) & 7, -1.7f + ((ulong)randomNumber() ) / 3294967296.0f ,  -1.7f + ((ulong)randomNumber() ) / 3294967296.0f , 0.001f, 0.001f );

        while( !osGetUIEvent( &event ) )
        { 
            if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
            {
                switch( event.arg1 )
                {
                    case _KEYCODE_PAUSE:

                        reboot();
                        break;  
                }
            }
        }


        delayMs( 1000 );
        
    }while( 1 );
    

} 