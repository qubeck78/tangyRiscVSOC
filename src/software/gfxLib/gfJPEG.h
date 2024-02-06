#ifndef _GFJPEG_H
#define _GFJPEG_H

#include "gfTypes.h"
#include "picojpeg.h"

#include "gfDrawing.h"
#include "gfBitmap.h"
#include "osAlloc.h"
#include "osFile.h"


ulong gfJPEGDecode( uchar *jpegBuf, ulong jpegBufSize, tgfBitmap *bmp );
ulong gfLoadJPEGFS( tgfBitmap *bmp, char *jpegFileName );



#endif
