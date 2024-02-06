#include "main.h"
#include <cstring>
#include "../gfxLib/bsp.h"

BSP_T 				*bsp 		= ( BSP_T *) 				0xf0000000;	//registers base address
_UART_REGISTERS_T 	*uart0		= ( _UART_REGISTERS_T *)	0xf0400000; //uart 0 base address


int screenIndex;
unsigned short *displayRam; 

void (*bootEntry)(void) = (void(*)())0x0;

char buf[128];

#define _BOOTLOADER_PROTECTION_ADDR ( 8 * 1024 )
#define _TXT_ATTR 					0x3f00

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
			screenIndex -= screenIndex % 40;
			screenIndex += 40;
			if( screenIndex >= 880 )
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

		//for( j = 0; j < 10; j++ );
		
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
int decodeAndSaveS1Record( char *buf )
{
	int i, idx;
	int rv;
	int address;
	int recordLength;
	
	unsigned char *memPtr;
	
	memPtr = 0;
	
	recordLength = hexToIByte( buf, 2 );
	
	if( recordLength == -1 ) return 1;
	
	rv = hexToIByte( buf, 4 );
	
	if( rv == -1 ) return 1;
	address = rv << 8;
	
	rv = hexToIByte( buf, 6 );
	
	if( rv == -1 ) return 1;
	address |= rv;
	
	if( address < _BOOTLOADER_PROTECTION_ADDR ) return 2;
	
	for( i = 0; i < recordLength - 3; i++ )
	{
		rv = hexToIByte( buf, 8 + i * 2 );
		if( rv == -1 ) return 1;
		
		memPtr[ address + i ] = rv;
	
	}
		
	return 0;
}

int decodeAndSaveS2Record( char *buf )
{
	int i, idx;
	int rv;
	int address;
	int recordLength;
	
	unsigned char *memPtr;
	
	memPtr = 0;
	
	recordLength = hexToIByte( buf, 2 );
	
	if( recordLength == -1 ) return 1;
	
	rv = hexToIByte( buf, 4 );
	
	if( rv == -1 ) return 1;
	address = rv << 16;
	
	rv = hexToIByte( buf, 6 );
	
	if( rv == -1 ) return 1;
	address |= rv << 8;
	
	rv = hexToIByte( buf, 8 );
	
	if( rv == -1 ) return 1;
	address |= rv;

	if( address < _BOOTLOADER_PROTECTION_ADDR ) return 2;
	
	for( i = 0; i < recordLength - 4; i++ )
	{
		rv = hexToIByte( buf, 10 + i * 2 );
		if( rv == -1 ) return 1;
		
		memPtr[ address + i ] = rv;
	
	}
	
	return 0;
}

int decodeAndSaveS3Record( char *buf )
{
	int i, idx;
	int rv;
	int address;
	int recordLength;
	
	unsigned char *memPtr;
	
	memPtr = 0;
	
	recordLength = hexToIByte( buf, 2 );
	
	if( recordLength == -1 ) return 1;
	
	rv = hexToIByte( buf, 4 );
	
	if( rv == -1 ) return 1;
	address = rv << 24;
	
	rv = hexToIByte( buf, 6 );
	
	if( rv == -1 ) return 1;
	address |= rv << 16;
	
	rv = hexToIByte( buf, 8 );
	
	if( rv == -1 ) return 1;
	address |= rv << 8;

	rv = hexToIByte( buf, 10 );
	
	if( rv == -1 ) return 1;
	address |= rv;

	if( address < _BOOTLOADER_PROTECTION_ADDR ) return 2;
	
	for( i = 0; i < recordLength - 5; i++ )
	{
		rv = hexToIByte( buf, 12 + i * 2 );
		if( rv == -1 ) return 1;
		
		memPtr[ address + i ] = rv;
	
	}
	
	return 0;
}


int decodeAndExecuteS8Record( char *buf )
{
	int rv;
	int address;

	rv = hexToIByte( buf, 4 );
	if( rv == -1 ) return 1;
	
	address = rv << 16;
	
	rv = hexToIByte( buf, 6 );
	if( rv == -1 ) return 1;
	
	address |= rv << 8;
	
	rv = hexToIByte( buf, 8 );
	if( rv == -1 ) return 1;
	
	address |= rv;
	
	print( (char*)"\nBOOT\n" );
	
	bootEntry = (void (*)(void)) address;

	(*bootEntry)();
	
	return 0;
}

int decodeAndExecuteS7Record( char *buf )
{
	int rv;
	int address;

	rv = hexToIByte( buf, 4 );
	if( rv == -1 ) return 1;
	
	address = rv << 24;
	
	rv = hexToIByte( buf, 6 );
	if( rv == -1 ) return 1;
	
	address |= rv << 16;
	
	rv = hexToIByte( buf, 8 );
	if( rv == -1 ) return 1;
	
	address |= rv << 8;
	
	rv = hexToIByte( buf, 10 );
	if( rv == -1 ) return 1;
	
	address |= rv;

	print( (char*)"\nBOOT\n" );
	
	bootEntry = (void (*)(void)) address;

	(*bootEntry)();
	
	return 0;
}

int decodeAndExecuteS9Record( char *buf )
{
	int rv;
	int address;

	rv = hexToIByte( buf, 4 );
	if( rv == -1 ) return 1;
	
	address = rv << 8;
	
	rv = hexToIByte( buf, 6 );
	if( rv == -1 ) return 1;
	
	address |= rv;

	print( (char*)"\nBOOT\n" );

	bootEntry = (void (*)(void)) address;
	
	(*bootEntry)();
	
	return 0;
	
}

int main()
{
	int i;
	volatile int j;
	int k;
	int uartData;

	displayRam 		= ( unsigned short * )0x6d40;
	
	
	
	//txt mode only
	bsp->videoMuxMode = 0x0;
	
	
	screenIndex = 0;	

	for( i = 0; i < 1200 ; i++ )
	{
	  displayRam[i] = _TXT_ATTR;
	}



	print( (char*)"\n\nTangyRiscVSOC bootloader B20240206\n\nWaiting for data\n\n" );
	
	for( i = 0; i < 16; i++ )
	{
		displayRam[ 24 + i ] = i << 12;
	}

	k = 0;
	uartData = -1;
	do
	{
		
		screenIndex = 40 * 5;

		for( i = 0; i < 40; i++ )
		{

			if( k < 40 )
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
				if( i <= ( k - 40 ) )
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
		if( k >=80 )
		{
			k = 0;
		}

		for( j = 0; j < 100000; j++ )
		{
			uartData = uartGetC();
			if( uartData == 'S' ) break;	
		}

	}while( uartData != 'S' );
	print( (char*)"Receiving:'" );

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
					k = decodeAndSaveS1Record( buf );
					break;
					
				case '2':
					k = decodeAndSaveS2Record( buf );
					break;

				case '3':
					k = decodeAndSaveS3Record( buf );
					break;
					
				case '0':
				case '4':
				case '5':
				case '6':
					k = 0;
					break;
					
				case '7':
					k = decodeAndExecuteS7Record( buf );
					break;
					
				case '8':
				
					k = decodeAndExecuteS8Record( buf );
					break;

				case '9':
				
					k = decodeAndExecuteS9Record( buf );
					break;
					
				default:
					
					k = 2;					
					do{}while( 1 );
			}
		
			switch( k )
			{
				//ok
				case 0:
					//print( ( char *) "." );
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