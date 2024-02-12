#ifndef _SHELLUI_H
#define _SHELLUI_H


#define _MAXFILENAMELENGTH 128

int uiDrawStatusBar( void );
int uiDrawSelectorWindowFrame( void );
int uiDrawSelectorWindowContents( void );
int uiReadDirAndFillSelectorWindowContents( void );
int uiDrawInfoWindow( char *title, char *contents );

#endif

