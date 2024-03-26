#ifndef _SHELLUI_H
#define _SHELLUI_H

#include "../gfxLib/gftypes.h"

#define _MAXFILENAMELENGTH 128

#define _SELECTOR_WINDOW_HEIGHT  25

#define _UI_INFO_WINDOW_BUTTONS_NONE   0
#define _UI_INFO_WINDOW_BUTTONS_YESNO  1
#define _UI_INFO_WINDOW_BUTTONS_OK     2
#define _UI_INFO_WINDOW_BUTTONS_CANCEL 3

typedef struct _tselector
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
   
}tselector;

int uiDrawStatusBar( void );
int uiDrawSelectorWindowFrame( tselector *selector );
int uiDrawSelectorWindowContents( tselector *selector );
int uiReadDirAndFillSelectorWindowContents( tselector *selector );
ulong uiDrawInfoWindow( char *title, char *contents, ulong buttons );

#endif

