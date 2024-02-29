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

extern tgfTextOverlay    con;

tgfBitmap               screen;
tgfBitmap               background;

long              selectorWindowIdx;
long              selectorCursorPos;
long              selectorWindowHeight;
char              selectorFileNames[26][_MAXFILENAMELENGTH + 1];

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

ulong init()
{
   ulong rv;
   ulong i;

   rv = 0;

   bspInit();
         
   setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );

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
      toPrint( &con, (char*)"\nCan't alloc screen1\n" );
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


int main()
{
   int         i;
   int         rv;
   
   volatile int   j;
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
   selectorWindowHeight = 22;

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
                     if(  selectorFileNames[selectorCursorPos + 1 ][0] != 0x00 )
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
            }
         }
      }
   
   }while( 1 );
   

} 