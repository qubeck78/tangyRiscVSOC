#ifndef _SREC_H
#define _SREC_H

#include "../gfxLib/gfTypes.h"

#define _BOOTLOADER_PROTECTION_ADDR ( 8 * 1024 ) 

int decodeAndDisplayS0Record( char *buf );
int decodeAndSaveS1_2_3Record( char *buf, ulong recordType );
int decodeAndExecuteS7_8_9Record( char *buf, ulong recordType );


#endif

