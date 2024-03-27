
#ifndef _FILEOPERATIONS_H
#define _FILEOPERATIONS_H

#include "../gfxLib/gftypes.h"
#include "shellUI.h"

ulong pathSelectParentDirectory( char* path );
char* pathFindExtension( char* fileName );
ulong pathGetSelectedFileFromSelector( tselector *selector, char *fileName );

ulong remountSD( void );
ulong deleteFile( char *fileName );
ulong copyFile( char *fromFileName, char *toFileName, char *dialogTitle );
ulong createDir( char *path );
ulong moveFile( char *fromFileName, char *toFileName );
ulong renameFile( char *path, char *fileName );
ulong downloadFile( char *path );


#endif

