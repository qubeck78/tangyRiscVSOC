
#include <cstdio>

#include "../gfxLib/osFile.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/osSerial.h"

#include "shellUI.h"
#include "fileOperations.h"

extern char             fileNameBuf1[ 256 ];
extern char             fileNameBuf2[ 256 ];
extern tgfBitmap        screen2;
extern tgfTextOverlay   con;


ulong pathSelectParentDirectory( char* path )
{
   ulong i;
   ulong slashIdx;

   slashIdx = -1;

   for( i = 0; i < strlen( path ); i++ )
   {
      if( path[i] == '/' )
      {
         slashIdx = i;
      }
   }
   if( slashIdx >= 0 )
   {
      path[slashIdx] = 0;  //cut last directory
   }

   return 0;
}

char* pathFindExtension( char* fileName )
{
   char  *pExtension;
   int    i;

   pExtension = NULL;

   for( i = 0; i < strlen( fileName ); i++ )
   {
      if( fileName[i] == '.' )
      {
         pExtension = &fileName[i];
      }
   }

   return pExtension;
}

ulong pathGetSelectedFileFromSelector( tselector *selector, char *fileName )
{
   //create full file path
   strcpy( fileName, selector->path );
   strcat( fileName, "/" );
   strcat( fileName, selector->selectorFileNames[ selector->selectorCursorPos ]);

   return 0;
}

ulong remountSD()
{
   ulong       rv;
   tosUIEvent  event;

   //unmount sd

   #ifdef _GFXLIB_RISCV_FATFS
   f_mount( 0, NULL );

   uiDrawInfoWindow( (char*)"Card unmounted", (char*)"Insert new card and press any key", _UI_INFO_WINDOW_BUTTONS_NONE );

   do
   {
   
      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            break;
         }

      }

   }while( 1 );


   rv = osFInit();

   if( rv )
   {
      
      uiDrawInfoWindow( (char*)"Error", (char*)"           SD init error         ", _UI_INFO_WINDOW_BUTTONS_NONE );
      
   }else
   {

      uiDrawInfoWindow( (char*)"Card mounted", (char*)"          Press any key          ", _UI_INFO_WINDOW_BUTTONS_NONE );

   }


   do
   {
   
      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            break;
         }

      }

   }while( 1 );

   #endif

   return 0;
}


ulong deleteFile( char *fileName )
{
   char        buf[256];
   tosUIEvent  event;

   sprintf( buf, "Delete: %s ?", fileName );

   uiDrawInfoWindow( (char*)"Delete", buf, _UI_INFO_WINDOW_BUTTONS_YESNO );


   do
   {
   
      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            break;
         }

      }

   }while( 1 );

   if( event.arg1 == 'y' )
   {
      osFDelete( fileName );
   }

   return 0;
}

ulong copyFile( char *fromFileName, char *toFileName, char *dialogTitle )
{
   uchar    *fileBuffer;
   ulong     fileBufferLength;
   tosFile   src;
   tosFile   dst;
   ulong     fileSize;
   ulong     fileIdx;
   ulong     nbr;
   ulong     i;
   ulong     j;

   char      progressBarBuf[80];

   //use screen2 framebuffer as file buf
   fileBuffer = (uchar*)screen2.buffer;

   //8k default length
   fileBufferLength  = 8192;

   if( strcmp( fromFileName, toFileName ) == 0 )
   {
      return 1;
   }

   fileSize = osFSize( fromFileName );
   
   if( fileSize == 0 )
   {
      return 1;
   }

   if( osFOpen( &src, fromFileName, OS_FILE_READ ) )
   {
      return 1;
   }

   if( osFOpen( &dst, toFileName, OS_FILE_WRITE ) )
   {
      osFClose( &src );
      return 1;
   }


   fileIdx = 0;

   while( fileIdx < fileSize )
   {

      nbr = 0;
      osFRead( &src, fileBuffer, 8192, &nbr );

      if( nbr == 0 )
      {
         break;
      }

      osFWrite( &dst, fileBuffer, nbr );

      fileIdx += nbr;

      if( fileSize > 0 )
      {
         j =  fileIdx * 40 / fileSize;
      }

      strcpy( progressBarBuf, "" );
      for( i = 0; i < 40; i++ )
      {
         if( i >= j )
         {
            strcat( progressBarBuf, "\xb0" );
         }
         else
         {
            strcat( progressBarBuf, "\xb1" );
         }
      }
      uiDrawInfoWindow( dialogTitle, progressBarBuf, _UI_INFO_WINDOW_BUTTONS_NONE );

   }


   osFClose( &src );
   osFClose( &dst );

   return 0;
}

ulong createDir( char *path )
{
   char        buf[32];

   tosUIEvent  event;
   ushort      typeLoop;
   ushort      idx;
   uint8_t     keyCode;

   strcpy( buf, "_                             " );


   idx = 0;
   do
   {
   
      uiDrawInfoWindow( (char*)"Make directory", buf, _UI_INFO_WINDOW_BUTTONS_NONE );
      
      typeLoop = 0;

      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {

            keyCode = event.arg1;

            switch( keyCode )
            {

               case _KEYCODE_ESC:
                  
                  typeLoop = 2;
                  
                  break;

               case _KEYCODE_ENTER:

                  buf[idx] = 0;
                  typeLoop = 1;

                  break;

               case _KEYCODE_BACKSPACE:

                  if( idx > 0 )
                  {
                     idx--;

                     buf[idx + 1]   = ' ';
                     buf[idx]       = '_';
                  }
                  break;

               default:

                  if( ( ( keyCode >= '0' ) && ( keyCode <= '9' ) ) || ( ( keyCode >= 'a' ) && ( keyCode <= 'z' ) ) ||
                     ( ( keyCode >= 'A' ) && ( keyCode <= 'Z' ) ) || keyCode == '.' || keyCode == ' ' || keyCode == '_' || keyCode == '-' )
                  {
                     if( idx < 29 )
                     {
                        buf[idx++]  = keyCode;
                        buf[idx]    = '_';
                     }

                  } 

                  break;
            }


         }

      }

   }while( ! typeLoop );

   if( typeLoop == 1 )
   {
      strcpy( fileNameBuf1, path );
      strcat( fileNameBuf1, "/" );
      strcat( fileNameBuf1, buf );

      osMkDir( fileNameBuf1 );

   }
   return 0;
}

ulong moveFile( char *fromFileName, char *toFileName )
{

   if( !copyFile( fromFileName, toFileName, (char*)"Move" ) )
   {
      osFDelete( fromFileName );
   }

   return 0;   
}

ulong renameFile( char *path, char *fileName )
{
   char        buf[32];

   tosUIEvent  event;
   ushort      typeLoop;
   ushort      idx;
   uint8_t     keyCode;
   ulong       i;

   strcpy( buf, "_                             " );

   for( i = 0; i < strlen( fileName); i++ )
   {
      if( i < 30 )
      {
         buf[i] = fileName[i];
         buf[i + 1] = '_';

         idx = i + 1;
      }
   }

   do
   {
   
      uiDrawInfoWindow( (char*)"Rename", buf, _UI_INFO_WINDOW_BUTTONS_NONE );
      
      typeLoop = 0;

      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {

            keyCode = event.arg1;

            switch( keyCode )
            {

               case _KEYCODE_ESC:
                  
                  typeLoop = 2;
                  
                  break;

               case _KEYCODE_ENTER:

                  buf[idx] = 0;
                  typeLoop = 1;

                  break;

               case _KEYCODE_BACKSPACE:

                  if( idx > 0 )
                  {
                     idx--;

                     buf[idx + 1]   = ' ';
                     buf[idx]       = '_';
                  }
                  break;

               default:

                  if( ( ( keyCode >= '0' ) && ( keyCode <= '9' ) ) || ( ( keyCode >= 'a' ) && ( keyCode <= 'z' ) ) ||
                     ( ( keyCode >= 'A' ) && ( keyCode <= 'Z' ) ) || keyCode == '.' || keyCode == ' ' || keyCode == '_' || keyCode == '-' )
                  {
                     if( idx < 29 )
                     {
                        buf[idx++]  = keyCode;
                        buf[idx]    = '_';
                     }

                  } 

                  break;
            }


         }

      }

   }while( ! typeLoop );

   if( typeLoop == 1 )
   {
   
      //create full src file path
      strcpy( fileNameBuf1, path );
      strcat( fileNameBuf1, "/" );
      strcat( fileNameBuf1, fileName );

      //dst
      strcpy( fileNameBuf2, path );
      strcat( fileNameBuf2, "/" );
      strcat( fileNameBuf2, buf );

      if( !copyFile( fileNameBuf1, fileNameBuf2, (char*)"Rename" ) )
      {
         osFDelete( fileNameBuf1 );
      }

   }

   return 0;   
}

ulong atoiHex( char *buf, long index, long digits )
{
   ulong rv;
   ulong i;
   char  c;

   rv = 0;

   for( i = 0; i < digits; i++ )
   {
      rv = rv << 4;

      c = buf[index++];

      if( ( c >= '0' ) && ( c <= '9') )
      {
         rv |= c - '0';
      }
      else if( ( c >= 'A' ) && ( c <= 'F' ) )
      {
         rv |= c - 'A' + 10;
      }
      else if( ( c >='a' ) && ( c <= 'f' ) )
      {
         rv |= c - 'a' + 10;
      }
   }

   return rv;
}

ulong dfDecodeFileInformation( char *rxBuf, char *fileName, ulong *fileLength )
{
   ulong idx;
   ulong fnameLength;
   ulong i;

   if( rxBuf == NULL )
   {
      return 1;
   }
   if( fileName == NULL )
   {
      return 1;
   }
   if( fileLength == NULL )
   {
      return 1;
   }

   if( ( rxBuf[0] != ':' ) || ( rxBuf[1] != '0' ) || ( rxBuf[2] != '0' ) )
   {
      return 2;
   }

   idx = 3;

   fnameLength = atoiHex( rxBuf, 3, 2 );

   idx += 2;

   for( i = 0; i < fnameLength; i++ )
   {
      fileName[i]       = atoiHex( rxBuf, idx, 2 );
      fileName[i + 1]   = 0;
      
      idx               += 2;
   }

   *fileLength = atoiHex( rxBuf, idx, 8 );
   return 0;
}


ulong dfDecodeFileContents( char *rxBuf, tosFile *out, ulong *fileIdx )
{
   ulong length;
   ulong i;
   uchar fileContentsBuf[32];
   uchar lrc;


   length   = 0;

   if( rxBuf == NULL )
   {
      return 3;
   }
   if( out == NULL )
   {
      return 3;
   }
   if( fileIdx == NULL )
   {
      return 3;
   }

   if( strlen( rxBuf ) < 5 )
   {
      //error
      return 2;
   }

   if( rxBuf[0] != ':' )
   {
      return 2;
   }

   if( ( rxBuf[1] == '0' ) && ( rxBuf[2] == '2' ) )
   {
      return 1;   //eof
   }



   if( ( rxBuf[1] == '0' ) && ( rxBuf[2] == '1' ) )
   {
      //file contents
      //:01lld0d1d2d3d4..dncc


      lrc = (uchar)':';

      length = atoiHex( rxBuf, 3, 2 );

      lrc ^= (uchar)length;

      if( length > 32 )
      {
         return 2;
      }

      *fileIdx += length;

      for( i = 0; i < length ; i++ )
      {
         fileContentsBuf[i] = atoiHex( rxBuf, 5 + i * 2, 2 );
         lrc ^= fileContentsBuf[i];
      }

      if( lrc != atoiHex( rxBuf, 5 + length * 2, 2 ) )
      {
         //bad lrc
         return 2;
      }

      if( osFWrite( out, fileContentsBuf, length ) )
      {
         return 2;
      }
   }

   return 0;
}


ulong downloadFile( char *path )
{
   long     rv;
   ulong    i;
   ulong    j;
   ulong    fileSize;
   ulong    fileIdx;
   char     progressBarBuf[80];
   ulong    abort;
   tosFile  out;

   rv = osSerialOpen( 0, 460800 );

   if( rv )
   {
      return 1;
   }


   uiDrawInfoWindow( (char*)"Download", (char*)"Waiting for connection", _UI_INFO_WINDOW_BUTTONS_CANCEL );

   tosUIEvent  event;


   osSerialClearRxFifo( 0 );

   i = 0;

   do
   {
      if( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            if( ( event.arg1 == 'c' ) || ( event.arg1 == 27 ) )
            {
               i = 2;   //abort
            }
         }
      }

      if( osSerialGetC( 0 ) == ':' )
      {
         i = 1;   //host sent something
      }


   }while( !i );

   if( i == 2)
   {
      osSerialClose( 0 );
      return 0;
   }

   fileNameBuf2[0] = ':';
   fileNameBuf2[1] = 0;

   osSerialGetS( 0, &fileNameBuf2[1], 254, 500 );

   if( dfDecodeFileInformation( fileNameBuf2, fileNameBuf1, &fileSize ) )
   {

      osSerialPutC( 0, '!' );
      osSerialClose( 0 );
      return 1;

   }

   strcpy( fileNameBuf2, path );
   strcat( fileNameBuf2, "/" );
   strcat( fileNameBuf2, fileNameBuf1 );


   if( osFOpen( &out, fileNameBuf2, OS_FILE_WRITE ) )
   {
      osFClose( &out );
      
      osSerialPutC( 0, '!' );

      return 1;
   }



   osSerialPutC( 0, '*' );

   fileIdx = 0;



   abort = 0;

   do
   {
      if( fileSize > 0 )
      {
         j =  fileIdx * 40 / fileSize;
      }

      strcpy( progressBarBuf, "" );
      for( i = 0; i < 40; i++ )
      {
         if( i >= j )
         {
            strcat( progressBarBuf, "\xb0" );
         }
         else
         {
            strcat( progressBarBuf, "\xb1" );
         }
      }
      uiDrawInfoWindow( fileNameBuf2, progressBarBuf, _UI_INFO_WINDOW_BUTTONS_CANCEL );

      osSerialGetS( 0, fileNameBuf1, 255, 500 );

      rv = dfDecodeFileContents( fileNameBuf1, &out, &fileIdx );

      if( rv == 0 )
      {
         osSerialPutC( 0, '*' );
      }
      else if( rv == 1 )
      {
         //eof
         abort = 1;
      }
      else
      {
         //error
         osSerialPutC( 0, '!' );

         abort = 2;
      }

      event.type = 0;
      if( !osGetUIEvent( &event ) )
      {
         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            if( ( event.arg1 == 'c' ) || ( event.arg1 == 'C' ) || ( event.arg1 == 27 ) )
            {
               abort = 2;
            }
         }
      } 
   
   }while( !abort );


   osFClose( &out );
   osSerialClose( 0 );

   return 0;
}

