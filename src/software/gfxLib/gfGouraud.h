#ifndef _GFGOURAUD_H
#define _GFGOURAUD_H

#include "gfTypes.h"
#include "gfBitmap.h"

typedef struct _tgfPoint3D
{
	float x3D;
	float y3D;
	float z3D;

	float x3DT;
	float y3DT;
	float z3DT;

	short x2D;
	short y2D;
	ushort z2D;

	uchar r;
	uchar g;
	uchar b;

}tgfPoint3D;


typedef struct _tgfTriangle3D
{
	tgfPoint3D 	*a;
	tgfPoint3D 	*b;
	tgfPoint3D 	*c;

	tgfBitmap   *texture;

	short        aTx2D;
	short        aTy2D;

	short        bTx2D;
	short        bTy2D;

	short        cTx2D;
	short        cTy2D;

}tgfTriangle3D;


long inline gfGouraudEdge( tgfPoint3D *e1, tgfPoint3D *e2, tgfPoint3D *p );

ulong gfGouraudDrawTriangle( tgfBitmap *bmp, tgfTriangle3D *triangle );
ulong gfGouraudDrawTriangleFloat( tgfBitmap *bmp, tgfTriangle3D *triangle );
ulong gfGouraudDrawTriangleBlt( tgfBitmap *bmp, tgfTriangle3D *triangle );

ulong gfGouraudDrawTexturedTriangle( tgfBitmap *bmp, tgfTriangle3D *triangle );
ulong gfGouraudDrawTexturedTriangleFloat( tgfBitmap *bmp, tgfTriangle3D *triangle );
ulong gfGouraudDrawTexturedTriangleBlt( tgfBitmap *bmp, tgfTriangle3D *triangle );

ulong gfGouraudDrawTexturedTriangleZBuffer( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle );
ulong gfGouraudDrawTexturedTriangleZBufferBlt( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle );

ulong gfGouraudDrawTriangleZBuffer( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle );
ulong gfGouraudDrawTriangleZBufferBlt( tgfBitmap *bmp, tgfBitmap *zBuffer, tgfTriangle3D *triangle );

#endif
