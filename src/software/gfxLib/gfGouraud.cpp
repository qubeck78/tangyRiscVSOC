#include "gfGouraud.h"
#include "gfDrawing.h"
#include <stdlib.h>

#if defined( _GFXLIB_RISCV_FATFS ) || defined( _GFXLIB_MC68K_FATFS )

#include "bsp.h"

extern BSP_T *bsp;

#endif



//https://austinmorlan.com/posts/drawing_a_triangle/


long inline gfGouraudEdge( tgfPoint3D *e1, tgfPoint3D *e2, tgfPoint3D *p )
{
	tgfPoint3D a,b;

/*float Edge(Point v0, Point v1, Point p)
{
	// Vector from edge origin to test point
	Vector a = p - v0;

	// Vector from edge origin to edge end
	Vector b = v1 - v0;

	// 2D cross product
	// Zero: Point is on edge
	// Positive: Point is right of edge
	// Negative: Point is left of edge
	return a.x * b.y - a.y * b.x;
}*/


	a.x2D = p->x2D - e1->x2D;
	a.y2D = p->y2D - e1->y2D;

	b.x2D = e2->x2D - e1->x2D;
	b.y2D = e2->y2D - e1->y2D;

	return ( ( a.x2D * b.y2D ) - ( a.y2D * b.x2D ) );
}


ulong  gfGouraudDrawTriangleBlt( tgfBitmap *bmp, tgfTriangle3D *triangle )
{
	#if defined( _GFXLIB_RISCV_FATFS )

	//bounding box calculated in hw

	blt->bltTransferWidth		= 320;			//screen size
	blt->bltTransferHeight	= 240;

	blt->bltDstModulo				= 320;			//screen modulo

	//pass triangle coordinates/colors to gouraud hardware

	blt->c0CX = triangle->c->x2D;
	blt->c0CY = triangle->c->y2D;

	blt->c0BX = triangle->b->x2D;
	blt->c0BY = triangle->b->y2D;

	blt->c0AX = triangle->a->x2D;
	blt->c0AY = triangle->a->y2D;

	blt->c0it0A = triangle->a->r;
	blt->c0it0B = triangle->b->r;
	blt->c0it0C = triangle->c->r;

	blt->c0it1A = triangle->a->g;
	blt->c0it1B = triangle->b->g;
	blt->c0it1C = triangle->c->g;

	blt->c0it2A = triangle->a->b;
	blt->c0it2B = triangle->b->b;
	blt->c0it2C = triangle->c->b;

	if( blt->c0Area > 0 )
	{
		//triangle facing front

		//config blitter to draw triangle using gouraud iterators

		blt->bltConfig0			= 0x0003;		//blitter mode - gouraud RGB triangle, zbuffer disabled
		blt->bltDstAddress 		= ( ulong )(( ( ulong )bmp->buffer - _SYSTEM_MEMORY_BASE ) / 2);


		//bsp->bltDstModulo		= 320;			//screen width

		blt->bltStatus			= 0x1;			//run

		//wait until complete
		do{}while( ! ( blt->bltStatus & 1 ) );
	}

	return 0;

	#else

	return 1;

	#endif
}

ulong  gfGouraudDrawTexturedTriangleBlt( tgfBitmap *bmp, tgfTriangle3D *triangle )
{

	#if defined( _GFXLIB_RISCV_FATFS )

	//bounding box calculated in hw

	blt->bltTransferWidth	= 320;			//screen size
	blt->bltTransferHeight	= 240;

	blt->bltDstModulo		= 320;			//screen modulo


	//pass triangle coordinates/texture coordinates to gouraud hardware
	
	blt->c0CX = triangle->c->x2D;
	blt->c0CY = triangle->c->y2D;
	
	blt->c0BX = triangle->b->x2D;
	blt->c0BY = triangle->b->y2D;
	
	blt->c0AX = triangle->a->x2D;
	blt->c0AY = triangle->a->y2D;
	
	blt->c0it0A = triangle->aTx2D;
	blt->c0it0B = triangle->bTx2D;
	blt->c0it0C = triangle->cTx2D;

	blt->c0it1A = triangle->aTy2D;
	blt->c0it1B = triangle->bTy2D;
	blt->c0it1C = triangle->cTy2D;
	
	blt->c0it2A = triangle->a->r;
	blt->c0it2B = triangle->b->r;
	blt->c0it2C = triangle->c->r;

	if( blt->c0Area > 0 )
	{
		//triangle facing front
	
		//config blitter to draw textured triangle using gouraud iterators
		
		blt->bltConfig0			= 0x0405;		//blitter mode: 
												//textured RGB triangle with light on iterator 2, 
												//texture size 256x256 px
												//zbuffer disabled
												//
												//trigger bounding box calc
		
		blt->bltDstAddress 		= ( ulong )(( ( ulong )bmp->buffer - _SYSTEM_MEMORY_BASE ) / 2);

		blt->bltSrcAddress 		= ( ulong )(( ( ulong )triangle->texture->buffer - _SYSTEM_MEMORY_BASE ) / 2);

	
		blt->bltStatus			= 0x1;			//run

		//wait until complete
		do{}while( ! ( blt->bltStatus & 1 ) );
	}

	return 0;

	#else

	return  1;

	#endif

}

ulong gfGouraudDrawTexturedTriangleZBufferBlt( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle )
{

	#if defined( _GFXLIB_RISCV_FATFS )

	//bounding box calculated in hw

	blt->bltTransferWidth	= 320;			//screen size
	blt->bltTransferHeight	= 240;

	blt->bltDstModulo		= 320;			//screen modulo


	//pass triangle coordinates/texture coordinates to gouraud hardware
	
	blt->c0CX = triangle->c->x2D;
	blt->c0CY = triangle->c->y2D;
	blt->c0CZ = triangle->c->z2D;
	
	blt->c0BX = triangle->b->x2D;
	blt->c0BY = triangle->b->y2D;
	blt->c0BZ = triangle->b->z2D;
	
	blt->c0AX = triangle->a->x2D;
	blt->c0AY = triangle->a->y2D;
	blt->c0AZ = triangle->a->z2D;
	
	blt->c0it0A = triangle->aTx2D;
	blt->c0it0B = triangle->bTx2D;
	blt->c0it0C = triangle->cTx2D;

	blt->c0it1A = triangle->aTy2D;
	blt->c0it1B = triangle->bTy2D;
	blt->c0it1C = triangle->cTy2D;
	
	blt->c0it2A = triangle->a->r;
	blt->c0it2B = triangle->b->r;
	blt->c0it2C = triangle->c->r;

	if( blt->c0Area > 0 )
	{
		//triangle facing front
	
		//config blitter to draw textured triangle using gouraud iterators
		
		blt->bltConfig0			= 0x1405;		//blitter mode: 
												//textured RGB triangle with light on iterator 2, 
												//texture size 256x256 px
												//zbuffer enabled
												//
												//trigger bounding box calc
		
		blt->bltDstAddress 				= ( ulong )(( ( ulong )bmp->buffer - _SYSTEM_MEMORY_BASE ) / 2);

		blt->bltSrcAddress 				= ( ulong )(( ( ulong )triangle->texture->buffer - _SYSTEM_MEMORY_BASE ) / 2);

		blt->bltGouraudZBufferAddress	= ( ulong )(( ( ulong )zBuffer->buffer - _SYSTEM_MEMORY_BASE ) / 2);
	
		blt->bltStatus			= 0x1;			//run

		//wait until complete
		do{}while( ! ( blt->bltStatus & 1 ) );
	}

	return 0;

	#else

	return  1;

	#endif

}

ulong gfGouraudDrawTriangleZBufferBlt( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle )
{

	#if defined( _GFXLIB_RISCV_FATFS )

	//bounding box calculated in hw

	blt->bltTransferWidth	= 320;			//screen size
	blt->bltTransferHeight	= 240;

	blt->bltDstModulo		= 320;			//screen modulo


	//pass triangle coordinates/texture coordinates to gouraud hardware
	
	blt->c0CX = triangle->c->x2D;
	blt->c0CY = triangle->c->y2D;
	blt->c0CZ = triangle->c->z2D;
	
	blt->c0BX = triangle->b->x2D;
	blt->c0BY = triangle->b->y2D;
	blt->c0BZ = triangle->b->z2D;
	
	blt->c0AX = triangle->a->x2D;
	blt->c0AY = triangle->a->y2D;
	blt->c0AZ = triangle->a->z2D;
	
	blt->c0it0A = triangle->a->r;
	blt->c0it0B = triangle->b->r;
	blt->c0it0C = triangle->c->r;

	blt->c0it1A = triangle->a->g;
	blt->c0it1B = triangle->b->g;
	blt->c0it1C = triangle->c->g;
	
	blt->c0it2A = triangle->a->b;
	blt->c0it2B = triangle->b->b;
	blt->c0it2C = triangle->c->b;

	if( blt->c0Area > 0 )
	{
		//triangle facing front
	
		//config blitter to draw textured triangle using gouraud iterators
		
		blt->bltConfig0			= 0x1203;		//blitter mode: 
												//gouraud triangle  
												//
												//zbuffer enabled
												//
												//trigger bounding box calc
		
		blt->bltDstAddress 				= ( ulong )(( ( ulong )bmp->buffer - _SYSTEM_MEMORY_BASE ) / 2);


		blt->bltGouraudZBufferAddress	= ( ulong )(( ( ulong )zBuffer->buffer - _SYSTEM_MEMORY_BASE ) / 2);
	
		blt->bltStatus			= 0x1;			//run

		//wait until complete
		do{}while( ! ( blt->bltStatus & 1 ) );
	}

	return 0;

	#else

	return  1;

	#endif

}


/*
//int, no hw
ulong  gfGouraudDrawTriangle( tgfBitmap *bmp, tgfTriangle3D *triangle )
{
	short 	    x;
	short		y;

	short       xMin;
	short       xMax;
	short       yMin;
	short       yMax;

	long        eba;
	long        ecb;
	long        eac;

	long		areal;

	long		wbal;
	long		wcbl;
	long		wacl;

	long       r;
	long       g;
	long       b;

	tgfPoint3D 	p;

	ushort		*bmpPtr;


	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}


  if( xMin < 0 )
  {
	xMin = 0;
  }
  if( yMin < 0 )
  {
	yMin = 0;
  }

  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }

  if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }


	areal = gfGouraudEdge( triangle->c, triangle->b, triangle->a );

	if( areal > 0 )
	{

		for( y = yMin; y <= yMax; y++ )
		{

			bmpPtr = NULL;

			for( x = xMin; x <= xMax; x++ )
			{

				p.x2D = x;
				p.y2D = y;

				eba = gfGouraudEdge( triangle->b, triangle->a, &p );
				ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
				eac = gfGouraudEdge( triangle->a, triangle->c, &p );

				//check if point inside triangle

				if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
				{
					wbal = ( eba << 8 ) / areal;
					wcbl = ( ecb << 8 ) / areal;
					wacl = ( eac << 8 ) / areal;

					r = ( ( wcbl * (long)triangle->a->r ) + ( wacl * (long)triangle->b->r ) + ( wbal * (long)triangle->c->r ) ) >> 8;
					g = ( ( wcbl * (long)triangle->a->g ) + ( wacl * (long)triangle->b->g ) + ( wbal * (long)triangle->c->g ) ) >> 8;
					b = ( ( wcbl * (long)triangle->a->b ) + ( wacl * (long)triangle->b->b ) + ( wbal * (long)triangle->c->b ) ) >> 8;

					if( !bmpPtr )
					{
						//pixel not yet drawn in this line
						bmpPtr = &((ushort*)( bmp->buffer ))[ x + ( y * bmp-> width ) ];
					}

					*bmpPtr++ = gfColor( r, g, b );

				}
				else
				{
					if( bmpPtr )
					{
						//finished drawing this line, go to next one
						break;
					}
				}
			}
		}
	}

	return 0;
}

ulong gfGouraudDrawTriangleFloat( tgfBitmap *bmp, tgfTriangle3D *triangle )
{
	short 	    x;
	short		y;

	short       xMin;
	short       xMax;
	short       yMin;
	short       yMax;

	long        eba;
	long        ecb;
	long        eac;

	float       area;

	float       wba;
	float       wcb;
	float       wac;

	short       r;
	short       g;
	short       b;

	tgfPoint3D 	p;


	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}

  if ( xMin < 0 )
  {
	xMin = 0;
  }
  if ( yMin < 0 )
  {
	yMin = 0;
  }
  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }
 if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }

	area = gfGouraudEdge( triangle->c, triangle->b, triangle->a );

	if( area > 0 )
	for( y = yMin; y <= yMax; y++ )
	{
		for( x = xMin; x <= xMax; x++ )
		{

			p.x2D = x;
			p.y2D = y;

			eba = gfGouraudEdge( triangle->b, triangle->a, &p );
			ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
			eac = gfGouraudEdge( triangle->a, triangle->c, &p );

			//check if point inside triangle

			if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
			{

				wba = eba / area;
				wcb = ecb / area;
				wac = eac / area;

				r = ( wcb * ( float )triangle->a->r ) + ( wac * ( float )triangle->b->r ) + ( wba * ( float )triangle->c->r );
				g = ( wcb * ( float )triangle->a->g ) + ( wac * ( float )triangle->b->g ) + ( wba * ( float )triangle->c->g );
				b = ( wcb * ( float )triangle->a->b ) + ( wac * ( float )triangle->b->b ) + ( wba * ( float )triangle->c->b );


				gfPlotF( bmp, x, y, gfColor( r, g, b ) );

			}

		}
	}

	return 0;
}


ulong gfGouraudDrawTexturedTriangleFloat( tgfBitmap *bmp, tgfTriangle3D *triangle )
{

	short 		  x;
	short		  y;

	short       xMin;
	short       xMax;
	short       yMin;
	short       yMax;

	long        eba;
	long        ecb;
	long        eac;

	float       area;

	float       wba;
	float       wcb;
	float       wac;

	short       tx;
	short       ty;

	tgfPoint3D  p;

	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}

  if ( xMin < 0 )
  {
	xMin = 0;
  }
  if ( yMin < 0 )
  {
	yMin = 0;
  }
  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }
if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }


	area = gfGouraudEdge( triangle->c, triangle->b, triangle->a );

	if( area > 0 )
	for( y = yMin; y <= yMax; y++ )
	{
		for( x = xMin; x <= xMax; x++ )
		{

			p.x2D = x;
			p.y2D = y;

			eba = gfGouraudEdge( triangle->b, triangle->a, &p );
			ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
			eac = gfGouraudEdge( triangle->a, triangle->c, &p );

			//check if point inside triangle

			if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
			{

				wba = eba / area;
				wcb = ecb / area;
				wac = eac / area;


				tx = ( wcb * ( float )triangle->aTx2D ) + ( wac * ( float )triangle->bTx2D ) + ( wba * ( float )triangle->cTx2D );
				ty = ( wcb * ( float )triangle->aTy2D ) + ( wac * ( float )triangle->bTy2D ) + ( wba * ( float )triangle->cTy2D );


				gfPlotF( bmp, x, y, gfGetPixel( triangle->texture, tx, ty ) );

			}

		}
	}

	return 0;


}

ulong gfGouraudDrawTexturedTriangle( tgfBitmap *bmp, tgfTriangle3D *triangle )
{

	short 		  	 x;
	short		  	 y;
	ushort	    	 r;
	ushort		     g;
	ushort		     b;
	unsigned short   texturePixel;

	short       	 xMin;
	short       	 xMax;
	short       	 yMin;
	short       	 yMax;

	long        	 eba;
	long        	 ecb;
	long        	 eac;

	long			 areal;
	unsigned long 	 areaNorm;

	long			 wbal;
	long			 wcbl;
	long			 wacl;


	short       	 tx;
	short       	 ty;
	unsigned char	 tl;

	ushort			*bmpPtr;

	tgfPoint3D  	 p;

	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}

  if ( xMin < 0 )
  {
	xMin = 0;
  }
  if ( yMin < 0 )
  {
	yMin = 0;
  }
  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }
 if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }

	areal = gfGouraudEdge( triangle->c, triangle->b, triangle->a );



	if( areal > 0 )
	{
		//areaNorm = 0x100000000 / areal;
		areaNorm = 0xffffffff / areal;


	for( y = yMin; y <= yMax; y++ )
	{

		bmpPtr = NULL;

		for( x = xMin; x <= xMax; x++ )
		{

			p.x2D = x;
			p.y2D = y;

			eba = gfGouraudEdge( triangle->b, triangle->a, &p );
			ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
			eac = gfGouraudEdge( triangle->a, triangle->c, &p );

			//check if point inside triangle

			if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
			{


				//wbal = ( eba << 8 ) / areal;
				//wcbl = ( ecb << 8 ) / areal;
				//wacl = ( eac << 8 ) / areal;
				 

				wbal = ( eba * areaNorm ) >> 24;
				wcbl = ( ecb * areaNorm ) >> 24;
				wacl = ( eac * areaNorm ) >> 24;


				tx = ( ( wcbl * ( long )triangle->aTx2D ) + ( wacl * ( long )triangle->bTx2D ) + ( wbal * ( long )triangle->cTx2D ) ) >> 8;
				ty = ( ( wcbl * ( long )triangle->aTy2D ) + ( wacl * ( long )triangle->bTy2D ) + ( wbal * ( long )triangle->cTy2D ) ) >> 8;
				tl = ( ( wcbl * ( long )triangle->a->r ) + ( wacl * ( long )triangle->b->r ) + ( wbal * ( long )triangle->c->r ) ) >> 8;


				//gfPlotF( bmp, x, y, gfGetPixel( triangle->texture, tx, ty ) );

				if( !bmpPtr )
				{
					//pixel not yet drawn in this line
					bmpPtr = &((ushort*)( bmp->buffer ))[ x + ( y * bmp-> width ) ];
				}

				texturePixel = gfGetPixel( triangle->texture, tx, ty );

				r = gfColorGetR( texturePixel ) * tl;
				g = gfColorGetG( texturePixel ) * tl;
				b = gfColorGetB( texturePixel ) * tl;

				*bmpPtr++ = gfColor( r >> 8 , g >> 8 , b >> 8  );


			}
			else
			{
				if( bmpPtr )
				{
					//finished drawing this line, go to next one
					break;
				}
			}
		}
	}
	}
	return 0;

}


*/

ulong gfGouraudDrawTriangleZBuffer( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle )
{
	short 	     x;
	short		 y;

	short        xMin;
	short        xMax;
	short        yMin;
	short        yMax;

	long         eba;
	long         ecb;
	long         eac;

	long		 areal;

	long		 wbal;
	long		 wcbl;
	long		 wacl;

	long       	 r;
	long       	 g;
	long       	 b;
	ulong      	 cz;

	tgfPoint3D 	 p;

	ushort		*bmpPtr;
	ushort      *zBufPtr;



	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}


  if( xMin < 0 )
  {
	xMin = 0;
  }
  if( yMin < 0 )
  {
	yMin = 0;
  }

  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }

  if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }


	areal = gfGouraudEdge( triangle->c, triangle->b, triangle->a );

	if( areal > 0 )
	{

		for( y = yMin; y <= yMax; y++ )
		{

			bmpPtr = NULL;
			zBufPtr = &((ushort*)( zBuffer->buffer ))[ ( y * bmp->rowWidth ) ];

			for( x = xMin; x <= xMax; x++ )
			{

				p.x2D = x;
				p.y2D = y;

				eba = gfGouraudEdge( triangle->b, triangle->a, &p );
				ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
				eac = gfGouraudEdge( triangle->a, triangle->c, &p );

				//check if point inside triangle

				if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
				{
					wbal = ( eba << 8 ) / areal;
					wcbl = ( ecb << 8 ) / areal;
					wacl = ( eac << 8 ) / areal;

					r = ( ( wcbl * (long)triangle->a->r ) + ( wacl * (long)triangle->b->r ) + ( wbal * (long)triangle->c->r ) ) >> 8;
					g = ( ( wcbl * (long)triangle->a->g ) + ( wacl * (long)triangle->b->g ) + ( wbal * (long)triangle->c->g ) ) >> 8;
					b = ( ( wcbl * (long)triangle->a->b ) + ( wacl * (long)triangle->b->b ) + ( wbal * (long)triangle->c->b ) ) >> 8;

					cz = ( ( wcbl * ( long )triangle->a->z2D ) + ( wacl * ( long )triangle->b->z2D ) + ( wbal * ( long )triangle->c->z2D ) ) >> 8;



					if( !bmpPtr )
						{
							//pixel not yet drawn in this line
						bmpPtr = &((ushort*)( bmp->buffer ))[ x + ( y * bmp->rowWidth ) ];
					}


                    //current pixel is closer than existing one
					if( cz <= zBufPtr[x] )
					{
						zBufPtr[x] = cz;
						*bmpPtr++ = gfColor( r, g, b );
					}
					else
					{
                        bmpPtr++;
                    }
				}
				else
				{
					if( bmpPtr )
					{
						//finished drawing this line, go to next one
						break;
					}
				}
			}
		}
	}

	return 0;
}

ulong gfGouraudDrawTexturedTriangleZBuffer( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle )
{

	short 		  	 x;
	short		  	 y;
	ushort	    	 r;
	ushort		     g;
	ushort		     b;
	ushort   		 texturePixel;

	short       	 xMin;
	short       	 xMax;
	short       	 yMin;
	short       	 yMax;

	long        	 eba;
	long        	 ecb;
	long        	 eac;

	long			 areal;
	ulong 	 		 areaNorm;

	long			 wbal;
	long			 wcbl;
	long			 wacl;


	short       	 tx;
	short       	 ty;
	unsigned char	 tl;

	ulong           cz;

	ushort			*bmpPtr;
	ushort          *zBufPtr;

	tgfPoint3D  	 p;

	xMin = bmp->width - 1;
	yMin = bmp->height - 1;
	xMax = 0;
	yMax = 0;

	if( triangle->a->x2D > xMax )
	{
		xMax = triangle->a->x2D;
	}
	if( triangle->b->x2D > xMax )
	{
		xMax = triangle->b->x2D;
	}
	if( triangle->c->x2D > xMax )
	{
		xMax = triangle->c->x2D;
	}

	if( triangle->a->x2D < xMin )
	{
		xMin = triangle->a->x2D;
	}
	if( triangle->b->x2D < xMin )
	{
		xMin = triangle->b->x2D;
	}
	if( triangle->c->x2D < xMin )
	{
		xMin = triangle->c->x2D;
	}

	if( triangle->a->y2D > yMax )
	{
		yMax = triangle->a->y2D;
	}
	if( triangle->b->y2D > yMax )
	{
		yMax = triangle->b->y2D;
	}
	if( triangle->c->y2D > yMax )
	{
		yMax = triangle->c->y2D;
	}

	if( triangle->a->y2D < yMin )
	{
		yMin = triangle->a->y2D;
	}
	if( triangle->b->y2D < yMin )
	{
		yMin = triangle->b->y2D;
	}
	if( triangle->c->y2D < yMin )
	{
		yMin = triangle->c->y2D;
	}

  if ( xMin < 0 )
  {
	xMin = 0;
  }
  if ( yMin < 0 )
  {
	yMin = 0;
  }
  if ( xMax < 0 )
  {
	xMax = 0;
  }
  if ( yMax < 0 )
  {
	yMax = 0;
  }

  if ( xMax >= bmp->width )
  {
	xMax = bmp->width - 1;
  }
  if ( yMax >= bmp->height )
  {
	yMax = bmp->height - 1;
  }
 if ( xMin >= bmp->width )
  {
	xMin = bmp->width - 1;
  }
  if ( yMin >= bmp->height )
  {
	yMin = bmp->height - 1;
  }

	areal = gfGouraudEdge( triangle->c, triangle->b, triangle->a );



	if( areal > 0 )
	{
		//areaNorm = 0x100000000 / areal;
		areaNorm = 0xffffffff / areal;


	for( y = yMin; y <= yMax; y++ )
	{

		bmpPtr = NULL;
		zBufPtr = &((ushort*)( zBuffer->buffer ))[ ( y * bmp->rowWidth ) ];

		for( x = xMin; x <= xMax; x++ )
		{

			p.x2D = x;
			p.y2D = y;

			eba = gfGouraudEdge( triangle->b, triangle->a, &p );
			ecb = gfGouraudEdge( triangle->c, triangle->b, &p );
			eac = gfGouraudEdge( triangle->a, triangle->c, &p );

			//check if point inside triangle

			if( ( eba >= 0 ) && ( ecb >= 0 ) && ( eac >= 0 ) )
			{


				//wbal = ( eba << 8 ) / areal;
				//wcbl = ( ecb << 8 ) / areal;
				//wacl = ( eac << 8 ) / areal;
				 

				wbal = ( eba * areaNorm ) >> 24;
				wcbl = ( ecb * areaNorm ) >> 24;
				wacl = ( eac * areaNorm ) >> 24;



				tx = ( ( wcbl * ( long )triangle->aTx2D ) + ( wacl * ( long )triangle->bTx2D ) + ( wbal * ( long )triangle->cTx2D ) ) >> 8;
				ty = ( ( wcbl * ( long )triangle->aTy2D ) + ( wacl * ( long )triangle->bTy2D ) + ( wbal * ( long )triangle->cTy2D ) ) >> 8;
				tl = ( ( wcbl * ( long )triangle->a->r ) + ( wacl * ( long )triangle->b->r ) + ( wbal * ( long )triangle->c->r ) ) >> 8;

				cz = ( ( wcbl * ( long )triangle->a->z2D ) + ( wacl * ( long )triangle->b->z2D ) + ( wbal * ( long )triangle->c->z2D ) ) >> 8;


				if( !bmpPtr )
				{
					//pixel not yet drawn in this line
					bmpPtr = &((ushort*)( bmp->buffer ))[ x + ( y * bmp->rowWidth ) ];
				}

				//current pixel is closer than existing one
				if( cz <= zBufPtr[x] )
				{
					//gfPlotF( zBuffer, x, y, cz );
					zBufPtr[x] = cz;

					texturePixel = gfGetPixel( triangle->texture, tx, ty );

					r = gfColorGetR( texturePixel ) * tl;
					g = gfColorGetG( texturePixel ) * tl;
					b = gfColorGetB( texturePixel ) * tl;

					*bmpPtr++ = gfColor( r >> 8 , g >> 8 , b >> 8  );
					//gfPlotF( bmp, x, y, gfColor( r >> 8 , g >> 8 , b >> 8  ) );

				}
				else
				{
					bmpPtr++;
				}

			}
			else
			{
				if( bmpPtr )
				{
					//finished drawing this line, go to next one
					break;
				}
			}
		}
	}
	}
	return 0;

}
