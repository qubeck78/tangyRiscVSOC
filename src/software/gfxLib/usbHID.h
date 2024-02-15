#ifndef _USBHID_H
#define _USBHID_H

#include "bsp.h"

#include "../gfxLib/osUIEvents.h"

//1000ms key repeat delay
#define USBHID_KEYREPEAT_DELAY   1000

//8 keypresses per second while repeating last pressed key
#define USBHID_KEYREPEAT_RATE    128


ulong usbHIDInit( void );
ulong usbHIDHandleEvents( void );

#endif
