#ifndef _BSP_H
#define _BSP_H


//Memory regions

//7.5MB
#define _SYSTEM_MEMORY_SIZE 	( 7864320 - 16)
#define _SYSTEM_MEMORY_BASE		0x20000000

//512 KB
#define _FASTRAM_MEMORY_SIZE	524288
#define _FASTRAM_MEMORY_BASE	0x30000000

//31.5 MB
#define _SDRAM_MEMORY_SIZE		0x01F80000
#define _SDRAM_MEMORY_BASE		0x40000000



#define _VIDEOMODE_TEXT40_ONLY              0x00
#define _VIDEOMODE_TEXT80_ONLY              0x04

#define _VIDEOMODE_320_TEXT40_OVER_GFX      0x02
#define _VIDEOMODE_320_TEXT80_OVER_GFX      0x06

#define _VIDEOMODE_640_TEXT40_OVER_GFX      0x12
#define _VIDEOMODE_640_TEXT80_OVER_GFX      0x16

#include "gfTypes.h"



typedef struct _BSP_T
{
    //
    volatile unsigned long videoMuxMode;
    
    //b0 - vsync (positive)
    volatile unsigned long videoVSync;
    
    //pointer of gfx data to display (within DMA address space, address divided by 4)
    volatile unsigned long  dmaDisplayPointerStart;
        
    //wr b7, b6, b5, b4 - LEDS, b0 - spi0SSel
    volatile unsigned long gpoPort;
    
    //wr b0 - tickTimerReset
    volatile unsigned long tickTimerConfig;
    
    //rd - tickTimerValue
    volatile unsigned long tickTimerValue;
    
    //counts frames (up), write resets timer
    volatile unsigned long  frameTimer;
    

}BSP_T;


extern BSP_T *bsp;

typedef struct __FPALU_REGISTERS_T
{
    volatile float fpA;
    volatile float fpB;
    volatile float fpAddResult;
    volatile float fpSubResult;
    volatile float fpMulResult;
    volatile float fpDivResult;

}_FPALU_REGISTERS_T;

extern _FPALU_REGISTERS_T *fpalu;


typedef struct __BLITTER_REGISTERS_T
{
    //gouraud
    volatile signed short   c0AX;
    volatile unsigned short unused0;
    volatile signed short   c0AY;
    volatile unsigned short unused1;
    volatile signed short   c0BX;
    volatile unsigned short unused2;
    volatile signed short   c0BY;
    volatile unsigned short unused3;
    volatile signed short   c0CX;
    volatile unsigned short unused4;
    volatile signed short   c0CY;
    volatile unsigned short unused5;
    volatile signed short   c0Px;
    volatile unsigned short unused6;
    volatile signed short   c0Py;
    volatile unsigned short unused7;

    volatile signed long    c0EdgeEBA;
    volatile signed long    c0EdgeECB;
    volatile signed long    c0EdgeEAC;

    volatile unsigned short c0PInside;
    volatile unsigned short unused8;

    volatile signed long    c0Area;
    volatile signed long    c0weightWBA;    
    volatile signed long    c0weightWCB;
    volatile signed long    c0weightWAC;

    volatile unsigned short c0it0A;
    volatile unsigned short unused9;
    volatile unsigned short c0it0B;
    volatile unsigned short unused10;
    volatile unsigned short c0it0C;
    volatile unsigned short unused11;
    volatile unsigned short c0it0Out;
    volatile unsigned short unused12;
    volatile unsigned short c0it1A;
    volatile unsigned short unused13;
    volatile unsigned short c0it1B;
    volatile unsigned short unused14;
    volatile unsigned short c0it1C;
    volatile unsigned short unused15;
    volatile unsigned short c0it1Out;
    volatile unsigned short unused16;
    volatile unsigned short c0it2A;
    volatile unsigned short unused17;
    volatile unsigned short c0it2B;
    volatile unsigned short unused18;
    volatile unsigned short c0it2C;
    volatile unsigned short unused19;
    volatile unsigned short c0it2Out;
    volatile unsigned short unused20;

    //blitter
    volatile unsigned long bltStatus;
    
    //bits 7 downto 0 - blitter mode: 
    //0 - fill with value, 
    //1 - copy, 
    //2 - copy with transparent color (mask), 
    //3 - gouraud triangle, 
    //4 - textured triangle, 
    //5 - textured triangle with light
    //6 - copy with alpha
    //7 - copy with alpha and transparent color (mask)
    //8 - scale copy
    //9 - scale copy with transparent color (mask)
    
    //bits 11 downto 8 - texture size
    //0 - 16  x 16 
    //1 - 32  x 32
    //2 - 64  x 64
    //3 - 128 x 128
    //4 - 256 x 256
    
    //bit 12 - enable zBuffer
    //bit 13 - enable 32 bit transfer ( valid only for modes 0 and 1 )
    volatile unsigned long  bltConfig0;

    volatile unsigned long  bltValue;

    volatile unsigned long  bltSrcAddress;
    volatile unsigned long  bltDstAddress;
    volatile unsigned short bltSrcModulo;
    volatile unsigned short unused21;
    volatile unsigned short bltDstModulo;
    volatile unsigned short unused22;
    volatile unsigned short bltTransferWidth;
    volatile unsigned short unused23;
    volatile unsigned short bltTransferHeight;
    volatile unsigned short unused24;

    volatile unsigned short bltAlpha;
    volatile unsigned short unused25;

    volatile unsigned short c0AZ;
    volatile unsigned short unused26;
    volatile unsigned short c0BZ;
    volatile unsigned short unused27;
    volatile unsigned short c0CZ;
    volatile unsigned short unused28;
    volatile unsigned long  bltGouraudZBufferAddress;

    //blitter bitmap scaler
    volatile unsigned long bltScalerDeltaX;
    volatile unsigned long bltScalerDeltaY;
    volatile unsigned long bltScalerSourceWidth;
    volatile unsigned long bltScalerSourceHeight;

}_BLITTER_REGISTERS_T;

extern _BLITTER_REGISTERS_T *blt;

typedef struct __USBHOST_REGISTERS_T
{
    //usb HID host
    volatile unsigned long usbHidKeyboardStatus;
    volatile unsigned long usbHidKeyboardData;

}_USBHOST_REGISTERS_T;

extern _USBHOST_REGISTERS_T *usbhost;

typedef struct __UART_REGISTERS_T
{
    //wr - send data via uart, rd - read received data from fifo
    volatile unsigned long uartData;

    //b0 - suDataReceivedReady, b1 - suDataSenderReady
    volatile unsigned long uartStatus;

}_UART_REGISTERS_T;

extern _UART_REGISTERS_T *uart0;

typedef struct __SPI_REGISTERS_T
{
    //wr - send data via spi, rd - read received data
    volatile unsigned long spiData;
    
    //rd b0 - spiReady
    volatile unsigned long spiStatus;

}_SPI_REGISTERS_T;

extern _SPI_REGISTERS_T *spi0;


int     bspInit( void );
int     randomNumber( void );
void    itoaHex2Digits( int value, char* str );
void    itoaHex4Digits( int value, char* str );
void    itoaHex8Digits( int value, char* str );
ulong   getTicks( void );
void    delayMs( unsigned long delay );

int     setVideoMode( ulong videoMode );
void    reboot( void );



float inline ffMul( float a, float b )
{
    volatile ulong j;

    fpalu->fpA = a;
    fpalu->fpB = b;

    for( j = 0; j < 2; j++);


    return fpalu->fpMulResult;
}

float inline ffAdd( float a, float b )
{
    volatile ulong j;

    fpalu->fpA = a;
    fpalu->fpB = b;

    for( j = 0; j < 2; j++);
        
    return fpalu->fpAddResult;
}

float inline ffSub( float a, float b )
{
    volatile ulong j;

    fpalu->fpA = a;
    fpalu->fpB = b;

    for( j = 0; j < 2; j++);
        
    return fpalu->fpSubResult;
}

float inline ffDiv( float a, float b )
{
    volatile ulong j;

    fpalu->fpA = a;
    fpalu->fpB = b;

    for( j = 0; j < 8; j++);
        
    return fpalu->fpDivResult;
}

#endif
