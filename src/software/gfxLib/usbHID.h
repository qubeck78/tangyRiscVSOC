#ifndef _USBHID_H
#define _USBHID_H

#include "bsp.h"

#include "../gfxLib/osUIEvents.h"



int usbHIDInit( void );
int usbHIDHandleEvents( void );

#endif
