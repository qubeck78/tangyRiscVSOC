#include "main.h"
#include <cstring>
#include <climits>


unsigned short *displayRam;
int screenIndex;

char buf[128];


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
	
	displayRam = ( unsigned short * )0x6d40;
	
	screenIndex = 0;	

	
	
	for( i = 0; i < 1200 ; i++ )
	{
	  displayRam[i] = 0x0f00;
	}


	
	print( (char*)"RiscV Bootloader test program\n" );
	
	
	
	
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



	
	for( j = 0; j < 10000; j++ );

	}while( 1 );

} 