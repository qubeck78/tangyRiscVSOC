#ifndef _UI_H
#define _UI_H

#include "../gfxLib/gfTypes.h"

ulong uiInit( void );
ulong uiRedrawConsole( void );
ulong uiReadDirAndFillSelectorWindowContents( void );
ulong uiDrawSelectorWindowContents( void );
ulong uiDrawLoadingScreen( char *path );

#endif
