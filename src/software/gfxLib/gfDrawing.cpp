#include "gfDrawing.h"
#include <math.h>

//http://members.chello.at/easyfilter/bresenham.html

#if defined ( _GFXLIB_RISCV_FATFS )

#include "bsp.h"

extern BSP_T *bsp;	//registers

#endif


ulong gfPlot( tgfBitmap *bmp, short x, short y, ushort color )
{
	ushort  *fb;

	if( bmp == NULL ) return 1;
	if( x < 0 ) return 1;
	if( y < 0 ) return 1;
	if( x >= bmp->width )   return 1;
	if( y >= bmp->height )  return 1;

	fb = (ushort *)bmp->buffer;
	fb[ x + ( bmp->rowWidth * y ) ] = color;

	return 0;
}

ushort gfGetPixel( tgfBitmap *bmp, short x, short y )
{
	ushort  *fb;

	if( bmp == NULL ) return 0;
	if( x < 0 ) return 0;
	if( y < 0 ) return 0;
	if( x >= bmp->width )   return 0;
	if( y >= bmp->height )  return 0;

	fb = (ushort *)bmp->buffer;
	return fb[ x + ( bmp->rowWidth * y ) ];
}

ulong gfPlotA( tgfBitmap *bmp, short x, short y, ushort color, uchar alpha )
{
  	ushort  *fb;
	ushort  basePixelColor;
	ulong 	r, g, b;

	if( bmp == NULL ) return 1;
	if( x < 0 ) return 1;
	if( y < 0 ) return 1;
	if( x >= bmp->width )   return 1;
	if( y >= bmp->height )  return 1;

	fb = (ushort *)bmp->buffer;



	basePixelColor = fb[ x + ( bmp->rowWidth * y ) ];

	r = gfColorGetR( basePixelColor ) * ( 255 - alpha );
	g = gfColorGetG( basePixelColor ) * ( 255 - alpha );
	b = gfColorGetB( basePixelColor ) * ( 255 - alpha );

	r += gfColorGetR( color ) * alpha;
	g += gfColorGetG( color ) * alpha;
	b += gfColorGetB( color ) * alpha;

	r = r >> 8;
	g = g >> 8;
    b = b >> 8;

	fb[ x + ( bmp->rowWidth * y ) ] = gfColor( r, g, b );

	return 0;
}



ulong gfLine( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color )
{

	short	dx;
	short	dy;
	short   sx;
	short   sy;
	short   err;
	short   e2;

	dx = gfAbs( x2 - x1 );
	sx =  x1<x2 ? 1: -1;

	dy = -gfAbs( y2 - y1 );
	sy = y1<y2 ? 1: -1;

	err = dx + dy;

	for( ;; )
	{
		gfPlot( bmp, x1, y1, color );

		if( ( x1 == x2 ) && ( y1 == y2 ) )
		{
			break;
		}

		e2 = 2 * err;

		if( e2 >= dy )
		{
			err += dy;
			x1 += sx;
		}

		if( e2 <= dx )
		{
			err += dx;
			y1 += sy;
		}

	}

	return 0;
}

ulong gfCircle( tgfBitmap *bmp, short xm, short ym, short r, ushort color )
{
   short x = -r;
   short y = 0;
   short err = 2 - 2 * r; /* II. Quadrant */

   do
   {
	  gfPlot( bmp, xm - x, ym + y, color ); /*   I. Quadrant */
	  gfPlot( bmp, xm - y, ym - x, color ); /*  II. Quadrant */
	  gfPlot( bmp, xm + x, ym - y, color ); /* III. Quadrant */
	  gfPlot( bmp, xm + y, ym + x, color ); /*  IV. Quadrant */

	  r = err;

	  if(r <= y )
	  {
		err += ++y * 2 + 1;           /* e_xy+e_y < 0 */
	  }

	  if(r > x || err > y )
	  {
		err += ++x * 2 + 1; /* e_xy+e_x > 0 or no 2nd y-step */
	  }

   }while( x < 0 );

   return 0;
}

ulong gfEllipse( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color )
{

	long a = gfAbs( x2 - x1 );
	long b = gfAbs( y2 - y1 );
	long b1 = b & 1; /* values of diameter */

	long dx = 4 * ( 1 - a )* b * b;
	long dy = 4 * ( b1 + 1 ) * a * a; /* error increment */
	long err = dx + dy + ( b1 * a * a );
	long e2; /* error of 1.step */

	if( x1 > x2 )
	{

		x1 = x2;
		x2 += a;

	} /* if called with swapped points */



	if( y1 > y2 )
	{
		y1 = y2; /* .. exchange them */
	}

   y1 += ( b + 1 ) / 2;
   y2 = y1 - b1;   /* starting pixel */

   a *= 8 * a;
   b1 = 8 * b * b;

   do
   {
		gfPlot( bmp, x2, y1, color ); /*   I. Quadrant */
		gfPlot( bmp, x1, y1, color ); /*  II. Quadrant */
		gfPlot( bmp, x1, y2, color ); /* III. Quadrant */
		gfPlot( bmp, x2, y2, color ); /*  IV. Quadrant */

		e2 = 2 * err;
		if( e2 <= dy )
		{
			y1++;
			y2--;
			//err += dy += a;

			dy += a;
			err +=  dy;

		}  /* y step */

		if( ( e2 >= dx ) || ( 2 * err > dy ) )
		{
			x1++;
			x2--;

			//err += dx += b1;
			dx += b1;
			err += dx;
		} /* x step */

   }while( x1 <= x2);

   while( ( y1 - y2 ) < b )
   {  /* too early stop of flat ellipses a=1 */
	   gfPlot( bmp, x1 - 1, y1, color ); /* -> finish tip of ellipse */
	   gfPlot( bmp, x2 + 1, y1++, color );
	   gfPlot( bmp, x1 - 1, y2, color );
	   gfPlot( bmp, x2 + 1, y2--, color );
   }


	return 0;
}


ulong gfFillRect( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color )
{
	short 	 x;
	short	 y;
	ushort  *fb;
	short	 bw;
	short	 bh;
	
	if( !bmp ) return 1;

	if( x1 < 0 ) x1 = 0;
	if( y1 < 0 ) y1 = 0;
	if( x2 < 0 ) x2 = 0;
	if( y2 < 0 ) y2 = 0;

	if( x1 >= bmp->width ) x1 = bmp->width - 1;
	if( y1 >= bmp->height ) y1 = bmp->height - 1;
	if( x2 >= bmp->width ) x2 = bmp->width - 1;
	if( y2 >= bmp->height ) y2 = bmp->height - 1;

	if( y1 > y2 )
	{
		x = y2;
		y2 = y1;
		y1 = x;
	}

	if( x1 > x2 )
	{
		x = x2;
		x2 = x1;
		x1 = x;
	}

	

	#if defined ( _GFXLIB_RISCV_FATFS ) && defined ( _GFXLIB_HW_BLITTER_2D )
	//use blitter
	
	bw = x2 - x1 + 1;
	bh = y2 - y1 + 1;
	
	blt->bltConfig0			= 0x0000;	//fill with value
			
	blt->bltDstAddress 	= ( ulong )(( ( ulong ) &(( ushort* )bmp->buffer)[ ( ( y1 ) * bmp->rowWidth ) + x1 ] - _SYSTEM_MEMORY_BASE ) / 2);
	blt->bltDstModulo		= bmp->rowWidth - bw;

	blt->bltTransferWidth	= bw;
	blt->bltTransferHeight	= bh - 1;
			
	blt->bltValue			= color;
	
	blt->bltStatus			= 0x1;
	
	do{}while( ! ( blt->bltStatus & 1 ) ); 

	#else

	for( y = y1; y <= y2; y++ )
	{
		fb = &((ushort*)bmp->buffer)[ y * bmp->rowWidth + x1 ];

		for( x = x1; x <= x2; x++ )
		{
			*fb++ = color;
		}
	}
	
	#endif
	return 0;
}

