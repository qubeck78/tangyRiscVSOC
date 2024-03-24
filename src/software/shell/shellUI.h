#ifndef _SHELLUI_H
#define _SHELLUI_H

#include "../gfxLib/gftypes.h"

#define _MAXFILENAMELENGTH 128

#define _SELECTOR_WINDOW_HEIGHT  25

typedef struct _selector_t
{

   char     path[256];
   
   ushort   x;
   ushort   y;

   ushort   selectorActive;
   long     selectorWindowIdx;
   long     selectorCursorPos;
   long     selectorWindowHeight;
   char     selectorFileNames[_SELECTOR_WINDOW_HEIGHT][_MAXFILENAMELENGTH + 1];
   ulong    selectorFileLengths[_SELECTOR_WINDOW_HEIGHT];
   
}selector_t;

int uiDrawStatusBar( void );
int uiDrawSelectorWindowFrame( selector_t *selector );
int uiDrawSelectorWindowContents( selector_t *selector );
int uiReadDirAndFillSelectorWindowContents( selector_t *selector );
int uiDrawInfoWindow( char *title, char *contents );

#endif

