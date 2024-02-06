#ifndef _GFFONT_H
#define _GFFONT_H

#include "gfTypes.h"
#include "gfBitmap.h"

#define GF_FONT_TYPE_MONO_BITMAP_FIXED_WIDTH	0x0001
#define GF_FONT_TYPE_MONO_BITMAP_VAR_WIDTH   	0x0002
#define GF_FONT_TYPE_ALPHA4_BITMAP_FIXED_WIDTH	0x0003
#define GF_FONT_TYPE_ALPHA4_BITMAP_VAR_WIDTH   	0x0004


#define GF_FONT_FLAG_TRANSPARENT  		1
#define GF_FONT_FLAG_ALPHA_BACKGROUND	2

typedef struct _tgfFont
{
	ushort   type;
	ushort   flags;

	ushort   width;
	ushort   height;

	ushort   charColor;
	ushort   backgroundColor;

	uchar    firstChar;
	uchar    lastChar;

	uchar   *charWidths;
	void    *charBuffer;

}tgfFont;

#define GF_TEXT_OVERLAY_TYPE_SOFTWARE       0x0000
#define GF_TEXT_OVERLAY_TYPE_HARDWARE       0x8000

#define GF_TEXT_OVERLAY_FLAG_SHOW_CURSOR    0x0001
typedef struct _tgfTextOverlay
{
	ushort   type;
	ushort   flags;

	ushort   width;
	ushort   height;

	ushort   cursX;
	ushort   cursY;
	uchar    textAttributes;

	tgfFont *font;

	uchar   *textBuffer;
	
}tgfTextOverlay;



ulong gfLoadFontFS( tgfFont *dest, char *fileName );

short gfPutChar( tgfBitmap *bmp, tgfFont *font, short x, short y, char c );
short gfPutString( tgfBitmap *bmp, tgfFont *font, short x, short y, char *string );

ulong gfDrawTextOverlay( tgfBitmap *bmp, tgfTextOverlay *textOverlay, short x, short y );

ulong toSetCursorPos( tgfTextOverlay *overlay, ushort cursX, ushort cursY );
ulong toCls( tgfTextOverlay *overlay );
ulong toScrollUp( tgfTextOverlay *overlay );
ulong toPrint( tgfTextOverlay *overlay, char *string );
ulong toPrintF( tgfTextOverlay *overlay, char *format, ... );



#endif
