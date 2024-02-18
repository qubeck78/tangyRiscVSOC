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

//https://github.com/jfdelnero/HxCModPlayer
#include "hxcmod.h"

extern tgfTextOverlay    con;

tgfBitmap             screen1;
tgfBitmap             background;

ulong                 audI;
short                *audioModData;
ulong                 audioModDataLength;

modcontext            modctx;

msample              *audioBuf;
ulong                audioBufIdx;
ulong                audioBufMaxIdx;


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
         
   setVideoMode( _VIDEOMODE_TEXT80_ONLY );
      
   con.textAttributes = 0x0a;

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

short audioGenSample()
{
   short rv;

   if( audioBufIdx >= audioBufMaxIdx )
   {
      audioBufIdx = 0;
   }

   rv = audioBuf[ ( audioBufIdx >> 1 ) ];

   audioBufIdx++;

   return rv;

}


int audioTestMain()
{
   ushort sample;
   ulong fifoData;
   ulong i;


   
   i = 0;

   while( !( aud->audioFiFoStatus & 4 ) )
   {

      sample = (ushort)audioGenSample();

      fifoData = (ushort)sample | ( (ushort)sample << 16 );

      aud->audioFiFoData = fifoData;
   }

   return 0;
}


int main()
{
   int         i;
   int         rv;
   
   volatile int   j;
   tosUIEvent     event; 
   tosFile        in;
   ulong          nbr;

   audI = 0;
   
   init();

   toPrint( &con, (char*) "Audio mod test\n\n" );

   audioBufIdx    = 0;
   audioBufMaxIdx = 1048576 * 6;

   audioBuf = (msample*)osAlloc( audioBufMaxIdx, OS_ALLOC_MEMF_CHIP );
   if( !audioBuf )
   {
      toPrint( &con, (char*) "Error, can't alloc ram for audio buffer\n" );

      do{}while( 1 );

   }

   audioModDataLength = 43926;

   audioModData = (short*)osAlloc( audioModDataLength, OS_ALLOC_MEMF_CHIP );

   if( !audioModData )
   {
      toPrint( &con, (char*) "Error, can't alloc ram for module\n" );

      do{}while( 1 );
   }

   if( osFOpen( &in, (char*)"0:/snd/echoing.mod", OS_FILE_READ ) )
   {
      toPrint( &con, (char*) "Error, can't open module file\n" );

      do{}while( 1 );

   }

   toPrint( &con, (char*)"Loading mod\n" );

   osFRead( &in, (uchar*)audioModData, audioModDataLength, &nbr );

   osFClose( &in );

   toPrint( &con, (char*)"Converting to sample\n" );

   hxcmod_init( &modctx );
   hxcmod_setcfg( &modctx, 24000, 0, 0 );
   hxcmod_load( &modctx, (void*)audioModData, audioModDataLength  );


   hxcmod_fillbuffer( &modctx, audioBuf, audioBufMaxIdx / 2, NULL );

   toPrint( &con, (char*)"Playing\n" );

   do
   {

      audioTestMain();
   
      if( !osGetUIEvent( &event ) )
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