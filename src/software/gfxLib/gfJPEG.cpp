#include "gfJPEG.h"


static pjpeg_image_info_t   jpegImageInfo;
static uchar            *gfJpegBuf;
static ulong             gfJpegBufSize;
static ulong             gfJpegBufIdx;
static tosFile          *gfJpegFile;

//decoder callback function - data from RAM
unsigned char gfJPEGDecoderCallbackRAM( unsigned char* pBuf, unsigned char buf_size, unsigned char *pBytes_actually_read, void *pCallback_data )
{
   ulong numBytesToCopy;
   ulong i;

   numBytesToCopy = buf_size;


   for( i = 0; i < numBytesToCopy; i++ )
   {
      pBuf[i] = gfJpegBuf[ gfJpegBufIdx++ ];

      if( gfJpegBufIdx >= gfJpegBufSize )
      {
         break;

      }

   }

   *pBytes_actually_read = i;

   return 0;
}

//decoder callback function - data from file
unsigned char gfJPEGDecoderCallbackFile( unsigned char* pBuf, unsigned char buf_size, unsigned char *pBytes_actually_read, void *pCallback_data )
{

   ulong bytesRead;

   bytesRead = 0;

   osFRead( gfJpegFile, pBuf, buf_size, &bytesRead );

   *pBytes_actually_read = bytesRead;

   return 0;
}


ulong gfJPEGDecode( uchar *jpegBuf, ulong jpegBufSize, tgfBitmap *bmp )
{
   unsigned char  pjRv;
   short       cx;
   short       cy;
   short           mcuX;
   short           mcuY;
   short           mcuWidth;
   short           mcuHeight;

   short           mcuIdx1;
   short           mcuIdx2;
   short           mcuIdx3;
   short           mcuIdx4;

   uchar           r;
   uchar           g;
   uchar           b;

   gfJpegBuf      = jpegBuf;
   gfJpegBufSize   = jpegBufSize;
   gfJpegBufIdx    = 0;

   //init decoder
   pjRv = pjpeg_decode_init( &jpegImageInfo, gfJPEGDecoderCallbackRAM, NULL, 0 );

   if( pjRv != 0 )
   {
      return 1;
   }

   //init bitmap

   bmp->width              = jpegImageInfo.m_width;
   bmp->rowWidth           = bmp->width;
   bmp->height             = jpegImageInfo.m_height;
   bmp->flags              = 0;
   bmp->transparentColor   = 0;
   bmp->buffer             = osAlloc( bmp->width * bmp->height * 2, OS_ALLOC_MEMF_CHIP );

   mcuWidth    = jpegImageInfo.m_MCUWidth;
   mcuHeight   = jpegImageInfo.m_MCUHeight;

   cx = 0;
   cy = 0;

   while( !pjpeg_decode_mcu() )
   {



      switch( mcuWidth )
      {

         case 8:

            switch( mcuHeight )
            {
               case 8:
                  //8x8

                  mcuIdx1 = 0;

                  for( mcuY = 0; mcuY < mcuHeight; mcuY++ )
                  {
                     for( mcuX = 0; mcuX < mcuWidth; mcuX++ )
                     {

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx1];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx1];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx1];

                        gfPlot( bmp, cx + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        mcuIdx1++;

                     }
                  }

                  break;

               case 16:

                  //8x16


                  break;

            }
            break;

         case 16:

            switch( mcuHeight )
            {
               case 8:

                  break;


               case 16:

                  //16x16

                  for( mcuY = 0; mcuY < 8; mcuY++ )
                  {
                     mcuIdx1 = mcuY * 8;
                     mcuIdx2 = 64 + mcuY * 8;
                     mcuIdx3 = 128 + mcuY * 8;
                     mcuIdx4 = 192 + mcuY * 8;

                     for( mcuX = 0; mcuX < 8; mcuX++ )
                     {

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx1];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx1];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx1];

                        gfPlot( bmp, cx + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx2];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx2];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx2];

                        gfPlot( bmp, cx + 8 + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx3];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx3];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx3];

                        gfPlot( bmp, cx + mcuX, cy + 8 + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx4];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx4];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx4];

                        gfPlot( bmp, cx + 8 + mcuX, cy + 8 + mcuY, gfColor( r, g, b ) );

                        mcuIdx1++;
                        mcuIdx2++;
                        mcuIdx3++;
                        mcuIdx4++;

                     }
                  }


                  break;

            }
            break;
      }

      cx += mcuWidth;

      if( cx >= bmp->width )
      {
         cx = 0;
         cy += mcuHeight;

         if( cy >= bmp->height )
         {
            cy = 0;
            break;
         }
      }

   }

   return 0;
}


ulong gfLoadJPEGFS( tgfBitmap *bmp, char *jpegFileName )
{
   tosFile     in;
   unsigned char  pjRv;
   short       cx;
   short       cy;
   short           mcuX;
   short           mcuY;
   short           mcuWidth;
   short           mcuHeight;

   short           mcuIdx1;
   short           mcuIdx2;
   short           mcuIdx3;
   short           mcuIdx4;

   uchar           r;
   uchar           g;
   uchar           b;

   if( osFOpen( &in, jpegFileName , OS_FILE_READ ) )
   {
      return 1;
   }

   gfJpegFile = &in;

   //init decoder
   pjRv = pjpeg_decode_init( &jpegImageInfo, gfJPEGDecoderCallbackFile, NULL, 0 );

   if( pjRv != 0 )
   {
      return 1;
   }

   //init bitmap

   bmp->width              = jpegImageInfo.m_width;
   bmp->rowWidth           = bmp->width;
   bmp->height             = jpegImageInfo.m_height;
   bmp->flags              = 0;
   bmp->transparentColor   = 0;
   bmp->buffer             = osAlloc( bmp->width * bmp->height * 2, OS_ALLOC_MEMF_CHIP );

   mcuWidth    = jpegImageInfo.m_MCUWidth;
   mcuHeight   = jpegImageInfo.m_MCUHeight;

   cx = 0;
   cy = 0;

   while( !pjpeg_decode_mcu() )
   {



      switch( mcuWidth )
      {

         case 8:

            switch( mcuHeight )
            {
               case 8:
                  //8x8

                  mcuIdx1 = 0;

                  for( mcuY = 0; mcuY < mcuHeight; mcuY++ )
                  {
                     for( mcuX = 0; mcuX < mcuWidth; mcuX++ )
                     {

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx1];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx1];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx1];

                        gfPlot( bmp, cx + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        mcuIdx1++;

                     }
                  }

                  break;

               case 16:

                  //8x16


                  break;

            }
            break;

         case 16:

            switch( mcuHeight )
            {
               case 8:

                  break;


               case 16:

                  //16x16

                  for( mcuY = 0; mcuY < 8; mcuY++ )
                  {
                     mcuIdx1 = mcuY * 8;
                     mcuIdx2 = 64 + mcuY * 8;
                     mcuIdx3 = 128 + mcuY * 8;
                     mcuIdx4 = 192 + mcuY * 8;

                     for( mcuX = 0; mcuX < 8; mcuX++ )
                     {

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx1];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx1];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx1];

                        gfPlot( bmp, cx + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx2];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx2];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx2];

                        gfPlot( bmp, cx + 8 + mcuX, cy + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx3];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx3];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx3];

                        gfPlot( bmp, cx + mcuX, cy + 8 + mcuY, gfColor( r, g, b ) );

                        r = jpegImageInfo.m_pMCUBufR[mcuIdx4];
                        g = jpegImageInfo.m_pMCUBufG[mcuIdx4];
                        b = jpegImageInfo.m_pMCUBufB[mcuIdx4];

                        gfPlot( bmp, cx + 8 + mcuX, cy + 8 + mcuY, gfColor( r, g, b ) );

                        mcuIdx1++;
                        mcuIdx2++;
                        mcuIdx3++;
                        mcuIdx4++;

                     }
                  }


                  break;

            }
            break;
      }

      cx += mcuWidth;

      if( cx >= bmp->width )
      {
         cx = 0;
         cy += mcuHeight;

         if( cy >= bmp->height )
         {
            cy = 0;
            break;
         }
      }

   }

   osFClose( &in );

    return 0;
}
