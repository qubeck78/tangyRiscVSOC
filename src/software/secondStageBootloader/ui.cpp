#include "ui.h"
#include "main.h"

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/gfGouraud.h"
#include "../gfxLib/osUIEvents.h"


extern tgfTextOverlay    con;

extern long              selectorWindowIdx;
extern long              selectorCursorPos;
extern long              selectorWindowHeight;
extern char              selectorFileNames[ 26 ][ _MAXFILENAMELENGTH + 1 ];

tosDir                  dir;
tosDirItem              dirItem;


ulong uiInit()
{

   return 0;
}


ulong uiRedrawConsole()
{
   con.textAttributes = 0x08;

   toCls( &con );

   toSetCursorPos( &con, 80 - 19, 26 ); toPrint( &con, (char*) "   |.\\__/.|    (~\\" );
   toSetCursorPos( &con, 80 - 19, 27 ); toPrint( &con, (char*) "   | O O  |     ) )" );
   toSetCursorPos( &con, 80 - 19, 28 ); toPrint( &con, (char*) " _.|  T   |_   ( (" );   
   toSetCursorPos( &con, 80 - 19, 29 ); toPrint( &con, (char*) "- ((---- ((-------" );

   toSetCursorPos( &con, 0, 27 );
   toPrint( &con, (char*) "tangyRiscVSOC" );

   toSetCursorPos( &con, 0, 28 );
   toPrint( &con, (char*) "bootloader" );

   toSetCursorPos( &con, 0, 29 );
   toPrint( &con, (char*) _BUILD_DATE );
   con.textAttributes = 0x8f;

   toSetCursorPos( &con, 29, 2 );
   toPrint( &con, (char*) "Select program to load" );


   return 0;   
}

ulong uiReadDirAndFillSelectorWindowContents()
{
   int rv;
   int i;
   int j;


   rv = 0;

   //clear selector windows contents
   for( i = 0 ; i < selectorWindowHeight; i++ )
   {
      selectorFileNames[i][0] = 0x0;

   }


   rv = osDirOpen( &dir, (char*)"0:apps" );

   i = 0;
   j = 0;

   do
   {

      rv = osDirRead( &dir, &dirItem );

      if( rv )
      {
         break;
      }

      if( j >= selectorWindowIdx )
      {

         if( dirItem.type != OS_DIRITEM_DIR )
         {
            strncpy( selectorFileNames[i], dirItem.name, _MAXFILENAMELENGTH );
            i++;
         }
      }

      j++;  //directory item index

   }while( i < selectorWindowHeight );


   osDirClose( &dir );

   return 0;
}

ulong uiDrawSelectorWindowContents()
{
   ulong    rv;
   ulong    i;
   ulong    j;
   char     buf[50];

   rv = 0;

   con.textAttributes   = 0x0f;
   for( i = 0; i < selectorWindowHeight; i++ )
   {

      //clear buf
      for( j = 0; j < 38; j++ )
      {
         buf[j]      = ' ';
         buf[j + 1]  = 0;
      }

      j = strlen( selectorFileNames[i] );

      if( j > 0 )
      {

         if( j > 38 )
         {
            j = 38;
         }

         //center file name
         strncpy( &buf[ 19 - j / 2 ], selectorFileNames[i], j );

         //extend buf
         for( j = strlen( buf ); j < 38; j++ )
         {
            buf[j]      = ' ';
            buf[j + 1]  = 0;
         }

      }

      toSetCursorPos( &con, 21, 4 + i );

      if( selectorCursorPos == i )
      {
         con.textAttributes = 0x8e;
      }
      else
      {
         con.textAttributes = 0x0f;
      }

      toPrint( &con, buf );

   }

   return rv;
}
