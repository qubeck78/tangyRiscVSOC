#include "main.h"
#include <cstring>
#include <climits>

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
tgfBitmap 			 	 screen2;


tgfBitmap				 background;
tgfBitmap				 asteroid1;
tgfBitmap				 asteroid2;


#define NUM_OF_ASTEROIDS	10

typedef struct _tasteroid
{

	tgfBitmap	*bmp;
	
	ushort		 enabled;

	ushort		 width;
	ushort		 height;

	long		 positionX;
	long		 speedX;

	short		 positionY;

}tasteroid;


tasteroid asteroids[NUM_OF_ASTEROIDS];

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

	rv = 0;

	bspInit();
		
	
	setVideoMode( _VIDEOMODE_320_TEXT40_OVER_GFX );
	
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

	screen2.width			= 320;
	screen2.rowWidth		= 512;

	screen2.height   		= 240;
	
	screen2.flags			= 0;
	screen2.transparentColor= 0;
	screen2.buffer          = osAlloc( screen2.rowWidth * screen2.height * 2, OS_ALLOC_MEMF_CHIP );	//osAlloc( 320 * 240 * 2 );
	
	if( screen2.buffer == NULL )
	{
		toPrint( &con, (char*)"\nCan't alloc screen2\n" );
		do{}while( 1 );
	} 		
	
	//display first buffer
	gfDisplayBitmap( &screen1 );


	gfFillRect( &screen1, 0, 0, screen1.width - 1, screen1.height - 1 , gfColor( 0, 0, 0 ) ); 
	gfFillRect( &screen2, 0, 0, screen2.width - 1, screen2.height - 1 , gfColor( 0, 0, 0 ) ); 
	
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


	rv = gfLoadBitmapFS( &asteroid1, (char*)"0:demos/asteroid2.gbm" );

	asteroid1.flags 			|= GF_BITMAP_FLAG_TRANSPARENT;
	asteroid1.transparentColor 	 = 0x0;

	rv = gfLoadBitmapFS( &background, (char*)"0:demos/spacebackground3.gbm" );

	asteroid2.flags 			|= GF_BITMAP_FLAG_TRANSPARENT;
	asteroid2.transparentColor 	 = 0x0;

	return rv;
}

ulong anim( tgfBitmap *pscr )
{
	ulong 		 i;
	tasteroid 	*rock;

	//copy background to screen buffer

	blt->bltConfig0			= 0x2001;	//32 bit copy
	blt->bltSrcAddress 		= ( ulong )(( ( ulong )background.buffer - _SYSTEM_MEMORY_BASE ) / 4);
	blt->bltDstAddress 		= ( ulong )(( ( ulong )pscr->buffer - _SYSTEM_MEMORY_BASE ) / 4);
	blt->bltTransferHeight	= 239;
	blt->bltTransferWidth	= 160;
	blt->bltSrcModulo		= 0;
	blt->bltDstModulo		= 96;
	blt->bltValue			= 0x00000000;	
	
	//run blitter
	blt->bltStatus			= 0x1;
	
	//wait for blitter to complete operation
	do{}while( ! ( blt->bltStatus & 1 ) );


	for( i = 0; i < NUM_OF_ASTEROIDS; i++ )
	{
		rock = &asteroids[i];

		if( rock->enabled )
		{
			
			gfBlitScaledBitmap( pscr, rock->bmp, rock->positionX >> 16 , rock->positionY, rock->width, rock->height );

		}
	}


	return 0;
}

ulong initAnim()
{
	ulong 		 i;
	tasteroid 	*rock;
	float		 scale;

	for( i = 0; i < NUM_OF_ASTEROIDS; i++ )
	{
		rock = &asteroids[i];

		rock->bmp = &asteroid1;
		
		rock->enabled = 1;

		rock->positionY = randomNumber() % 220;

		scale = ((float)( NUM_OF_ASTEROIDS - i ) * 1.1f );

		rock->width = rock->bmp->width / scale;
		rock->height = rock->bmp->height / scale;
		rock->positionX = -rock->width - ( randomNumber() % 100 );
		rock->positionX <<= 16;
		
		rock->speedX =  ( ( i + 1 ) << 18 ) / NUM_OF_ASTEROIDS;

	}

	return 0;
}

ulong moveAsteroids()
{
	ulong 		 i;
	tasteroid 	*rock;

	for( i = 0; i < NUM_OF_ASTEROIDS; i++ )
	{
		rock = &asteroids[i];

		if( rock->enabled )
		{
			rock->positionX += rock->speedX;

			if( rock->positionX > ( 320 << 16 ) )
			{
				rock->positionX = -rock->width;
				rock->positionX <<= 16;
				rock->positionY = randomNumber() % 220;

			}

		}

	}

	return 0;
}

int main()
{
	int 			i;
	int 			rv;
	
	volatile int 	j;
	tosUIEvent		event; 

	
	init();
	initAnim();

	do
	{


		gfDisplayBitmap( &screen2 );
		do{}while( ! bsp->videoVSync );
		
		anim( &screen1 );
		moveAsteroids();

		gfDisplayBitmap( &screen1 );
		do{}while( ! bsp->videoVSync );
		
		anim( &screen2 );		
		moveAsteroids();
		
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