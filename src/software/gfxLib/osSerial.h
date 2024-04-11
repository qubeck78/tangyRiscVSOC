#ifndef _OSSERIAL_H
#define _OSSERIAL_H

#include "gfTypes.h"

ulong osSerialOpen( ulong serialNum, ulong baudRate );
ulong osSerialClose( ulong serialNum );
long  osSerialGetC( ulong serialNum );
ulong osSerialClearRxFifo( ulong serialNum );
ulong osSerialPutC( ulong serialNum, uchar c );
ulong osSerialGetS( ulong serialNum, char *buf, ulong maxLength, ulong timeoutMs );
ulong osSerialPrint( ulong serialNum, char *buf );

#endif
