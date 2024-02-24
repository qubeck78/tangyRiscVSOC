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
#include "../gfxLib/gfJPEG.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h"  

#include "../gfxLib/ff.h" 


extern tgfTextOverlay    con;

tgfBitmap             screen1;
tgfBitmap             background;

short                *audioData;
ulong                 audioDataLength;


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
   screen1.width        = 320;
   screen1.rowWidth     = 512;

   screen1.height       = 240;
   
   screen1.flags        = 0;
   screen1.transparentColor= 0;
   screen1.buffer          = osAlloc( screen1.rowWidth * screen1.height * 2, OS_ALLOC_MEMF_CHIP ); //osAlloc( 320 * 240 * 2 );
   
   if( screen1.buffer == NULL )
   {
      toPrint( &con, (char*)"\nCan't alloc screen1\n" );
      do{}while( 1 );
   } 
   
   //display first buffer
   gfDisplayBitmap( &screen1 );


   gfFillRect( &screen1, 0, 0, screen1.width - 1, screen1.height - 1 , gfColor( 0, 0, 0 ) ); 
   
   con.textAttributes = 0x8f;

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

   //config audio
   //i2s freq 48kHz @ 80Mhz base clock
   aud->i2sClockConfig = 0x0034001a;

   //fifo read div to 2 ( 24kHz frequency )
   aud->fifoReadConfig = 0x01;

   //stop dma
   aud->audioDmaConfig = 0x00;         

   return rv;
}


int main()
{
   int         i;
   int         rv;
   
   tosUIEvent     event; 
   tosFile        in;
   ulong          nbr;
   ulong          bufStatus;

   init();

   toPrint( &con, (char*) "Audio sample test: " );

   rv = gfLoadBitmapFS( &background, (char*) "0:/snd/interloper.gbm" );
   if( !rv )
   {
      gfBlitBitmap( &screen1, &background, 0, 0 );
      osFree( background.buffer );
      
      background.buffer = NULL;
   }


   audioDataLength = osFSize( (char*)"0:/snd/interloper.raw" );   

   audioData = (short*)osAlloc( audioDataLength, OS_ALLOC_MEMF_CHIP );

   if( !audioData )
   {
      toPrint( &con, (char*) "Error, can't alloc ram for sample\n" );

      do{}while( 1 );
   }

   if( osFOpen( &in, (char*)"0:/snd/interloper.raw", OS_FILE_READ ) )
   {
      toPrint( &con, (char*) "Error, can't open snd/interloper.raw  file\n" );

      do{}while( 1 );

   }

   toPrint( &con, (char*)"loading, this is going to take a moment... " );

   osFRead( &in, (uchar*)audioData, audioDataLength, &nbr );

   osFClose( &in );

   toPrint( &con, (char*)"ok\n\nCarbon Based Lifeforms - Interloper ( clip )\n24kHz mono, 16-bit, DMA transfer w/o cpu interaction\n" );

   //play sample :)
   aud->audioDmaPointer = ( (ulong)audioData - _SYSTEM_MEMORY_BASE ) / 4;
   aud->audioDmaLength = ( audioDataLength / 4 ) - 1; //32 bit tranfer, 2 samples per count
   aud->audioDmaConfig  = 0x01;                //start dma transfer, looping disabled, mode: mono 


   bufStatus = 2; //refresh buf status

   do
   {

      nbr = aud->audioDmaStatus;

      if( nbr & 1 )
      {

         //buffer looped
         toPrint( &con, (char*)"_" );

         //restart dma
         aud->audioDmaConfig  = 0x00;  //stop audio dma
         aud->audioDmaConfig  = 0x01;  //start dma transfer, looping disabled, mode: mono 

      }

      if( ( nbr & 2 ) && ( bufStatus != 1 ) )
      {

         //2nd buffer half

         bufStatus = 1;
         toPrint( &con, (char*)"\\" );

      }else if( ( !( nbr & 2 ) ) && ( bufStatus != 0 ) )
      {

         //1st buffer half

         bufStatus = 0;
         toPrint( &con, (char*)"/" );

      }

   
      if( !osGetUIEvent( &event ) )
      { 
         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            switch( event.arg1 )
            {
               case _KEYCODE_PAUSE:

                  aud->audioDmaConfig = 0x00;   //stop dma transfer

                  reboot();
                  break;  
            }
         }
      }
   
   }while( 1 );
   

} 