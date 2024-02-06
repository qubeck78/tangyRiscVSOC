
#include "osFile.h"

#ifdef _GFXLIB_SDL

#include <cstring>
#include <sys/stat.h>

#endif


#ifdef _GFXLIB_RISCV_FATFS

#include "bsp.h"

FATFS             fatfs;

#endif

#if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

static FILINFO    finfo;

#endif

#ifdef _GFXLIB_SDL

static struct stat fsStat;

#endif


ulong osFInit( void )
{
   int rv;
   int retryCount;
   
   #if defined( _GFXLIB_RISCV_FATFS )
   
   rv = disk_initialize( 0 );

   if( rv )
   {     
   
      retryCount = 10;
      
      do{
         delayMs( 1000 );
      
         rv = disk_initialize( 0 );
         
         if( retryCount )
         {
            retryCount--;
         }
         else
         {
            //can't initialize sd
            return 1;
         }
         
      }while( rv );
      
   }
   
   f_mount( 0, &fatfs );     /* Register volume work area (never fails) */   

   return 0;

   #else
   
      return 0;   

   #endif
}

ulong osFOpen( tosFile *file, char *path, ulong mode )
{
   #ifdef _GFXLIB_SDL

   char    winMode[8];

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   FRESULT  res;
   BYTE     stmMode;

   #endif


   if( !file )
   {
      return 1;
   }

   #ifdef _GFXLIB_SDL

   switch( mode )
   {
      case OS_FILE_READ:

         strcpy( winMode, "rb" );
         break;

      case OS_FILE_WRITE:

         strcpy( winMode, "wb" );
         break;

      case OS_FILE_APPEND:

         strcpy( winMode, "ab" );
         break;

      default:

         return 2;

   }


   file->fd = fopen( path, winMode );

   if( file->fd )
   {
      return 0;
   }
   else
   {
      return 3;
   }

   #endif


   
   #if defined( _GFXLIB_RISCV_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_STM32_FATFS )

   switch( mode )
   {
      case OS_FILE_READ:

         stmMode = FA_READ | FA_OPEN_EXISTING;
         break;

      case OS_FILE_WRITE:

         stmMode = FA_WRITE | FA_CREATE_ALWAYS;
         break;

      case OS_FILE_APPEND:

         #if defined( _GFXLIB_STM32_FATFS )
         
         stmMode = FA_OPEN_APPEND | FA_OPEN_EXISTING;
         
         #else

         return 2;   //not supported
         
         #endif

         break;

      default:

         return 2;
         break;
   }



   res = f_open( &file->fd, path, stmMode );

   if( res == FR_OK )
   {
      return 0;
   }
   else
   {
      return 3;
   }

   #endif
   

   #ifdef _GFXLIB_ESP32_FFAT

   switch( mode )
   {
    case OS_FILE_READ:

      file->fd = FFat.open( path, FILE_READ );
      
      break;

    case OS_FILE_WRITE:

      file->fd = FFat.open( path, FILE_WRITE );
      break;

    case OS_FILE_APPEND:

      file->fd = FFat.open( path, FILE_APPEND );
      break;

    default:

      return 2;

   }

   if( file->fd )
   {
      return 0;
   }
   else
   {
      return 3;
   }

   #endif



   return 255;
}

ulong osFClose( tosFile *file )
{

   if( !file )
   {
      return 1;
   }


   #ifdef _GFXLIB_SDL

   fclose( file->fd );

   return 0;

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   f_close( &file->fd );

   return 0;

   #endif

   #ifdef _GFXLIB_ESP32_FFAT
  
   file->fd.close();
   return 0;
  
   #endif
   
   return 255;
}

ulong osFWrite( tosFile *file, uchar *buffer, ulong numBytesToWrite )
{

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   FRESULT res;
   UINT    nbw;

   #endif

   
   if( ( !file ) || ( !buffer ) )
   {
      return 1;
   }

   #ifdef _GFXLIB_SDL

   if ( fwrite( buffer, 1, numBytesToWrite, file->fd ) != numBytesToWrite )
   {
      return 2;
   }
   else
   {
      return 0;
   }

   #endif

   
   #if defined( _GFXLIB_RISCV_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_STM32_FATFS )

   res = f_write( &file->fd, buffer, numBytesToWrite, &nbw );

   if( res == FR_OK )
   {
      return 0;
   }
   else
   {
      return 2;
   }

   #endif
   
   #ifdef _GFXLIB_ESP32_FFAT
  
   file->fd.write( (uint8_t*)buffer, numBytesToWrite );
   return 0;
  
   #endif

   return 255;
}

ulong osFRead( tosFile *file, uchar *buffer, ulong numBytesToRead, ulong *numBytesRead )
{

   #if defined( _GFXLIB_SDL ) || defined( _GFXLIB_ESP32_FFAT )

   int   nbr;

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS ) 

   FRESULT res;
   UINT    nbr;

   #endif


   if( ( !file ) || ( !buffer ) )
   {
      return 1;
   }


   #ifdef _GFXLIB_SDL

   nbr = fread( buffer, 1, numBytesToRead, file->fd );

   if( numBytesRead )
   {
      *numBytesRead = nbr;
   }

   if( nbr == numBytesToRead )
   {
      return 0;
   }
   else
   {
      return 2;
   }


   #endif



   #if defined( _GFXLIB_RISCV_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_STM32_FATFS )

   res = f_read( &file->fd, buffer, numBytesToRead, &nbr );

   if( numBytesRead )
   {
      *numBytesRead = nbr;
   }

      if( nbr == numBytesToRead )
      {
         return 0;
      }
      else
      {
         return 2;
      }


   #endif

   #ifdef _GFXLIB_ESP32_FFAT
  
   nbr = file->fd.read( (uint8_t*)buffer, numBytesToRead );
  
   if( numBytesRead )
   {
      *numBytesRead = nbr;

      return 0;
   }
   else
   {
      if( nbr == numBytesToRead )
      {
         return 0;
      }
      else
      {
         return 2;
      }
   }
  
   #endif

   return 255;
}


ulong osFGetS( tosFile *file, uchar *buffer, ulong maxLength )
{
   uchar rbuf[4];
   ulong idx;
   ulong rv;
   ulong nbr;

   idx = 0;

   buffer[idx] = 0;
   do
   {
      rv = osFRead( file, rbuf, 1, &nbr );

      if( !rv )
      {
         if(( rbuf[0] == 0x0a ) || ( rbuf[0] == 0x0d ) )
         {
            break;
         }

         if( idx < maxLength - 1 )
         {
            buffer[idx++] = rbuf[0];
            buffer[idx] = 0;

         }

      }

   }while( !rv );


   return rv;
}

ulong osDirOpen( tosDir *dir, char *path )
{

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   FRESULT    rc;             

   #endif

   if( dir == NULL )
   {
      return 1;
   }


   #ifdef _GFXLIB_SDL

   strcpy( dir->dirPath, "" );

   dir->dd = opendir( path );

   if( dir->dd != NULL )
   {
      strncpy( dir->dirPath, path, sizeof( dir->dirPath ) - 1 );

      return 0;
   }
   else
   {
      return 1;
   }

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   rc = f_opendir( &dir->dd, path );

   if( rc == FR_OK )
   {
      return 0;
   }
   else
   {
      return 1;
   }

   #endif


   return 1;
}

ulong osDirClose( tosDir *dir )
{

   if( dir == NULL )
   {
      return 1;
   }

   #ifdef _GFXLIB_SDL

   if( dir->dd == NULL )
   {
      return 1;
   }

   closedir( dir->dd );

   return 0;

   #endif


   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   return 0;

   #endif


   return 1;


}

ulong osDirRead( tosDir *dir, tosDirItem *dirItem )
{
   #ifdef _GFXLIB_SDL

   struct dirent  *de;
   char            statPath[512];
   bool            readNextItem;

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )
   
   FRESULT         rc;

   #endif


   if( dirItem == NULL )
   {
      return 1;
   }

   if( dir == NULL )
   {      
      return 1;
   }

   #ifdef _GFXLIB_SDL

   if( dir->dd == NULL )
   {

      return 1;
   }



   do
   {
      de = readdir( dir->dd );

      readNextItem = false;

      if( de != NULL )
      {
         if( !strcmp( de->d_name, "." ) )
         {
            readNextItem = true;
         }
         if( !strcmp( de->d_name, ".." ) )
         {
            readNextItem = true;
         }
      }

   }while( readNextItem );
   
   if( de != NULL )
   {
      strcpy( dirItem->name, de->d_name );

      strcpy( statPath, dir->dirPath );
      strcat( statPath, "/" );
      strcat( statPath, de->d_name );

      stat( statPath, &fsStat );

      if( fsStat.st_mode & S_IFDIR )
      {
         dirItem->type = OS_DIRITEM_DIR;
      }
      else
      {
         dirItem->type = OS_DIRITEM_FILE;
      }

      dirItem->size  = fsStat.st_size;


      return 0;
   }
   else
   {
      strcpy( dirItem->name, "" );
      dirItem->type  = OS_DIRITEM_NONE;
      dirItem->size  = 0;

      return 2;
   }

   return 0;

   #endif

   #if defined( _GFXLIB_STM32_FATFS ) || defined( _GFXLIB_MC68K_FATFS ) || defined( _GFXLIB_RISCV_FATFS )

   finfo.lfname = dirItem->name;
   finfo.lfsize = 255;

   //clear long file name
   dirItem->name[0] = 0;

   rc = f_readdir( &dir->dd, &finfo );

   if( rc != FR_OK )
   {
      strcpy( dirItem->name, "" );
      dirItem->type  = OS_DIRITEM_NONE;
      dirItem->size  = 0;

      return 2;
   }

   if( finfo.fattrib & AM_DIR )
   {
      dirItem->type  = OS_DIRITEM_DIR;
      dirItem->size  = 0;
   }
   else
   {
      dirItem->type  = OS_DIRITEM_FILE;
      dirItem->size  = finfo.fsize;
   }

   //check if short file name
   if( dirItem->name[0] == 0 )
   {
      strcpy( dirItem->name, finfo.fname );

   }
   
   if( dirItem->name[0] != 0 )
   {
      return 0;
   }
   else
   {
      return 1;
   }

   #endif
//finfo

}
