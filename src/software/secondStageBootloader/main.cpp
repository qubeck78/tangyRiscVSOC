#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/osUIEvents.h"


#include "main.h"
#include "ui.h"
#include "srec.h"

extern BSP_T            *bsp;
extern ulong             random_state;
extern tgfTextOverlay    con;


extern void(*bootLoaderEntry)(void);

tgfBitmap                screen;
tgfBitmap                background;

long                     selectorWindowIdx;
long                     selectorCursorPos;
long                     selectorWindowHeight;
char                     selectorFileNames[26][_MAXFILENAMELENGTH + 1];
char                     buf[512];
char                     path[512];

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

      }
      
   return 0;
} 

//custom BSP init, since we are using first 0.5MB of SDRAM for code
int bootloaderBspInit()
{
    random_state            = ( bsp->tickTimerValue << 16 ) | ( bsp->tickTimerValue ^ 0xf123 );

    osAllocInit();
    osAllocAddNode( 0, ( void* )( _SYSTEM_MEMORY_BASE + 0x80000 ), _SYSTEM_MEMORY_SIZE - 0x80000, OS_ALLOC_MEMF_CHIP );

    bsp->videoMuxMode       = _VIDEOMODE_320_TEXT80_OVER_GFX; 
    
    //connect gfxlib con to hardware text overlay   
    con.type                = GF_TEXT_OVERLAY_TYPE_HARDWARE;
    con.flags               = 0;
    con.width               = 80;               //clear whole buffer
    con.height              = 30;
    con.cursX               = 0;
    con.cursY               = 0;
    con.textAttributes      = 0x0f;
    con.font                = NULL;
    con.textBuffer          = (uchar*) 0x6d40; //hw text mode buffer address

    toCls( &con );

    con.textAttributes      = 0x8f; 

    bootLoaderEntry = (void(*)())0x0; 

    return 0;
} 



ulong init()
{
   ulong rv;
   ulong i;

   rv = 0;

   bootloaderBspInit();
         
   toPrint( &con, ( char* )"Bootloader...\n" );

   
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

   //init filesystem
   rv = osFInit();


   if( rv )
   {
      toPrint( &con, ( char* )"SD init error!" );
      
      do{
      }while( 1 );      
   }

   return rv;
}

ulong loadSrecFile( char *path )
{
   tosFile  in;
   ulong    rv;
   ulong    i;

   uiRedrawConsole();


   if( osFOpen( &in, path, OS_FILE_READ ) )
   {
      return 1;
   }


   uiDrawLoadingScreen( path );

   i = 0;

   while( !osFGetS( &in, (uchar*)buf, sizeof( buf) - 1 ) )
   {

      con.textAttributes = 0x8f;
      toSetCursorPos( &con, 40 - 2, 14 );
      toPrintF( &con, "%04X", i++ );

      rv = 0;

      if( buf[0] == 'S' )
      {
               
         switch( buf[1] )
         {
            case '1':
               rv = decodeAndSaveS1_2_3Record( buf, 1 );
               break;
               
            case '2':
               rv = decodeAndSaveS1_2_3Record( buf, 2 );
               break;

            case '3':
               rv = decodeAndSaveS1_2_3Record( buf, 3 );
               break;
               
            case '0':
            case '4':
            case '5':
            case '6':
               rv = 0;
               break;
               
            case '7':
               rv = decodeAndExecuteS7_8_9Record( buf, 7 );
               break;
               
            case '8':
            
               rv = decodeAndExecuteS7_8_9Record( buf, 8 );
               break;

            case '9':
            
               rv = decodeAndExecuteS7_8_9Record( buf, 9 );
               break;
               
            default:
               
               rv = 2;               
         }
      
      } 

      if( rv )
      {
         break;
      }
   }

   osFClose( &in );

   //shouldn't return
   return 1;
}

int main()
{
   int            rv;
   tosUIEvent     event; 

   init();

   rv = gfLoadBitmapFS( &background, (char*) "0:/sys/bootbg.gbm" );
   gfBlitBitmap( &screen, &background, 0, 0 );

   uiInit();

   uiRedrawConsole();

   //reset dir cursors
   selectorWindowIdx       = 0;
   selectorCursorPos       = 0;
   
   //default selector window height
   selectorWindowHeight    = 22;

   uiReadDirAndFillSelectorWindowContents();
   uiDrawSelectorWindowContents();

   do
   {

   
      while( !osGetUIEvent( &event ) )
      { 
         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            switch( event.arg1 )
            {
               case _KEYCODE_PAUSE:

                  reboot();
                  break;  

               case _KEYCODE_UP:
               
                  if( selectorCursorPos > 0 )
                  {
                     selectorCursorPos--;
                  }
                  else
                  {
                     selectorCursorPos = selectorWindowHeight - 1;
                     selectorWindowIdx -= selectorWindowHeight;
                     
                     if( selectorWindowIdx < 0 )
                     {
                        selectorWindowIdx = 0;
                        selectorCursorPos = 0;
                     }

                     uiReadDirAndFillSelectorWindowContents();

                  }

                  uiDrawSelectorWindowContents();
                  break;

               case _KEYCODE_DOWN:

                  if( selectorCursorPos < ( selectorWindowHeight - 1 ) )
                  {
                     if( selectorFileNames[selectorCursorPos + 1 ][0] != 0x00 )
                     {
                        selectorCursorPos++;
                     }
                     
                  }else
                  {
                     selectorCursorPos    = 0;
                     selectorWindowIdx    += selectorWindowHeight;
                     
                     uiReadDirAndFillSelectorWindowContents();
                  }
                  uiDrawSelectorWindowContents();
                  break;

               case _KEYCODE_ENTER:

                  strcpy( path, "0:apps/" );
                  strcat( path, selectorFileNames[ selectorCursorPos ] );

                  loadSrecFile( path );

                  uiRedrawConsole();
                  uiDrawSelectorWindowContents();

                  break;
            }
         }
      }
   
   }while( 1 );
   

} 