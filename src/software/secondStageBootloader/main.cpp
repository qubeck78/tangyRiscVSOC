#include "main.h"
#include <cstring>
#include <climits>
#include <math.h> 

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h"  

#include "../gfxLib/ff.h" 


extern tgfTextOverlay    con;

tgfBitmap             screen;
tgfBitmap             background;


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

   con.textAttributes = 0x08;


   toSetCursorPos( &con, 80 - 19, 26 ); toPrint( &con, (char*) "   |.\\__/.|    (~\\" );
   toSetCursorPos( &con, 80 - 19, 27 ); toPrint( &con, (char*) "   | O O  |     ) )" );
   toSetCursorPos( &con, 80 - 19, 28 ); toPrint( &con, (char*) " _.|  T   |_   ( (" );   
   toSetCursorPos( &con, 80 - 19, 29 ); toPrint( &con, (char*) "- ((---- ((-------" );

   toSetCursorPos( &con, 0, 27 );
   toPrint( &con, (char*) "tangyRiscVSOC" );

   toSetCursorPos( &con, 0, 28 );
   toPrint( &con, (char*) "bootloader" );

   toSetCursorPos( &con, 0, 29 );
   toPrint( &con, (char*) "B20240225" )
;
   con.textAttributes = 0x8f;

   toSetCursorPos( &con, 29, 2 );
   toPrint( &con, (char*) "Select program to load" );
   

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
            }
         }
      }
   
   }while( 1 );
   

} 