
#include "osSerial.h"

#ifdef _GFXLIB_RISCV_FATFS

#include "bsp.h"


extern _UART_REGISTERS_T   *uart0;

#endif


ulong osSerialOpen( ulong serialNum, ulong baudRate )
{

   return 0;
}

ulong osSerialClose( ulong serialNum )
{

   return 0;
}


long  osSerialGetC( ulong serialNum )
{
   #ifdef _GFXLIB_RISCV_FATFS

      if ( uart0->uartStatus & 1 )
      {           
         return uart0->uartData;
      }
      else
      {
         return -1;
      }

   #endif

   return -1;
}

ulong osSerialClearRxFifo( ulong serialNum )
{
   while( osSerialGetC( serialNum ) != -1 );

   return 0;
}

ulong osSerialPutC( ulong serialNum, uchar c )
{
   #ifdef _GFXLIB_RISCV_FATFS

      while( ! ( uart0->uartStatus & 2 ) );
   
      uart0->uartData = (unsigned short)c;

      return 0;

   #endif

   return 1;

}

ulong osSerialGetS( ulong serialNum, char *buf, ulong maxLength, ulong timeoutMs )
{
   ulong idx;   
   char  c;
   long  rv;
   ulong startTicks;

   idx = 0;
   
   if( buf == NULL ) return 1;

   buf[0] = 0;

   startTicks = getTicks();

   do
   {

      do
      {
         
         rv = osSerialGetC( serialNum );

         if( getTicks() > startTicks + timeoutMs )
         {

            //timeout
            return 2;

         }

      }while( rv == -1 );

      c = (char) rv & 0xff;

      if( ( c != 13 ) && ( c != 10 ) )
      {
         if( idx < ( maxLength - 1 ) )
         {
            buf[idx++]  = c;
            buf[idx]    = 0;
         }
         else
         {
            //buffer overflow
            return 3;
         }
      }
      
   }while( c != 10 );

   return 0;
}

ulong osSerialPrint( ulong serialNum, char *buf )
{
   char c;

   if( buf == NULL ) 
   {
      return 1;
   }

   while( c = *buf++ )
   {
      osSerialPutC( serialNum, c );
   }

   return 0;

}