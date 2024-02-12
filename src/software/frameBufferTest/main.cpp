#include "main.h"
#include <cstring>
#include <climits>

#include "../gfxLib/bsp.h"

BSP_T             *bsp     = ( BSP_T *)            0xf0000000; //registers base address 


ushort   textAttr;

ushort   *displayRam;
int       screenIndex;
ushort   *gfxRam;

char buf[128];

unsigned int random_state = 3242323459;

int randomNumber()
{
    unsigned int r = random_state;

    r ^= r << 13;
    r ^= r >> 17;
    r ^= r << 5;

    random_state = r;

    return r;
} 


int print( char *buf )
{
   char c;
   int i;

   i = 0;

   while( c = buf[ i++ ] )
   {  

      if( c == 13 )
      {

      }else if( c == 10 )
      {
         screenIndex -= screenIndex % 80;
         screenIndex += 80;
         if( screenIndex >= 2400 )
         {
            screenIndex = 0;
         }  
      }
      else
      {
         displayRam[ screenIndex++ ] = textAttr | c;
      }
   }

   return 0;
}

 
int main()
{
   int            i;
   volatile int   j;
   int            k;

   
   bsp->videoMuxMode             = _VIDEOMODE_320_TEXT80_OVER_GFX; 
   bsp->dmaDisplayPointerStart   = 0x0;

   displayRam  = ( ushort* )0x6d40;
   gfxRam      = ( ushort* )0x20000000;
   screenIndex = 0;  

   
   
   for( i = 0; i < 2400 ; i++ )
   {
     displayRam[i] = 0;
   }

   for( i = 0; i < 320 * 240; i++ )
   {
      gfxRam[i] = 0x0000;
   }

   textAttr = 0x3f00;

   print( (char*) "     |.\\__/.|    (~\\ \n" );
   print( (char*) "     | O O  |     ) )\n" );
   print( (char*) "   _.|  T   |_   ( ( \n" );   
   print( (char*) ".-- ((---- ((-------.\n" );
   print( (char*) "|                   |\n" ); 

   print( (char*) "|" );

   textAttr = 0x8f00;
   print( (char*) "  RISC-V tangySOC  " );

   textAttr = 0x3f00;
   print( (char*) "|\n|""  frameBuffer test ""|\n" );
   print( (char*) "|""  320x240 w/text   ""|\n" );
   print( (char*) "`-------------------`\n" );

   screenIndex = 80 * 4 + 40;
   textAttr = 0x0f00;
   print( (char*) "   Text without background  " );

   screenIndex = 80 * 5 + 40;
   textAttr = 0x8f00;
   print( (char*) " Text with shaded background " );

   screenIndex = 80 * 6 + 40;
   textAttr = 0x7f00;
   print( (char*) "    Text with background     " );


   textAttr = 0x8f00;

   k = 0;
   do
   {
      
      screenIndex = 80 * 10;

      for( i = 0; i < 80; i++ )
      {


         if( k < 80 )
         {
            if( i <= k )
            {
               print( (char*)"#" );
            }
            else
            {
               print( (char*)" " );
            }
         }
         else
         {
            if( i <= ( k - 80 ) )
            {
               print( (char*)" " );
            }
            else
            {
               print( (char*)"#" );
            }


         }
      }  

      k++;

      if( k >= 160 )
      {
         k = 0;
      }

   
      //for( j = 0; j < 10000; j++ );

      if( k == 0 )
      {
         for( i = 1200; i < 2400 ; i++ )
         {
            displayRam[i]  = randomNumber();
         }
      }

      for( i = 320 * 0; i < 320 * 120 ; i++ )
      {
         gfxRam[i] = randomNumber();
      }

   }while( 1 );

} 