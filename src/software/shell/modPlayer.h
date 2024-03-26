#ifndef _MODPLAYER_H
#define _MODPLAYER_H

#include "../gfxLib/gftypes.h"

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h"

ulong mpInit( void );
ulong mpPlay( char *fileName );

#endif
