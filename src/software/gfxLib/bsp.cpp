
#include "bsp.h"

#include <climits>
#include "gfFont.h"
#include "osAlloc.h"

BSP_T *bsp                      = ( BSP_T *)                0xf0000000; //registers base address

_FPALU_REGISTERS_T *fpalu       = ( _FPALU_REGISTERS_T *)   0xf0100000; //fpalu base address
_BLITTER_REGISTERS_T *blt       = ( _BLITTER_REGISTERS_T *) 0xf0200000; //blitter base address
_USBHOST_REGISTERS_T *usbhost   = ( _USBHOST_REGISTERS_T *) 0xf0300000; //hid usb host base address
_UART_REGISTERS_T *uart0        = ( _UART_REGISTERS_T *)    0xf0400000; //uart 0 base address
_SPI_REGISTERS_T *spi0          = ( _SPI_REGISTERS_T *)     0xf0500000; //spi 0 base address


void (*bootLoaderEntry)(void) = (void(*)())0x0; 

tgfTextOverlay       con;


unsigned int random_state = 3242323459;

int bspInit()
{
    random_state            = ( bsp->tickTimerValue << 16 ) | ( bsp->tickTimerValue ^ 0xf123 );

    osAllocInit();
    osAllocAddNode( 0, ( void* )_SYSTEM_MEMORY_BASE, _SYSTEM_MEMORY_SIZE, OS_ALLOC_MEMF_CHIP );
    osAllocAddNode( 1, ( void* )_SDRAM_MEMORY_BASE, _SDRAM_MEMORY_SIZE, OS_ALLOC_MEMF_FAST );

    bsp->videoMuxMode       = 0x02; //text over gfx, 320x240
    
    //connect gfxlib con to hardware text overlay   
    con.type                = GF_TEXT_OVERLAY_TYPE_HARDWARE;
    con.flags               = 0;
    con.width               = 80;               //clear whole buffer
    con.height              = 30;
    con.cursX               = 0;
    con.cursY               = 0;
    con.textAttributes      = 0x0f;
    con.font                = NULL;
    con.textBuffer          = (uchar*) 0x6d40; //hw text mode buffer address

    toCls( &con );

    con.width               = 40;               //default 40x30 console

    con.textAttributes      = 0x8f; 

    bootLoaderEntry = (void(*)())0x0; 

    return 0;
} 

int randomNumber()
{
    unsigned int r = random_state;

    r ^= r << 13;
    r ^= r >> 17;
    r ^= r << 5;

    random_state = r;

    return r;
} 

void hexDigit(char *string,char digit)
{
    digit &= 0x0f;
    
    if( digit<10 )
    {
        string[0] = digit + '0';
        string[1] = 0;
    }
    else
    {
        string[0] = digit + 'a' - 10;
        string[1] = 0;
    }
}

void itoaHex2Digits( int value, char* str )
{
    hexDigit(&str[0], ( value >> 4 ) & 0x0f );
    hexDigit(&str[1], ( value ) & 0x0f );
}

void itoaHex4Digits( int value, char* str )
{
    hexDigit(&str[4], ( value >> 12 ) & 0x0f );
    hexDigit(&str[5], ( value >> 8 ) & 0x0f );

    hexDigit(&str[6], ( value >> 4) & 0x0f );
    hexDigit(&str[7], ( value ) & 0x0f );
}


void itoaHex8Digits( int value, char* str )
{
    hexDigit(&str[0], ( value >> 28 ) & 0x0f );
    hexDigit(&str[1], ( value >> 24 ) & 0x0f );

    hexDigit(&str[2], ( value >> 20 ) & 0x0f );
    hexDigit(&str[3], ( value >> 16 ) & 0x0f );

    hexDigit(&str[4], ( value >> 12 ) & 0x0f );
    hexDigit(&str[5], ( value >> 8 ) & 0x0f );

    hexDigit(&str[6], ( value >> 4) & 0x0f );
    hexDigit(&str[7], ( value ) & 0x0f );
}

ulong getTicks()
{
    return bsp->tickTimerValue;
}

void delayMs( unsigned long delay )
{
    unsigned long startMs;
    
    startMs = bsp->tickTimerValue;
    
    while( bsp->tickTimerValue < ( startMs + delay ) );
    
}

int setVideoMode( ulong videoMode )
{
    bsp->videoMuxMode = videoMode;
    
    //check textmode: 40 or 80 column and adjust console width
    if( videoMode & _VIDEOMODE_TEXT80_ONLY )
    {
        con.width = 80;
    }
    else
    {
        con.width = 40;     
    }

    return 0;
}

void reboot()
{
    (*bootLoaderEntry)();
}
