#ifndef _GFTYPES_H
#define _GFTYPES_H

#define _GFXLIB_VERSION 20231230


//#define _GFXLIB_SDL
//#define _GFXLIB_STM32_FATFS
//#define _GFXLIB_ESP32_FFAT
//#define _GFXLIB_BIG_ENDIAN

#define _GFXLIB_RISCV_FATFS
#define _GFXLIB_HW_BLITTER_2D



typedef unsigned char	uchar;
typedef unsigned char	ubyte;
typedef unsigned short	ushort;
typedef unsigned long	ulong;

#ifndef NULL
#define NULL 0
#endif


typedef union _fixed_t
{
	signed long l;
	
	struct
	{
		signed short dec;
		unsigned short fract;
	}v;

}fixed_t;



#define gfAbs(x) ((x)>0?(x):-(x))



#endif
