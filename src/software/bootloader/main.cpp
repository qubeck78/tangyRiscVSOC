#include "main.h"
#include <cstring>
#include "../gfxLib/bsp.h"

BSP_T                *bsp     = ( BSP_T *)                  0xf0000000; //registers base address
_USBHOST_REGISTERS_T *usbhost = ( _USBHOST_REGISTERS_T *)   0xf0300000; //hid usb host base address
_UART_REGISTERS_T    *uart0   = ( _UART_REGISTERS_T *)      0xf0400000; //uart 0 base address
_AUDIO_REGISTERS_T   *aud     = ( _AUDIO_REGISTERS_T*)      0xf0600000; //i2s audio base address
_SPI_REGISTERS_T     *spi1    = ( _SPI_REGISTERS_T *)       0xf0700000; //spi 1 base address


ulong              screenIndex;
ushort            *displayRam; 

void (*bootEntry)(void) = (void(*)())0x0;

char buf[128];

#define _BOOTLOADER_PROTECTION_ADDR ( 8 * 1024 )
#define _TXT_ATTR                   0x3f00

int print( char *buf )
{
   char c;
   int i;

   i = 0;

   while( c = buf[ i++ ] )
   {  

      if( c == 13 )
      {

      }else if( c == 10 )
      {
         screenIndex -= screenIndex % 80;
         screenIndex += 80;
         if( screenIndex >= 2400 )
         {
            screenIndex = 0;
         }  
      }
      else
      {
         displayRam[ screenIndex++ ] = _TXT_ATTR | c;
      }
   }

   return 0;
}

int uartGetC()
{
   volatile int j;

   if ( uart0->uartStatus & 1 )
   {           
      return uart0->uartData;
   }
   else
   {
      return -1;
   }
}

int uartPutC( unsigned char c )
{
   while( ! ( uart0->uartStatus & 2 ) );
   uart0->uartData = (unsigned short)c;
   
   return 0;
}

int uartGetS( char *buf, int maxLength )
{
   int idx;
   volatile int j;
   
   char c;
   int rv;

   idx = 0;
   
   do
   {

      do
      {
         rv = uartGetC();
      }while( rv == -1 );

      c = (char) rv & 0xff;

      if( ( c != 13 ) && ( c != 10 ) )
      {
         if( idx < ( maxLength - 1 ) )
         {
            buf[idx++] = c;
            buf[idx] = 0;
         }
      }

      
   }while( c != 10 );

   return 0;
}


int hexToIDigit( char *buf, int position )
{
   char c;
   
   c = buf[ position ];
   
   if ( ( c >= '0' ) and ( c <='9' ) )
   {
      return c - '0';
   }else if ( ( c >='a' ) and ( c <='f' ) )
   {
      return c - 'a' + 10;
   }else if ( ( c >='A' ) and ( c <='F' ) )
   {
      return c - 'A' + 10;
   }
   else
   {
      return -1;
   }
}

int hexToIByte( char *buf, int position )
{
   int d1, d2;
   
   d1 = hexToIDigit( buf, position++ );
   if( d1 == -1 ) return -1;
   
   
   d2 = hexToIDigit( buf, position );
   if( d2 == -1 ) return -1;
   
   return ( d1 << 4 ) | d2;
}

int decodeAndDisplayS0Record( char *buf )
{
   int idx;
   int recordLength;
   int i,v;
   char line[8];
   
   recordLength = hexToIByte( buf, 1 );
   if( recordLength == -1 ) return 1;
   
   for( i = 0; i < recordLength - 3; i++ )
   {
      v = hexToIByte( buf, 7 + i * 2 );

      if( v == -1 ) return 1;
      
      line[0] = (char)v;
      line[1] = 0;
      print( line );
   
   }
   
   return 0;
}

int decodeAndSaveS1_2_3Record( char *buf, ulong recordType )
{
   int   rv;
   ulong i;
   ulong dataFieldIdx;
   ulong address;
   ulong recordLength;
   ulong addressFieldLength;

   unsigned char *memPtr;
   
   memPtr = 0;
   
   recordLength = hexToIByte( buf, 2 );
   
   if( recordLength == -1 ) return 1;
   

   switch( recordType )
   {


      case 1:

         addressFieldLength = 2;
         dataFieldIdx       = 8;
         break;

      case 2:

         addressFieldLength = 3;
         dataFieldIdx       = 10;
         break;

      case 3:

         addressFieldLength = 4;
         dataFieldIdx       = 12;
         break;


   }
   address = 0;

   for( i = 0; i < addressFieldLength; i++ )
   {

      rv = hexToIByte( buf, 4 + i * 2 );
      
      if( rv == -1 ) return 1;

      address <<= 8;
      address |= (uchar)rv;

   }

   if( address < _BOOTLOADER_PROTECTION_ADDR ) return 2;
   
   for( i = 0; i < recordLength - addressFieldLength - 1; i++ )
   {
      rv = hexToIByte( buf, dataFieldIdx + i * 2 );
      if( rv == -1 ) return 1;
      
      memPtr[ address + i ] = rv;
   
   }
   
   return 0;
}


int decodeAndExecuteS7_8_9Record( char *buf, ulong recordType )
{
   long  rv;
   ulong address;
   ulong i;
   ulong addressFieldLength;


   switch( recordType )
   {
      
      case 7:
         addressFieldLength = 4;
         break;

      case 8:
         addressFieldLength = 3;
         break;

      case 9:
         addressFieldLength = 2;
         break;

      default:
         return 1;
   }

   address = 0;

   for( i = 0; i < addressFieldLength; i++ )
   {
      rv = hexToIByte( buf, 4 + i * 2 );
      if( rv == -1 ) return 1;
   
      address <<= 8;
      address |= (uchar)rv;
   
   }

   print( (char*)"\nBOOT\n" );
   
   bootEntry = (void (*)(void)) address;

   (*bootEntry)();
   
   return 0;
}


void spaceDistance( ulong n )
{
   ulong i;

   for( i = 0 ; i < n; i++ )
   {
      print( (char*) " " );
   }

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

void loadSecondStageBootloader()
{

   print( (char*)"\nSecond stage\n" );

   flashRead( 0x700000, 0x20000, (uchar*)_SYSTEM_MEMORY_BASE );

   print( (char*)"BOOT\n" );

   bootEntry = (void (*)(void)) _SYSTEM_MEMORY_BASE;

   (*bootEntry)();

}

int main()
{
   int i;
   volatile int j;
   int k;
   int uartData;

   //stop audio dma
   aud->audioDmaConfig  = 0x00;         

   //80 column txt mode only
   bsp->videoMuxMode    = 0x0004;

   //clear usb hid fifo
   j = 0;
   while( ! ( usbhost->usbHidKeyboardStatus & 1 ) )
   {
      j |= usbhost->usbHidKeyboardData;
   }

   displayRam           = ( unsigned short * )0x6d40;
      
   
   screenIndex          = 0;  

   for( i = 0; i < 2400 ; i++ )
   {
     displayRam[i] = _TXT_ATTR;
   }


   print( (char*) "\n\n\n\n" );  

   spaceDistance( 40 - 13 ); print( (char*) "        |.\\__/.|    (~\\ \n" );
   spaceDistance( 40 - 13 ); print( (char*) "        | O O  |     ) ) \n" );
   spaceDistance( 40 - 13 ); print( (char*) "      _.|  T   |_   ( (  \n" );   
   spaceDistance( 40 - 13 ); print( (char*) "   .-- ((---- ((-------. \n" );
   spaceDistance( 40 - 13 ); print( (char*) "   |                   | \n" );
   spaceDistance( 40 - 13 ); print( (char*) "   |tangySOC bootloader| \n" );
   spaceDistance( 40 - 13 ); print( (char*) "   |     B20240301     | \n" );
   spaceDistance( 40 - 13 ); print( (char*) "   |                   | \n" );
   spaceDistance( 40 - 13 ); print( (char*) "   `-------------------` \n\n" );
   
   for( i = 0; i < 16; i++ )
   {
      displayRam[ i ] = i << 12;
   }

   

   k = 0;
   uartData = -1;
   do
   {
      
      screenIndex = 80 * 15 + 10;

      for( i = 0; i < 60; i++ )
      {

         if( k < 60 )
         {
            if( i <= k )
            {
               print( (char*)"\xb1" );
            }
            else
            {
               print( (char*)"\xb0" );
            }
         }
         else
         {
            if( i <= ( k - 60 ) )
            {
               print( (char*)"\xb0" );
            }
            else
            {
               print( (char*)"\xb1" );
            }


         }
      }  


      k++;
      if( k >= 120 )
      {
         k = 0;
      }

      for( j = 0; j < 100000; j++ )
      {
         uartData = uartGetC();
         if( uartData == 'S' ) break;  
      }

      if( ! ( usbhost->usbHidKeyboardStatus & 1 ) )
      {
         //key has been pressed

         j = 0;
         //clear usb hid fifo
         while( ! ( usbhost->usbHidKeyboardStatus & 1 ) )
         {
            j |= usbhost->usbHidKeyboardData;
         }

         //start second stage bootloader
         if( j != 0 )
         {
            loadSecondStageBootloader();
         }
      }


   }while( uartData != 'S' );

   print( (char*)"\n\nReceiving:'" );

   uartGetS( buf, sizeof( buf ) );
   //print( buf );
   
   if( !decodeAndDisplayS0Record( buf ) )
   {
      uartPutC( '*' );
   }
   else
   {
      uartPutC( '!' );
      print( (char*)"'\nERROR - please reset\n" );
      do{}while( 1 );
   }
   print( (char*)"'\n" );
   
   
   do{
   
      uartGetS( buf, sizeof( buf ) );

      
      if( buf[0] == 'S' )
      {
      
         k = 0;
         
         switch( buf[1] )
         {
            case '1':
               k = decodeAndSaveS1_2_3Record( buf, 1 );
               break;
               
            case '2':
               k = decodeAndSaveS1_2_3Record( buf, 2 );
               break;

            case '3':
               k = decodeAndSaveS1_2_3Record( buf, 3 );
               break;
               
            case '0':
            case '4':
            case '5':
            case '6':
               k = 0;
               break;
               
            case '7':
               k = decodeAndExecuteS7_8_9Record( buf, 7 );
               break;
               
            case '8':
            
               k = decodeAndExecuteS7_8_9Record( buf, 8 );
               break;

            case '9':
            
               k = decodeAndExecuteS7_8_9Record( buf, 9 );
               break;
               
            default:
               
               k = 2;               
               do{}while( 1 );
         }
      
         switch( k )
         {
            //ok
            case 0:
               uartPutC( '*' );
               break;
               
            //retransmission
            case 1:
            
               print( ( char *) "r" );
               uartPutC( 'r' );
               break;

            //dead in the water
            default:
               
               print( (char*)"\nUnrecoverable error - please reset\n" );

               uartPutC( '!' );
               
               do{}while( 1 );
               
               break;
         }
      }
   
   }while( 1 );

} 