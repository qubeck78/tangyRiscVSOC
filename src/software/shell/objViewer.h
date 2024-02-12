#ifndef _OBJVIEWER_H
#define _OBJVIEWER_H



#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h"




int objvInit( void );
int objvView( char *fileName );

#endif
