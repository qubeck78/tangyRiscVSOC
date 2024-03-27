
#include "modPlayer.h"

#include <cstdio>

//HxCModPlayer
//https://github.com/jfdelnero/HxCModPlayer
#include "hxcmod.h"

#include "../gfxLib/bsp.h"

#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/osUIEvents.h"


#include "shellUI.h"


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

   //fifo read div to 2 ( 24kHz frequency )
   aud->fifoReadConfig  = 0x1;

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
   hxcmod_setcfg( &modctx, 48000 / 2, 0, 0 );

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
   char           buf[60];
   ulong          i;
   ulong          j;


   uiDrawInfoWindow( (char*)"Loading", fileName, _UI_INFO_WINDOW_BUTTONS_NONE );


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


      if( modctx.song.length > 0 )
      {
         j =  modctx.tablepos * 40 / modctx.song.length;
      }
      else
      {
         j = 0;
      }

      strcpy( buf, "" );
      for( i = 0; i < 40; i++ )
      {
         if( i >= j )
         {
            strcat( buf, "\xb0" );
         }
         else
         {
            strcat( buf, "\xb1" );
         }
      }

      uiDrawInfoWindow( fileName, buf, _UI_INFO_WINDOW_BUTTONS_NONE );

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

               aud->audioDmaConfig  = 0x00;  //stop audio dma                  
               quitPlayer = 1;

         }
      }

   }while( !quitPlayer );

   osFree( audioModData );
   audioModData = NULL;

   return 0;
}
