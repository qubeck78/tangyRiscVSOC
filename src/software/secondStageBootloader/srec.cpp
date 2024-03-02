#include "srec.h"

#include "../gfxLib/bsp.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfFont.h"

extern tgfTextOverlay    con;


extern void(*bootLoaderEntry)(void);


static int hexToIDigit( char *buf, int position )
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

static int hexToIByte( char *buf, int position )
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
      toPrint( &con, line );
   
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
   
   bootLoaderEntry = (void (*)(void)) address;

   (*bootLoaderEntry)();
   
   return 0;
} 
