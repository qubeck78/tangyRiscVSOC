#include "usbHID.h"

uchar activeKeys[4];
uchar shiftState;

const char HIDkeys[] = {
    0x0, '-', 0x0, 0x00,
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
    's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    _KEYCODE_ENTER, _KEYCODE_ESC, _KEYCODE_BACKSPACE, // DEL
    _KEYCODE_TAB, // TAB
    ' ', // SPACE
    '-', '=', '[', ']', '\\', 0x00, ';', '\'', '`', ',', '.', '/', 
    _KEYCODE_CAPSLOCK, 
    _KEYCODE_F1, _KEYCODE_F2, _KEYCODE_F3, _KEYCODE_F4, _KEYCODE_F5, _KEYCODE_F6, _KEYCODE_F7, _KEYCODE_F8, _KEYCODE_F9, _KEYCODE_F10, _KEYCODE_F11, _KEYCODE_F12,
    _KEYCODE_PRTSCR, _KEYCODE_SCRLOCK, _KEYCODE_PAUSE, _KEYCODE_INSERT, _KEYCODE_HOME , _KEYCODE_PGUP, _KEYCODE_DELETE, _KEYCODE_END, _KEYCODE_PGDOWN, 
    _KEYCODE_RIGHT, // R_ARROW
    _KEYCODE_LEFT, // L_ARROW
    _KEYCODE_DOWN, // D_ARROW
    _KEYCODE_UP, // U_ARROW
};

const char HIDKeysShifted[] = {
    0x0, 0x0, '-', 0x0,
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
    'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
    'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
    _KEYCODE_ENTER, _KEYCODE_ESC, _KEYCODE_BACKSPACE, 
    _KEYCODE_TAB, // TAB
    ' ', // SPACE
    '_', '+', '{', '}', '|', 0x0, ':', '"', '~', '<', '>', '?', 
    _KEYCODE_CAPSLOCK, 
    _KEYCODE_F1, _KEYCODE_F2, _KEYCODE_F3, _KEYCODE_F4, _KEYCODE_F5, _KEYCODE_F6, _KEYCODE_F7, _KEYCODE_F8, _KEYCODE_F9, _KEYCODE_F10, _KEYCODE_F11, _KEYCODE_F12,
    _KEYCODE_PRTSCR, _KEYCODE_SCRLOCK, _KEYCODE_PAUSE, _KEYCODE_INSERT, _KEYCODE_HOME, _KEYCODE_PGUP, _KEYCODE_DELETE, _KEYCODE_END, _KEYCODE_PGDOWN, 
    _KEYCODE_RIGHT, // R_ARROW
    _KEYCODE_LEFT, // L_ARROW
    _KEYCODE_DOWN, // D_ARROW
    _KEYCODE_UP, // U_ARROW
};


static int findInArray( uchar element, uchar *array, int arrayLength )
{
  int i;

  for( i = 0; i < arrayLength; i++ )
  {
    if( array[i] == element )
    {
      return i;
    }
  }

  return -1;
}

int usbHIDInit()
{
  int i;

  for( i = 0 ; i < sizeof( activeKeys ); i++ )
  {
    activeKeys[i] = 0;
  }

  shiftState = 0;

	return 0;
}

static int usbHIDRxMain( ulong rxData )
{
	uchar 		shf;
	uchar 		keys[3];
	int			i;
	int			pos;
	tosUIEvent	event;
	
	shf		= ( rxData >> 24 ) & 0xff;
	keys[2]	= ( rxData >> 16 ) & 0xff;
	keys[1] = ( rxData >> 8 ) & 0xff;
	keys[0]	= ( rxData ) & 0xff;
	
	//check shift state
	
	if(( shf & 0x02 ) || ( shf & 0x20 ))
	{
		shiftState |= SST_SHIFT;
	}
	else
	{
		shiftState &= ( SST_SHIFT ^ 0xff );
	}
	
	if( shf & 0x01 )
	{
		shiftState |= SST_CONTROL;
	}
	else
	{
		shiftState &= ( SST_CONTROL ^ 0xff );
	}
	  
	if( ( shf & 0x04 ) || ( shf & 0x40 ) )
	{
		shiftState |= SST_ALT;
	}
	else
	{
		shiftState &= ( SST_ALT ^ 0xff );
	}
	
	//check for key release
	for( i = 0; i < sizeof( activeKeys ); i++ )
	{
		if( activeKeys[i] != 0 )
		{
			//check if still pressed
			pos = findInArray( activeKeys[i], keys, sizeof( keys ) );
			
			if( pos == -1 )
			{
				//key has been released
				
				//todo: send event
				activeKeys[i] = 0;
			}
		}
	}
	
	//check for key press
	for( i = 0; i < sizeof( keys ); i++ )
	{
		if( keys[i] != 0 )
		{
			//we have a scancode
		
			//check if already pressed
			pos = findInArray( keys[i], activeKeys, sizeof( activeKeys ) );
		
			if( pos == -1 )
			{
				//key is not in activekeys, so we have a keydown event

				//store key value
				//find empty slot
				pos = findInArray( 0, activeKeys, sizeof( activeKeys ) );
				if( pos == -1 )
				{
					//error - not free slots, abort
				}
				else
				{
					//save key code
					activeKeys[pos] = keys[i];

					//generate keypress event
					event.type	= OS_EVENT_TYPE_KEYBOARD_KEYPRESS;
					
					if( shiftState & SST_SHIFT )
					{
						event.arg1	= HIDKeysShifted[ keys[i] ];
					}
					else
					{
						event.arg1	= HIDkeys[ keys[i] ];					
					}
					event.arg2	= shiftState;
					event.arg3	= 0;
					event.obj	= NULL;
					
					osPutUIEvent( &event );

				}		
		
			}
		}
	}
	

	return 0;
}


int usbHIDHandleEvents( void )
{
	ulong currKeys;
	ulong lastKeys;
	
	if( ! ( usbhost->usbHidKeyboardStatus & 1 ) )
	{
		while( ! ( usbhost->usbHidKeyboardStatus & 1 ))
		{
			currKeys = usbhost->usbHidKeyboardData;
			usbHIDRxMain( currKeys );
		}
			
/*		lastKeys = bsp->usbHidKeyboardData;
		if( lastKeys != currKeys )
		{
			usbHIDRxMain( lastKeys );
		}
		*/
	}
	
	return 0;
}