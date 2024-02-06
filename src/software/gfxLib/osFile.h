#ifndef _OSFILE_H
#define _OSFILE_H


#include "gfTypes.h"
#include <cstring>


#ifdef _GFXLIB_SDL

  #include <stdio.h>
   #include <dirent.h>

#endif

#ifdef _GFXLIB_ESP32_FFAT

  #include "FS.h"
  #include "FFat.h"

#endif

#ifdef _GFXLIB_STM32_FATFS

   /* FatFs includes component */
   #include "ff_gen_drv.h"
   #include "usbh_diskio.h"

#endif

#ifdef _GFXLIB_MC68K_FATFS

   /* FatFs includes component */

   #include "../ff.h"

#endif
#ifdef _GFXLIB_RISCV_FATFS

   /* FatFs includes component */

   #include "ff.h"
   #include "diskio.h"

#endif

#define OS_FILE_READ   1
#define OS_FILE_WRITE  2
#define OS_FILE_APPEND 4

#define OS_DIRITEM_NONE 0
#define OS_DIRITEM_FILE 1
#define OS_DIRITEM_DIR  2

typedef struct _tosFile
{

#ifdef _GFXLIB_SDL
   FILE *fd;
#endif

#ifdef _GFXLIB_ESP32_FFAT
   File fd;
#endif

#if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )
   FIL   fd;
#endif

}tosFile;

typedef struct _tosDir
{

   char   dirPath[256];

#ifdef _GFXLIB_SDL

   DIR   *dd;

#endif

#if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   DIR    dd; 

#endif


}tosDir;

typedef struct _tosDirItem
{
   
   char  name[256];
   char  type;
   ulong size;

}tosDirItem;


ulong osFInit( void );
ulong osFOpen( tosFile *file, char *path, ulong mode );
ulong osFClose( tosFile *file );
ulong osFWrite( tosFile *file, uchar *buffer, ulong numBytesToWrite );
ulong osFRead( tosFile *file, uchar *buffer, ulong numBytesToRead, ulong *numBytesRead );
ulong osFGetS( tosFile *file, uchar *buffer, ulong maxLength );

ulong osDirOpen( tosDir *dir, char *path );
ulong osDirClose( tosDir *dir );
ulong osDirRead( tosDir *dir, tosDirItem *dirItem );


#endif

