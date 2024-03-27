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


#include "shellUI.h"
#include "objViewer.h"
#include "modPlayer.h"
#include "fileOperations.h"

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

ulong animLeds( ulong j );
ulong init( void );

ulong asciiTable( void );

ulong viewImage( char *fileName );
ulong viewFont( char* fileName );
ulong viewHex( char* fileName );
ulong viewFile( char* fileName );


ulong animLeds( ulong j )
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

ulong init()
{
   ulong rv;

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
   
   //alloc z-buffer

   zBuffer.width              = 320;
   zBuffer.rowWidth           = 512;
   zBuffer.height             = 240;
   zBuffer.flags              = 0;
   zBuffer.transparentColor   = 0;
   zBuffer.buffer             = osAlloc( zBuffer.rowWidth * ( zBuffer.height + 1 ) * 2, OS_ALLOC_MEMF_CHIP );
   

   gfFillRect( &zBuffer, 0, 0, zBuffer.width - 1, zBuffer.height - 1 , gfColor( 0, 0, 0 ) ); 

   #ifdef _GFXLIB_RISCV_FATFS
   
   //init usb HID stack
   rv = usbHIDInit();

   #endif

   //init events queue
   rv = osUIEventsInit(); 


   //init filesystem
   rv = osFInit();

   rv = gfLoadBitmapFS( &background, ( char* )"0:/shell/background.gbm" );


   gfBlitBitmap( &screen, &background, 0, 0 );

   //3d obj viewer init
   rv = objvInit();

   //Amiga module player init
   rv = mpInit();

   return rv;
}



ulong asciiTable()
{
   short       x;
   short       y;
   short       i;
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


ulong viewImage( char* fileName )
{
   tgfBitmap   img;
   ulong       rv;
   tosUIEvent  event;
   ulong       fileNameLength;
   ushort      x;
   ushort      y;


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

ulong viewFont( char* fileName )
{
   tgfFont     font;
   ulong       rv;
   tosUIEvent  event;
   ulong       fileNameLength;
   short       x;
   short       y;
   ulong       i;

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

ulong viewHex( char* fileName )
{
   ulong       rv;
   uchar       buf[32];
   tosFile     in;

   ushort      x;
   ushort      y;
   ulong       i;
   uchar       c;

   tosUIEvent  event;
   ulong       nbr;
   ushort      eofReached;

   rv = 0;

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

ulong viewFile( char* fileName )
{
   ulong  rv;
   char   extension[32];
   char  *pExtension;
   ulong  i;

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
   else if( strcmp( extension, ".mod" ) == 0 )
   {
      rv = mpPlay( fileName );
   }


   else{

      rv = viewHex( fileName );
   
   }


   return rv;
   
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

         //toCls( &con );
         
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

               case _KEYCODE_F2:

                  downloadFile( selectors[activeSelectorIdx].path );

                  //re-read directory contents
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

                  copyFile( fileNameBuf1, fileNameBuf2, (char*)"Copy" );

                  //re-read directory contents
                  uiReadDirAndFillSelectorWindowContents( &selectors[0] );
                  uiReadDirAndFillSelectorWindowContents( &selectors[1] );

                  refreshScreen = 2;
                     
                  break;

               case _KEYCODE_F6:


                  if( strcmp( selectors[activeSelectorIdx].path, selectors[inactiveSelectorIdx].path ) == 0 )
                  {
                     //paths are the same

                     renameFile( selectors[activeSelectorIdx].path, selectors[activeSelectorIdx].selectorFileNames[ selectors[activeSelectorIdx].selectorCursorPos] );

                  }
                  else
                  {
                     //paths are different

                     //use file from active selector, and path from inactive selector

                     //src path + file
                     pathGetSelectedFileFromSelector( &selectors[activeSelectorIdx], fileNameBuf1 );

                     //dest path + src file
                     strcpy( fileNameBuf2, selectors[inactiveSelectorIdx].path );
                     strcat( fileNameBuf2, "/" );
                     strcat( fileNameBuf2, selectors[activeSelectorIdx].selectorFileNames[ selectors[activeSelectorIdx].selectorCursorPos ]);

                     //
                     moveFile( fileNameBuf1, fileNameBuf2 );

                  }

                  //re-read directory contents
                  uiReadDirAndFillSelectorWindowContents( &selectors[0] );
                  uiReadDirAndFillSelectorWindowContents( &selectors[1] );

                  refreshScreen = 2;

                  break;

               case _KEYCODE_F7:

                  createDir( selectors[activeSelectorIdx].path );

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
