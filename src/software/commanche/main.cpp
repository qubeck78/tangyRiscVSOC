#include "main.h"
#include <cstring>
#include <climits>
#include <math.h>

#include "../gfxLib/bsp.h"
#include "../gfxLib/osAlloc.h"
#include "../gfxLib/osFile.h"
#include "../gfxLib/gfBitmap.h"
#include "../gfxLib/gfDrawing.h"
#include "../gfxLib/gfFont.h"
#include "../gfxLib/osUIEvents.h"


extern BSP_T        *bsp;


extern tgfTextOverlay        con;
tgfBitmap            screen1;
tgfBitmap            screen2;
tgfBitmap            textureMap;
uchar               *heightMap;

tosFile in;


struct {
      float x;       // x position on the map
      float y;       // y position on the map
      short height;  // height of the camera
      float angle;   // direction of the camera
      short horizon; // horizon position (look up and down)
      float distance; // distance of map
   } camera = { 256, 256, 40, 0.1, 50, 180 };

char buf[128];

int animLeds( int j )
{   
      switch( j % 4 )
      {
         case 0:
            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0010;
         
            break;

         case 1:

            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0020;
         
            break;

         case 2:
         
            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0040;

            break;

         case 3:
      
            bsp->gpoPort |= 0x00f0;
            bsp->gpoPort ^= 0x0080;

            break;
      }
      
   return 0;
} 


int commanche( tgfBitmap *screen )
{

   int     screenwidth = 160;
   float   screenwidthf = screenwidth;
   
   int     screenheight = 120;

   int     mapwidthperiod = 512 - 1;
   int     mapheightperiod = 512 - 1;
   int     mapshift = 9;
   long    mapoffset;
   float   deltaz = 1.5f;
   short   y;
   short   x;
   float   z;
   float   invz;
   short   heightonscreen;
   ushort  color;
   long    cameraoffs;
   float   sinang;
   float   cosang;
   float   plx;
   float   ply;
   float   prx;
   float   pry;
   float   dx;
   float   dy;
   
   short    bw;
   short    bh;

   long    linvz;
   short   hiddeny[ 320 ];

   long    lplx;
   long    lply;
   long    ldx;
   long    ldy;
   float   cosangz;
   float   sinangz;
   
//    gfFillRect( screen, 80, 60, 80 + screenwidth, 60 + screenheight, 0 );
//    gfFillRect( screen, 0, 60, 319, 60 + screenheight, 0 );

   //clear screen
   do{}while( ! ( blt->bltStatus & 1 ) );

   blt->bltConfig0         = 0x2000;   //32 bit fill value
   blt->bltDstAddress      = ( ulong )(( ( ulong )screen->buffer + ( 512 * 60 ) - _SYSTEM_MEMORY_BASE ) / 4);
   blt->bltTransferHeight  = 120;
   blt->bltTransferWidth   = 160;
   blt->bltSrcModulo       = 0;
   blt->bltDstModulo       = 96;
   blt->bltValue           = 0x00000000;   
   
   blt->bltStatus          = 0x1;


   
   sinang      = (float)sin( camera.angle );
   cosang      = (float)cos( camera.angle );
   cameraoffs  = ( ( ((int)camera.y) & mapwidthperiod ) << mapshift ) + ( ((int)camera.x) & mapheightperiod );
   // Collision detection. Don't fly below the surface.
   if( ( heightMap[ cameraoffs ] + 10.0f ) > camera.height )
   {
      camera.height = heightMap[ cameraoffs ] + 10.0f;
   }

   for( x = 0; x < screenwidth; x++ )
   {
      hiddeny[ x ] = screenheight;
   }
   // Draw from front to back
   for( z = 1.0f; z < camera.distance; z += deltaz )
   {
      // 90 degree field of view
      
      //cosangz = cosang * z;
      cosangz = ffMul( cosang, z );

      //sinangz   = sinang * z;
      sinangz = ffMul( sinang, z );

      
      //plx =  ( -cosangz ) - sinangz;
      plx = ffSub( ffMul( cosangz, -1.0f ), sinangz );

      //ply =   sinangz - cosangz;
      ply = ffSub( sinangz, cosangz );

      //prx =   cosangz - sinangz;
      prx = ffSub( cosangz, sinangz );

      //pry =  ( -sinangz ) - cosangz;
      pry = ffSub( ffMul( sinangz, -1.0f ), cosangz );


/*      plx =  -cosang * z - sinang * z;
      ply =   sinang * z - cosang * z;
      prx =   cosang * z - sinang * z;
      pry =  -sinang * z - cosang * z;
*/      
      
      //dx = ( prx - plx ) / screenwidth;

      dx = ffDiv( ffSub( prx, plx ), (float)screenwidth );

      //dy = ( pry - ply ) / screenwidth;
      dy = ffDiv( ffSub( pry, ply ), (float)screenheight );

      
      //plx += camera.x;
      plx = ffAdd( plx, camera.x );

      //ply += camera.y;
      ply = ffAdd( ply, camera.y );

//      invz = 1.0f / z * 100.0f;
//      invz = 100.0f / z;
      
//      linvz = invz * 256;
//      linvz = 25600 / (long)z;
      linvz = 12800 / (long)z;
   
   
      
      lplx    = (long)ffMul( plx, 256.0f );
      lply    = (long)ffMul( ply, 256.0f );
      ldx = (long)ffMul( dx, 256.0f );
      ldy = (long)ffMul( dy, 256.0f );

      /*lplx  = plx * 256;
      lply    = ply * 256;
      ldx     = dx * 256;
      ldy     = dy * 256;
      */
      
      for( x = 0; x < screenwidth; x++ )
      {
//          mapoffset = ( ( ((long)ply) & mapwidthperiod ) << mapshift ) + ( ((long)plx) & mapheightperiod );
         mapoffset = ( ( ( lply >> 8 ) & mapwidthperiod ) << mapshift ) + ( ( lplx >> 8 ) & mapheightperiod );
         
         heightonscreen = (short)( ( ( ( camera.height - heightMap[ mapoffset ] ) * linvz ) >> 8 ) + camera.horizon );
         
         if( heightonscreen < 0 )
         {
            heightonscreen = 0;
         }
         color = ((ushort *)textureMap.buffer)[ mapoffset ];
         
         if( heightonscreen < hiddeny[x] )
         {                
            //draw strip
            do{}while( ! ( blt->bltStatus & 1 ) ); 
            
            bh = hiddeny[ x ] - heightonscreen;
   
            blt->bltConfig0         = 0x0000;   //fill with value
         
            blt->bltDstAddress      = ( ulong )(( ( ulong ) &(( ushort* )screen->buffer)[ ( ( heightonscreen + 60 ) * 512 ) + ( x << 1 ) ] - _SYSTEM_MEMORY_BASE ) / 2);
            blt->bltDstModulo       = 510;

            blt->bltTransferWidth   = 2;
            blt->bltTransferHeight  = bh - 1;
         
            blt->bltValue           = color;
   
            blt->bltStatus          = 0x1;  
   
         }
         
         if( heightonscreen < hiddeny[ x ] )
         {
            hiddeny[ x ] = heightonscreen;
         }

         //plx += dx;
         //ply += dy;
         
         lplx += ldx;
         lply += ldy;
         
      }

      
      //deltaz += 0.005f;
      deltaz = ffAdd( deltaz, 0.0025f );

   }

   return 0;
}

int main()
{
   ulong           i;
   ulong           rv;
   
   tosUIEvent      event;

   bspInit();
      
   setVideoMode( _VIDEOMODE_320_TEXT80_OVER_GFX );

   toPrint( &con, (char*)"tangyRiscVSOC Commanche B20240404\n" );
   toPrint( &con, (char*)"Map loading..." );

   //alloc screen buffers
   screen1.width           = 320;
   screen1.rowWidth        = 512;
   screen1.height          = 240;
   screen2.width           = 320;
   screen2.rowWidth        = 512;
   screen2.height          = 240;
   
   
   screen1.flags           = 0;
   screen1.transparentColor = 0;
   screen1.buffer           = osAlloc( screen1.rowWidth * screen1.height * 2, OS_ALLOC_MEMF_CHIP );  
   
   if( screen1.buffer == NULL )
   {
      toPrint( &con, (char*)"\nCan't alloc screen 1\n" );
      do{}while( 1 );
   } 
      
   screen2.flags           = 0;
   screen2.transparentColor = 0;
   screen2.buffer           = osAlloc( screen2.rowWidth * screen2.height * 2, OS_ALLOC_MEMF_CHIP ); 
   
   if( screen2.buffer == NULL )
   {
      toPrint( &con, (char*)"\nCan't alloc screen 2\n" );
      do{}while( 1 );
   } 
   
   //display first buffer
   gfDisplayBitmap( &screen1 );

   gfFillRect( &screen1, 0, 0, screen1.width - 1, screen1.height - 1 , gfColor( 0, 0, 0 ) ); 
   gfFillRect( &screen2, 0, 0, screen1.width - 1, screen1.height - 1 , gfColor( 0, 0, 0 ) ); 
   
   //init filesystem
   rv = osFInit();

   //init events queue
   osUIEventsInit();   

   rv = gfLoadBitmapFS( &textureMap, (char*)"ctexture.gbm" );

   if( rv )
   {
      toPrint( &con, (char*)"\nError, copy ctexture.gbm file to sd-card\n" );
   }

   heightMap = (uchar*)osAlloc( 262144, OS_ALLOC_MEMF_CHIP );

   if( !osFOpen( &in, (char*)"cheight.raw" , OS_FILE_READ ) )
   {
      osFRead( &in, (uchar*)heightMap, 262144, NULL );
      osFClose( &in );
   }
   else
   {
      toPrint( &con, (char*)"\nError, copy cheight.raw file to sd-card\n" );
   }
   
   i = 0;


   toPrint( &con, (char*)"done\n" );
      
   do
   {   
      animLeds( i++ );
      
      while( !osGetUIEvent( &event ) )
      { 
         if( event.type == OS_EVENT_TYPE_KEYBOARD_KEYPRESS )
         {
            switch( event.arg1 )
            {
               case _KEYCODE_PAUSE:

                  reboot();
                  break;  

               case _KEYCODE_LEFT:

                  camera.angle += 0.1;

                  break;

               case _KEYCODE_RIGHT:

                  camera.angle -= 0.1;

                  break;

               case _KEYCODE_UP:

                  camera.height += 1;

                  break;

               case _KEYCODE_DOWN:

                  if( camera.height > 0 )
                  {
                     camera.height -= 1;
                  }

                  break;
            }
         }
      }


      camera.x -= (float)sin( camera.angle ) * 1.1f;
      camera.y -= (float)cos( camera.angle ) * 1.1f;

      if( i & 1 )
      {
         gfDisplayBitmap( &screen2 );
         
         do{}while( ! bsp->videoVSync );
         
         commanche( &screen1 );
      }
      else
      {

         gfDisplayBitmap( &screen1 );
         
         do{}while( ! bsp->videoVSync );

         commanche( &screen2 );
      }

      
   }while( 1 ); 
   
} 