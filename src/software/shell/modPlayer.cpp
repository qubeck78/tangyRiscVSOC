
#include "modPlayer.h"


//HxCModPlayer
//https://github.com/jfdelnero/HxCModPlayer
#include "hxcmod.h"

modcontext  modctx;
short      *audioData;
ulong       audioDataLength;
short      *audioDataL;
short      *audioDataH;
short      *audioModData;
ulong       audioModDataLength;

ulong mpInit()
{
   ulong rv;

   rv = 0;

   //config audio
   
   //i2s freq 48kHz @ 80Mhz base clock
   aud->i2sClockConfig  = 0x0034001a;

   //fifo read div to 3 ( 16kHz frequency )
   aud->fifoReadConfig  = 0x2;

   //stop dma
   aud->audioDmaConfig  = 0x00;

   //alloc audio buffer
   audioDataLength      = 16384;   //8K samples

   audioData            = (short*)osAlloc( audioDataLength, OS_ALLOC_MEMF_CHIP ); 

   audioDataL           = &audioData[0];
   audioDataH           = &audioData[audioDataLength / 4];

   //init hxcmod
   hxcmod_init( &modctx );

   //config hxcmod
   hxcmod_setcfg( &modctx, 48000 / 3, 0, 0 );

   return rv;
}

ulong mpPlay( char *fileName )
{
   ulong          rv;
   tosUIEvent     event; 
   tosFile        in;
   ulong          nbr;
   ulong          audioDmaStatus;
   ulong          quitPlayer;


   audioModDataLength = osFSize( fileName );

   if( audioModDataLength  == 0 )
   {
      return 1;
   }

   audioModData = (short*)osAlloc( audioModDataLength, OS_ALLOC_MEMF_CHIP );

   if( !audioModData )
   {
      return 1;
   }

   if( osFOpen( &in, fileName, OS_FILE_READ ) )
   {

      osFree( audioModData );
      audioModData = NULL;

      return 1;

   }

   osFRead( &in, (uchar*)audioModData, audioModDataLength, &nbr );

   osFClose( &in );

   hxcmod_load( &modctx, (void*)audioModData, audioModDataLength  );

   //pre-fill lower part of the buffer
   //length in samples ( 16-bit) -> half of the buffer
   hxcmod_fillbuffer( &modctx, audioDataL, audioDataLength / 4, NULL );

   //play audio buffer :)
   aud->audioDmaPointer = ( (ulong)audioData - _SYSTEM_MEMORY_BASE ) / 4;
   aud->audioDmaLength  = ( audioDataLength / 4 ) - 1;      //32 bit tranfer, 2 samples per count
   aud->audioDmaConfig  = 0x04 | 0x01;                      //start dma transfer, looping enabled, mode: mono 


   quitPlayer = 0;

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
               case _KEYCODE_ESC:

                  aud->audioDmaConfig  = 0x00;  //stop audio dma
                  
                  quitPlayer = 1;

                  break;  
            }
         }
      }
 

   }while( !quitPlayer );

   osFree( audioModData );
   audioModData = NULL;

   return 0;
}
