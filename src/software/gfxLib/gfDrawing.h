#ifndef _GFDRAWING_H
#define _GFDRAWING_H

#include "gfTypes.h"
#include "gfBitmap.h"

// B 4:0
// 76543210
//    76543

// G 10:5
// 1
// 09876543210
//    76543210
// 765432

// R 15:11
// 111111
// 5432109876543210
//         76543210
//         76543
// 76543

#define gfColor( r, g, b ) ( ushort )((((ushort)b >> 3) & 31 ) | (((ushort)g & 252 ) << 3 ) | (((ushort)r & 248 ) << 8 ))
#define gfColorGetR( color ) ( ushort )(( color >> 8) & 0xf8 )
#define gfColorGetG( color ) ( ushort )(( color >> 3) & 0xfc )
#define gfColorGetB( color ) ( ushort )(( color << 3) & 0xf8 )


ulong gfPlot( tgfBitmap *bmp, short x, short y, ushort color );
#define gfPlotF( bmp, x, y, color) (( ushort* ) bmp->buffer )[ x + ( bmp->width * y ) ] = color;
ulong gfPlotA( tgfBitmap *bmp, short x, short y, ushort color, uchar alpha );

ushort gfGetPixel( tgfBitmap *bmp, short x, short y );


ulong gfLine( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color );
ulong gfCircle( tgfBitmap *bmp, short xm, short ym, short r, ushort color );
ulong gfEllipse( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color );
ulong gfFillRect( tgfBitmap *bmp, short x1, short y1, short x2, short y2, ushort color );

#endif
