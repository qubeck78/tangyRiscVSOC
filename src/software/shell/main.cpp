#include "main.h"
#include <cstring>
#include <climits>
#include <ctype.h>
#include <cstdio>

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/gfJPEG.h"
#include "../gfxLib/osUIEvents.h"
#include "../gfxLib/usbHID.h"

#ifdef _GFXLIB_RISCV_FATFS

#include "../gfxLib/ff.h" 

#endif

#include "shellUI.h"
#include "objViewer.h"


#ifdef _GFXLIB_RISCV_FATFS

extern FATFS   fatfs;         //fs object defined in osFile.cpp

#endif

extern tgfTextOverlay   con;

tgfBitmap      screen;
tgfBitmap      background;
tgfBitmap      screen2;
tgfBitmap      zBuffer; 
tgfBitmap      texture; 

char           fileNameBuf1[ 256 ];
char           fileNameBuf2[ 256 ];

tselector      selectors[2];
ushort         activeSelectorIdx;
ushort         inactiveSelectorIdx;

int animLeds( int j );
int init( void );
int viewImage( char *fileName );
int pathSelectParentDirectory( char* path );
char* pathFindExtension( char* fileName );
ulong pathGetSelectedFileFromSelector( tselector *selector, char *fileName );
int asciiTable( void );
int viewImage( char* fileName );
int viewFont( char* fileName );
int viewHex( char* fileName );
int viewFile( char* fileName );
ulong deleteFile( char *fileName );
ulong copyFile( char *fromFileName, char *toFileName );

int animLeds( int j )
{  
      switch( j % 2 )
      {
         case 0:
            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0010;
         
            break;

         case 1:

            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0020;
         
            break;

      }
      
   return 0;
} 

int init()
{
   int rv;

   rv = 0;

   bspInit();

   setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );
   
   con.textAttributes = 0x0f;

   toCls( &con );


   //alloc screen buffer
   screen.width            = 320;
   screen.rowWidth         = 512;
   screen.height           = 240;
      
   screen.flags            = 0;
   screen.transparentColor = 0;
   screen.buffer           = osAlloc( screen.rowWidth * screen.height * 2, OS_ALLOC_MEMF_CHIP );   //osAlloc( 320 * 240 * 2 );
   
   if( screen.buffer == NULL )
   {
      toPrint( &con, ( char* )"\nCan't alloc screen\n" );
      rv = 1;
      return rv;
   } 
   
   //display screen buffer
   gfDisplayBitmap( &screen );

   //clear screen buffer
   gfFillRect( &screen, 0, 0, screen.width - 1, screen.height - 1 , gfColor( 0, 0, 0 ) ); 
   
   //alloc second screen for doublebuffered 3d viewer
   screen2.width              = 320;
   screen2.rowWidth           = 512;
   screen2.height             = 240;
      
   screen2.flags              = 0;
   screen2.transparentColor   = 0;
   screen2.buffer             = osAlloc( screen.rowWidth * screen.height * 2, OS_ALLOC_MEMF_CHIP );   
   
   if( screen2.buffer == NULL )
   {
      toPrint( &con, ( char* )"\nCan't alloc screen 2\n" );
      rv = 1;
      return rv;
   } 

   //alloc z-buffer

   zBuffer.width              = 320;
   zBuffer.rowWidth           = 512;
   zBuffer.height             = 240;
   zBuffer.flags              = 0;
   zBuffer.transparentColor   = 0;
   zBuffer.buffer             = osAlloc( zBuffer.rowWidth * ( zBuffer.height + 1 ) * 2, OS_ALLOC_MEMF_CHIP );
   
   if( zBuffer.buffer == NULL )
   {
      toPrint( &con, (char*)"\nCan't alloc z buffer\n" );
      rv = 1;
      return rv;
   } 

   gfFillRect( &zBuffer, 0, 0, zBuffer.width - 1, zBuffer.height - 1 , gfColor( 0, 0, 0 ) ); 

   #ifdef _GFXLIB_RISCV_FATFS
   
   //init usb HID stack
   rv = usbHIDInit();

   if( rv )
   {
      toPrint( &con, ( char* )"USB HID init error\n" );
      
      rv = 1;
      return rv;

   }

   #endif

   //init events queue
   osUIEventsInit(); 


   //init filesystem
   rv = osFInit();

   if( rv )
   {
      toPrint( &con, ( char* )"SD init error\n" );
      
      return rv;

   }


   rv = gfLoadBitmapFS( &background, ( char* )"0:/shell/background.gbm" );
   if( rv )
   {
      toPrint( &con, ( char* )"Can't load background.gbm\n" );
      
      return rv;
   }


   gfBlitBitmap( &screen, &background, 0, 0 );

   rv = objvInit();


   return rv;
}


int pathSelectParentDirectory( char* path )
{
   int i;
   int slashIdx;

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

int asciiTable()
{
   int         x;
   int         y;
   int         i;
   tosUIEvent  event;

   con.textAttributes = 0x0f;
   toCls( &con );
   con.textAttributes = 0xf0;

   for( y = 0; y < 12; y++ )
   {
      toSetCursorPos( &con, 2, 4 + y );

      for( x = 0; x < 25; x++ )
      {
         i = x + y * 25;
         
         if( i < 0x100 )
         {
            con.textAttributes   = 0x0f;
            toPrintF( &con, (char*)"%02x", i );

            con.textAttributes   = 0x0e;

            if( ( i != 10 ) && ( i != 0) )
            {
               toPrintF( &con, (char*)"%c", i );
            }
            else
            {
               toPrint( &con, (char*)" " );           
            }
         }
      }

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

   return 0;
}


int viewImage( char* fileName )
{
   tgfBitmap   img;
   int         rv;
   tosUIEvent  event;
   int         fileNameLength;
   short       x;
   short       y;


   con.textAttributes = 0x0f;

   fileNameLength = strlen( fileName );

   if( fileNameLength < 4 )
   {
      return 1;
   }

   toCls( &con );
   toPrintF( &con, (char*) "Loading: \"%s\"", fileName );

   img.buffer = NULL;



   if( ( fileName[ fileNameLength - 4 ] == '.' ) && ( fileName[ fileNameLength - 3 ] == 'g' ) && ( fileName[ fileNameLength - 2 ] == 'b' ) &&  ( fileName[ fileNameLength - 1 ] == 'm' ) )
   {
   
      rv = gfLoadBitmapFS( &img, fileName );
   
   }else if( ( fileName[ fileNameLength - 4 ] == '.' ) && ( fileName[ fileNameLength - 3 ] == 'j' ) && ( fileName[ fileNameLength - 2 ] == 'p' ) &&  ( fileName[ fileNameLength - 1 ] == 'g' ) )
   { 
      
      rv = gfLoadJPEGFS( &img, fileName );

   }else
   {
      rv = 1;
   }

   toCls( &con );

   con.textAttributes = 0x8f;
   toPrintF( &con, (char*)"%s", fileName );
   
   if( !rv )
   {
      x = ( screen.width / 2 ) - ( img.width / 2);
      y = ( screen.height / 2 ) - ( img.height / 2 );


      gfBlitBitmap( &screen, &img, x, y );


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
   }


   if( img.buffer != NULL )
   {
      osFree( img.buffer );
      img.buffer = NULL;
   }

   return rv;
}

int viewFont( char* fileName )
{
   tgfFont     font;
   int         rv;
   tosUIEvent  event;
   int         fileNameLength;
   int         x;
   int         y;
   int         i;

   con.textAttributes = 0x0f;

   toCls( &con );
   toPrintF( &con, (char*) "Loading: \"%s\"", fileName );

   rv = gfLoadFontFS( &font, fileName );

   font.flags |= GF_FONT_FLAG_TRANSPARENT;

   toCls( &con );
   toPrintF( &con, (char*)"%s", fileName );

   if( !rv )
   {
      i = font.firstChar;

      if( font.type == GF_FONT_TYPE_ALPHA4_BITMAP_VAR_WIDTH )
      {

         for( y = 16; y < screen.height; y+= ( font.height + 2 ) )
         {
            x = 0;

            do
            {

               if( i <= ( font.lastChar - font.firstChar ) )
               {
                  font.charColor = gfColor( i, 200, 255 - i );

                  x += gfPutChar( &screen, &font, x, y, (char)i );
                  i++;
               }
               else
               {
                  x += font.width + 1;
               }

            }while( x < screen.width - 16 );
         }
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
   }


   if( font.charBuffer != NULL )
   {
      osFree( (void*) font.charBuffer );
      font.charBuffer = NULL;
   }

   if( font.charWidths != NULL )
   {
      osFree( (void*) font.charWidths );
      font.charWidths = NULL;
   }

   return rv;
}

int viewHex( char* fileName )
{
   int         rv;
   unsigned char  buf[32];
   tosFile         in;

   rv = 0;

   int         x;
   int         y;
   int            i;
   unsigned char  c;

   tosUIEvent     event;
   ulong       nbr;
   ushort         eofReached;


   if( osFOpen( &in, fileName, OS_FILE_READ ) )
   {
      return 1;
   }

   con.textAttributes = 0x0f;
   toCls( &con );
   con.textAttributes = 0x0f;

   toPrintF( &con, (char*)"%s", fileName );

   toSetCursorPos( &con, 0, 29 );

   con.textAttributes   = 0x5f;
   toPrintF( &con, ( char* )"ESC exit" );

   con.textAttributes   = 0x0f;
   toPrintF( &con, ( char* )" " );

   con.textAttributes   = 0x5f;
   toPrintF( &con, ( char* )"SPC next" );

   con.textAttributes   = 0x0f;
   toPrintF( &con, ( char* )" " );

   do
   {
      eofReached = 0;

      for( y = 1; y < 29; y++ )
      {
         osFRead( &in, buf, 16, &nbr );


         toSetCursorPos( &con, 0, y );
         toPrintF( &con, (char*) "                                                                              " );

         toSetCursorPos( &con, 0, y );
         
         for( i = 0; i < nbr; i++ )
         {
            toPrintF( &con, (char*)"%02X ", buf[i] );
         }

         toPrintF( &con, (char*)" " );
         
         toSetCursorPos( &con, 54, y );

         for( i = 0; i < nbr; i++ )
         {
            c = buf[i];

            if( c < 32 )
            {
               c = '.';
            }

            toPrintF( &con, (char*)"%c", c );
         }
      }

      if( nbr == 0 )
      {
         eofReached = 1;
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

      if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
      {
         if( event.arg1 == _KEYCODE_ESC )
         {
            break;
         }
      }

      if( eofReached )
      {
         break;
      }

   }while( 1 );

   osFClose( &in );

   return rv;
}

int viewFile( char* fileName )
{
   int    rv;
   char   extension[32];
   char  *pExtension;
   int       i;

   rv = 0;


   //extract extension

   pExtension = pathFindExtension( fileName );

   
   //check if exists, and lowercase

   if( pExtension == NULL )
   {
      return 1;
   }

   for( i = 0; i < strlen( pExtension ); i++ )
   {
      if( i < 31 )
      {
         extension[i] = tolower( pExtension[i] );
         extension[i + 1] = 0;
      }
   }


   //select file type by extension

   if( ( strcmp( extension, ".gbm" ) == 0 ) || ( strcmp( extension, ".jpg" ) == 0 ) )
   {
      
      rv = viewImage( fileName );
   
   }
   else if( strcmp( extension, ".gfn" ) == 0 )
   {
      
      rv = viewFont( fileName );

   }
   else if( strcmp( extension, ".obj" ) == 0 )
   {
      rv = objvView( fileName );
   }


   else{

      rv = viewHex( fileName );
   
   }


   return rv;
   
}


int remountSD()
{
   int         rv;
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

ulong copyFile( char *fromFileName, char *toFileName )
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
            strcat( progressBarBuf, " " );
         }
         else
         {
            strcat( progressBarBuf, "#" );
         }
      }
      uiDrawInfoWindow( (char*)"Copy", progressBarBuf, _UI_INFO_WINDOW_BUTTONS_NONE );

   }


   osFClose( &src );
   osFClose( &dst );

   return 0;
}

int main()
{
   long           i;
   ulong          rv;
   ushort         refreshScreen;

   tosUIEvent     event;

   volatile int   j;
      
   rv = init();

   //reset dir cursors
   selectors[0].selectorWindowIdx   = 0;
   selectors[0].selectorCursorPos   = 0;

   selectors[1].selectorWindowIdx   = 0;
   selectors[1].selectorCursorPos   = 0;


   activeSelectorIdx                = 0;
   inactiveSelectorIdx              = 1;

   selectors[0].selectorActive      = 1;
   selectors[1].selectorActive      = 0;

   selectors[0].selectorWindowIdx   = 0;
   selectors[0].selectorCursorPos   = 0;

   selectors[1].selectorWindowIdx   = 0;
   selectors[1].selectorCursorPos   = 0;
   
   //selector locations
   selectors[0].x          = 0;
   selectors[0].y          = 1;

   selectors[1].x          = 40;
   selectors[1].y          = 1;

   //default selector window height
   selectors[0].selectorWindowHeight   = _SELECTOR_WINDOW_HEIGHT;
   selectors[1].selectorWindowHeight   = _SELECTOR_WINDOW_HEIGHT;


   //default path

   #ifdef _GFXLIB_SDL

      strcpy( selectors[0].path, "." );
      strcpy( selectors[1].path, "." );

   #else

      strcpy( selectors[0].path, "0:" );
      strcpy( selectors[1].path, "0:" );

   #endif

   uiReadDirAndFillSelectorWindowContents( &selectors[0] );
   uiReadDirAndFillSelectorWindowContents( &selectors[1] );



   refreshScreen = 2;

   do
   {
      if( refreshScreen == 1 )
      {
         uiDrawSelectorWindowContents( &selectors[0] );
         uiDrawSelectorWindowContents( &selectors[1] );
         refreshScreen = 0;
      
      }else if( refreshScreen == 2 )
      {

         gfBlitBitmap( &screen, &background, 0, 0 );

         con.textAttributes = 0x0f;

         toCls( &con );
         
         uiDrawStatusBar();
         uiDrawSelectorWindowFrame( &selectors[0] );
         uiDrawSelectorWindowFrame( &selectors[1] );
         uiDrawSelectorWindowContents( &selectors[0] );
         uiDrawSelectorWindowContents( &selectors[1] );

         refreshScreen = 0;
      }

      while( !osGetUIEvent( &event ) )
      {

         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            switch( event.arg1 )
            {
            
               case _KEYCODE_PAUSE:

                  reboot();
                  break;

               case _KEYCODE_TAB:

                  if( activeSelectorIdx )
                  {
                     activeSelectorIdx             = 0;
                     inactiveSelectorIdx           = 1;

                     selectors[0].selectorActive   = 1;
                     selectors[1].selectorActive   = 0;
                     
                  }
                  else
                  {
                     activeSelectorIdx             = 1;
                     inactiveSelectorIdx           = 0;

                     selectors[0].selectorActive   = 0;
                     selectors[1].selectorActive   = 1;
                  }

                  refreshScreen  = 1;

                  break;

               case _KEYCODE_UP:
               
                  if( selectors[activeSelectorIdx].selectorCursorPos > 0 )
                  {
                     selectors[activeSelectorIdx].selectorCursorPos--;
                     refreshScreen = 1;
                  }
                  else
                  {
                     selectors[activeSelectorIdx].selectorCursorPos = selectors[activeSelectorIdx].selectorWindowHeight - 1;
                     selectors[activeSelectorIdx].selectorWindowIdx -= selectors[activeSelectorIdx].selectorWindowHeight;
                     
                     if( selectors[activeSelectorIdx].selectorWindowIdx < 0 )
                     {
                        selectors[activeSelectorIdx].selectorWindowIdx = 0;
                        selectors[activeSelectorIdx].selectorCursorPos = 0;
                     }

                     uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );
                     
                     refreshScreen  = 1;

                  }

               break;

               case _KEYCODE_DOWN:

                  if( selectors[activeSelectorIdx].selectorCursorPos < ( selectors[activeSelectorIdx].selectorWindowHeight - 1 ) )
                  {
                     selectors[activeSelectorIdx].selectorCursorPos++;
                     refreshScreen = 1;
                  }else
                  {
                     selectors[activeSelectorIdx].selectorCursorPos    = 0;
                     selectors[activeSelectorIdx].selectorWindowIdx    += selectors[activeSelectorIdx].selectorWindowHeight;
                     
                     uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );
                     
                     refreshScreen  = 1;
                  }

               break;
         
               case _KEYCODE_PGUP:

                  selectors[activeSelectorIdx].selectorWindowIdx -= selectors[activeSelectorIdx].selectorWindowHeight;
                  
                  if( selectors[activeSelectorIdx].selectorWindowIdx < 0 )
                  {
                     selectors[activeSelectorIdx].selectorWindowIdx = 0;
                     selectors[activeSelectorIdx].selectorCursorPos = 0;
                  }

                  uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );
                     
                  refreshScreen  = 1;

                  break;

               case _KEYCODE_PGDOWN:

                  selectors[activeSelectorIdx].selectorWindowIdx += selectors[activeSelectorIdx].selectorWindowHeight;
                  
                  uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );
                     
                  refreshScreen  = 1;


                  break;

               case _KEYCODE_F1:

                  remountSD();

                  selectors[0].selectorWindowIdx = 0;
                  selectors[0].selectorCursorPos = 0;

                  selectors[1].selectorWindowIdx = 0;
                  selectors[1].selectorCursorPos = 0;

                  //default path

                  #ifdef _GFXLIB_SDL

                     strcpy( selectors[0].path, "." );
                     strcpy( selectors[1].path, "." );

                  #else

                     strcpy( selectors[0].path, "0:" );
                     strcpy( selectors[1].path, "0:" );

                  #endif

                  uiReadDirAndFillSelectorWindowContents( &selectors[0] );
                  uiReadDirAndFillSelectorWindowContents( &selectors[1] );

                  refreshScreen = 2;

                  break;

               case _KEYCODE_F3:

                  //create full file path
                  pathGetSelectedFileFromSelector( &selectors[activeSelectorIdx], fileNameBuf1 );

                  //hex view file
                  viewHex( fileNameBuf1 );             

                  refreshScreen = 2;

                  break;

               case _KEYCODE_F5:

                  //create full src file path
                  pathGetSelectedFileFromSelector( &selectors[activeSelectorIdx], fileNameBuf1 );

                  //create full dst file path
                  strcpy( fileNameBuf2, selectors[inactiveSelectorIdx].path );
                  strcat( fileNameBuf2, "/" );
                  strcat( fileNameBuf2, selectors[activeSelectorIdx].selectorFileNames[ selectors[activeSelectorIdx].selectorCursorPos ] );

                  copyFile( fileNameBuf1, fileNameBuf2 );

                  //re-read directory contents
                  uiReadDirAndFillSelectorWindowContents( &selectors[0] );
                  uiReadDirAndFillSelectorWindowContents( &selectors[1] );

                  refreshScreen = 2;
                     
                  break;

               case _KEYCODE_F8:

                  //create full file path
                  pathGetSelectedFileFromSelector( &selectors[activeSelectorIdx], fileNameBuf1 );

                  //delete file
                  deleteFile( fileNameBuf1 );

                  //re-read directory contents
                  uiReadDirAndFillSelectorWindowContents( &selectors[0] );
                  uiReadDirAndFillSelectorWindowContents( &selectors[1] );

                  refreshScreen = 2;

                  break;

               case _KEYCODE_F12:

                  asciiTable();
                  refreshScreen = 2;
                  
                  break;

               case _KEYCODE_BACKSPACE:

                  pathSelectParentDirectory( selectors[activeSelectorIdx].path );

                  selectors[activeSelectorIdx].selectorWindowIdx = 0;
                  selectors[activeSelectorIdx].selectorCursorPos = 0;

                  uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );

                  refreshScreen = 2;                     

                  break;

               case _KEYCODE_ENTER:

                  if( selectors[activeSelectorIdx].selectorFileLengths[selectors[activeSelectorIdx].selectorCursorPos] == 0xffffffff )
                  {
                     //dir
                     strcat( selectors[activeSelectorIdx].path, "/" );
                     strcat( selectors[activeSelectorIdx].path, selectors[activeSelectorIdx].selectorFileNames[selectors[activeSelectorIdx].selectorCursorPos] );
                     
                     selectors[activeSelectorIdx].selectorWindowIdx = 0;
                     selectors[activeSelectorIdx].selectorCursorPos = 0;

                     uiReadDirAndFillSelectorWindowContents( &selectors[activeSelectorIdx] );

                     refreshScreen = 2;                     

                  }
                  else
                  {
                     //create full file path
                     pathGetSelectedFileFromSelector( &selectors[activeSelectorIdx], fileNameBuf1 );

                     //view file
                     viewFile( fileNameBuf1 );             
                     refreshScreen = 2;
                  }
                  
                  break;
            }
         }


      } 
      
   }while( 1 );
   

} 