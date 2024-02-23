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

//
//This example uses HxCModPlayer
//
//https://github.com/jfdelnero/HxCModPlayer
//

#include "hxcmod.h"

extern tgfTextOverlay    con;

tgfBitmap                screen;
tgfBitmap                background;

char                     modFileName[256];

short                   *audioModData;
ulong                    audioModDataLength;

modcontext               modctx;

short                   *audioData;
ulong                    audioDataLength;
short                   *audioDataL;
short                   *audioDataH;




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

   toPrint( &con, (char*)"HxCModPlayer player, initializing...\n" );

   //alloc screen buffer
   screen.width            = 320;
   screen.rowWidth         = 512;

   screen.height           = 240;
   
   screen.flags            = 0;
   screen.transparentColor = 0;
   screen.buffer           = osAlloc( screen.rowWidth * screen.height * 2, OS_ALLOC_MEMF_CHIP ); 
   
   if( screen.buffer == NULL )
   {
      toPrint( &con, (char*)"\nCan't alloc screen\n" );
   } 
   
   //display first buffer
   gfDisplayBitmap( &screen );

   gfFillRect( &screen, 0, 0, screen.width - 1, screen.height - 1 , gfColor( 0, 0, 0 ) ); 
      
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


   rv = gfLoadBitmapFS( &background, (char*) "0:/snd/catHeadphones.gbm" );
   if( !rv )
   {
      gfBlitBitmap( &screen, &background, 0, 0 );
      osFree( background.buffer );
      
      background.buffer = NULL;
   }


   //config audio
   //i2s freq 48kHz @ 80Mhz base clock
   aud->i2sClockConfig = 0x0034001a;

   //fifo read div to 3 ( 16kHz frequency )
   aud->fifoReadConfig = 0x2;

   //stop dma
   aud->audioDmaConfig = 0x00;         

   //alloc audio buffer

   audioDataLength = 16384;   //8K samples

   audioData = (short*)osAlloc( audioDataLength, OS_ALLOC_MEMF_CHIP ); 

   audioDataL = &audioData[0];
   audioDataH = &audioData[audioDataLength / 4];
   

   //init hxcmod
   hxcmod_init( &modctx );

   //config hxcmod
   hxcmod_setcfg( &modctx, 16000, 0, 0 );

   return rv;
}




int main()
{
   int            i;
   int            rv;
   
   volatile int   j;
   tosUIEvent     event; 
   tosFile        in;
   ulong          nbr;
   ulong          audioDmaStatus;

   
   init();


//   strcpy( modFileName, (char*) "0:/snd/echoing.mod" );
//   strcpy( modFileName, (char*) "0:/snd/chill.mod" );
//   strcpy( modFileName, (char*) "0:/snd/dawn.mod" );
//   strcpy( modFileName, (char*) "0:/snd/elysium.mod" );
//   strcpy( modFileName, (char*) "0:/snd/spacedeb.mod" );
//   strcpy( modFileName, (char*) "0:/snd/pillusions.mod" );
   strcpy( modFileName, (char*) "0:/snd/pillusions2.mod" );
//   strcpy( modFileName, (char*) "0:/snd/odyssey.mod" );
//   strcpy( modFileName, (char*) "0:/snd/somewhere.mod" );
//   strcpy( modFileName, (char*) "0:/snd/sundown.mod" );
//   strcpy( modFileName, (char*) "0:/snd/nemesis.mod" );

 

   audioModDataLength = osFSize( modFileName );

   audioModData = (short*)osAlloc( audioModDataLength, OS_ALLOC_MEMF_CHIP );

   if( !audioModData )
   {
      toPrint( &con, (char*) "Error, can't alloc ram for module\n" );

      do{}while( 1 );
   }

   if( osFOpen( &in, modFileName, OS_FILE_READ ) )
   {
      toPrint( &con, (char*) "Error, can't open module file\n" );

      do{}while( 1 );

   }

   toPrintF( &con, (char*)"Loading %s ( %d )\n", modFileName, audioModDataLength );

   osFRead( &in, (uchar*)audioModData, audioModDataLength, &nbr );

   osFClose( &in );


   hxcmod_load( &modctx, (void*)audioModData, audioModDataLength  );

   con.textAttributes = 0x0f;
   
   toCls( &con );
   
   con.textAttributes = 0x8f;

   toPrintF( &con, (char*)"Playing %s ( %d ) via audio DMA\n", modFileName, audioModDataLength );


   //pre-fill lower part of the buffer
   //length in samples ( 16-bit) -> half of the buffer
   hxcmod_fillbuffer( &modctx, audioDataL, audioDataLength / 4, NULL );

   //play audio buffer :)

   aud->audioDmaPointer = ( (ulong)audioData - _SYSTEM_MEMORY_BASE ) / 4;
   aud->audioDmaLength  = ( audioDataLength / 4 ) - 1;      //32 bit tranfer, 2 samples per count
   aud->audioDmaConfig  = 0x01;                             //start dma transfer, mode: mono


   do
   {

      do
      {
         audioDmaStatus = aud->audioDmaStatus;
      }while( audioDmaStatus & 2 );

      //lower part of buffer is played, fill upper
      hxcmod_fillbuffer( &modctx, audioDataH, audioDataLength / 4, NULL );

      do
      {
         audioDmaStatus = aud->audioDmaStatus;
      }while( ( ! (audioDmaStatus & 2 ) ) );

      //upper part of buffer is played, fill lower
      hxcmod_fillbuffer( &modctx, audioDataL, audioDataLength / 4, NULL );

   
      while( !osGetUIEvent( &event ) )
      { 
         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            switch( event.arg1 )
            {
               case _KEYCODE_PAUSE:

                  aud->audioDmaConfig  = 0x00;  //stop audio dma
                  reboot();
                  break;  
            }
         }
      }
 

   }while( 1 );

} 