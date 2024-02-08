#include "main.h"
#include <cstring>
#include <climits>

//#define _DMARAMTEST

unsigned long *displayRam;
int screenIndex;
unsigned long *uartDataReg;
unsigned long *uartStatusReg;
unsigned char  *gfxRamB;
unsigned short *gfxRamW;
unsigned long *gfxRamL;

void (*bootEntry)(void);

char buf[128];

unsigned int random_state = 3242323459;

int randomNumber()
{
    unsigned int r = random_state;
    r ^= r << 13;
    r ^= r >> 17;
    r ^= r << 5;
    random_state = r;
    return (int)(r & INT_MAX);
} 

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
			displayRam[ screenIndex++ ] = 0x8f00 | c;
		}
	}

	return 0;
}

int uartGetC()
{
	volatile int j;

	if ( *uartStatusReg & 1 )
	{				
		return *uartDataReg;
	}
	else
	{
		return -1;
	}
}

void hexDigit(char *string,char digit)
{
	digit &= 0x0f;
	
    if( digit<10 )
    {
		string[0] = digit + '0';
		string[1] = 0;
    }
	else
	{
		string[0] = digit + 'a' - 10;
		string[1] = 0;
    }
}

void itoaHex2Digits( int value, char* str )
{
	hexDigit(&str[0], ( value >> 4 ) & 0x0f );
	hexDigit(&str[1], ( value ) & 0x0f );
}

void itoaHex8Digits( int value, char* str )
{
	hexDigit(&str[0], ( value >> 28 ) & 0x0f );
	hexDigit(&str[1], ( value >> 24 ) & 0x0f );

	hexDigit(&str[2], ( value >> 20 ) & 0x0f );
	hexDigit(&str[3], ( value >> 16 ) & 0x0f );

	hexDigit(&str[4], ( value >> 12 ) & 0x0f );
	hexDigit(&str[5], ( value >> 8 ) & 0x0f );

	hexDigit(&str[6], ( value >> 4) & 0x0f );
	hexDigit(&str[7], ( value ) & 0x0f );
}
 
int main()
{
	int i;
	volatile int j;
	int k;
	int uartData;
	unsigned int randomStateStore;
	unsigned long rndL;
	unsigned long memL;
	unsigned short rndW;
	unsigned char rndB;
	unsigned long *wrPtr;
	
	displayRam = (unsigned long *)0x10000000;
	uartDataReg = (unsigned long *)0xf0000000;
	uartStatusReg = (unsigned long *)0xf0000004;
	
	/*
	//cyclone III version 2MB
	gfxRamB = ( unsigned char *) 0x00200000;
	gfxRamW = ( unsigned short *)0x00200000;
	gfxRamL = ( unsigned long *) 0x00200000;
	*/

	//cyclone iv gx version 8MB
	gfxRamB = ( unsigned char *) 0x20000000;
	gfxRamW = ( unsigned short *)0x20000000;
	gfxRamL = ( unsigned long *) 0x20000000;
	
	screenIndex = 0;	

	
	
	for( i = 0; i < 1200 ; i++ )
	{
	  displayRam[i] = 0x0f00;
	}


	for( i = 0; i < 160*240; i++ )
	{
	 gfxRamL[i] = 0;
	}
	
	
	print( (char*)"RiscV Bootloader test program\n" );
	
	//jump to test rom
	//asm(" la a5, 0x00a00000\n jalr a5\n" );
	
	
	
	k = 0;
	do
	{
		
		screenIndex = 40 * 10;

		for( i = 0; i < 40; i++ )
		{


			if( k < 40 )
			{
				if( i <= k )
				{
					print( (char*)"#" );
				}
				else
				{
					print( (char*)" " );
				}
			}
			else
			{
				if( i <= ( k - 40 ) )
				{
					print( (char*)" " );
				}
				else
				{
					print( (char*)"#" );
				}


			}
		}	

		k++;
		if( k >=80 )
		{
			k = 0;
		}

	#ifdef _DMARAMTEST
	randomStateStore = random_state;
	
	for( i = 0; i < ( 1024 * 1024 ) * 8; i+=4 )
	{
		rndL = randomNumber();	
		gfxRamB[ i ] = rndL & 0xff;
		gfxRamB[ i+1 ] = ( rndL >> 8 )& 0xff;
		gfxRamB[ i+2 ] = ( rndL >> 16 )& 0xff;
		gfxRamB[ i+3 ] = ( rndL >> 24 )& 0xff;
	}
	
	
	for( i = 0; i < ( ( 1024 * 1024 ) * 8 ) / 4; i++ )
	{
		gfxRamL[ i ] = gfxRamL[ i ] ^ 0xffffffff;
	}
	for( i = 0; i < ( ( 1024 * 1024 ) * 8 ) / 4; i++ )
	{
		gfxRamL[ i ] = gfxRamL[ i ] ^ 0xffffffff;
	}
	
	random_state = randomStateStore;

	for( i = 0; i < ( ( 1024 * 1024 ) * 8 ) / 4; i++ )
	{
	
		rndL = randomNumber();
		memL = gfxRamL[ i ];
		
		if( memL != rndL )
		{
		
			print(" error at ");
			itoaHex8Digits( i, buf );
			print( buf );
			print(" ");
			
			itoaHex8Digits( rndL, buf );
			print( buf );
			print(" ");
			
			itoaHex8Digits( memL, buf );
			print( buf );
			do{}while( 1 );
		}
	}
	#endif
	


	
	for( j = 0; j < 10000; j++ );

	}while( 1 );

} 