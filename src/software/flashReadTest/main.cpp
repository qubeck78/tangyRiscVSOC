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
#include "../gfxLib/osUIEvents.h"

#include "../gfxLib/ff.h" 

//https://www.asciiart.eu/image-to-ascii

extern tgfTextOverlay    con;

uchar flashDataBuffer[1024];


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

   
   return rv;
}


uchar flashSpiSendReceive( uchar txB )
{
   
   do
   {
   }while( ! ( spi1->spiStatus & 1 ) );

   spi1->spiData = txB;

   do
   {
   }while( ! ( spi1->spiStatus & 1 ) );

   return spi1->spiData;            // return received byte

}


int flashRead( ulong address, ulong length, uchar *buffer )
{
   ulong i;

   //cs low
   bsp->gpoPort &= ( 1 << 8 ) ^ 0xffffffff;

   //read
   flashSpiSendReceive( 0x03 );

   //address
   flashSpiSendReceive( ( address >> 16 ) & 0xff );
   flashSpiSendReceive( ( address >> 8 ) & 0xff );
   flashSpiSendReceive( address & 0xff );

   //read data
   for( i = 0; i < length; i++ )
   {
      buffer[i] = flashSpiSendReceive( 0xff );
   }


   //cs high
   bsp->gpoPort |= ( 1 << 8 );

   return 0;
}



int main()
{
   int            rv;

   ulong          i;
   ulong          flashAddress;

   tosUIEvent     event; 

   init();

   con.textAttributes   = 0x7a;
   toCls( &con );

   toPrint( &con, (char*) "Flash read test, reading configuration flash @0x600000\n\n" );


   con.textAttributes   = 0x7f;

   flashAddress = 0x600000;

   for( i = 0; i < 8; i++ )
   {
      flashRead( flashAddress, 256, flashDataBuffer );
      flashDataBuffer[256] = 0;
      
      flashAddress   += 256;

      toPrint( &con, (char*) flashDataBuffer );
   }

   flashRead( flashAddress, 20, flashDataBuffer );
   flashDataBuffer[20] = 0;
      
   flashAddress   += 20;

   toPrint( &con, (char*) flashDataBuffer );


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