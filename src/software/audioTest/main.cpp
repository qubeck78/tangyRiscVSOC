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


extern tgfTextOverlay	 con;

tgfBitmap 			 	 screen1;

ulong	audI;


short					sinT[512];


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
			
	setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );
	
	//alloc screen buffers
	screen1.width			= 320;
	screen1.rowWidth		= 512;

	screen1.height   		= 240;
	
	screen1.flags			= 0;
	screen1.transparentColor= 0;
	screen1.buffer          = osAlloc( screen1.rowWidth * screen1.height * 2, OS_ALLOC_MEMF_CHIP );	//osAlloc( 320 * 240 * 2 );
	
	if( screen1.buffer == NULL )
	{
		toPrint( &con, (char*)"\nCan't alloc screen1\n" );
		do{}while( 1 );
	} 
	
	//display first buffer
	gfDisplayBitmap( &screen1 );


	gfFillRect( &screen1, 0, 0, screen1.width - 1, screen1.height - 1 , gfColor( 0, 0, 0 ) ); 
	
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

	for( i = 0; i < 512; i++ )
	{
		sinT[i] = ( sin( i * ( 3.14159 / 256 ) ) * 32767 );
	}


	return rv;
}

short audioGenSample()
{
	short sample;

/*	sample = audI & 0xffff;
	audI += 1000;
*/

	sample = sinT[ audI % 512 ];

	audI += 11;


	return sample;

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

	//toPrint( &con, "." );

	return 0;
}


int main()
{
	int 			i;
	int 			rv;
	
	volatile int 	j;
	tosUIEvent		event; 

	audI = 0;
	
	init();
	toPrint( &con, (char*) "Audio test\n\n" );

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