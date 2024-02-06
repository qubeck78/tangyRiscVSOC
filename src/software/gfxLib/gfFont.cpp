
#include "gfFont.h"
#include "gfBitmap.h"
#include "gfDrawing.h"
#include "osAlloc.h"
#include "osFile.h"

#include <stdarg.h>

#define _IS_UPPER(c)    (((c)>='A')&&((c)<='Z'))
#define _IS_LOWER(c)    (((c)>='a')&&((c)<='z'))
#define _IS_DIGIT(c)    (((c)>='0')&&((c)<='9'))


ulong gfLoadFontFS( tgfFont *dest, char *fileName )
{
	tosFile file;
	uchar	buf[4];
	int		i;

	ushort	fontType;
	ulong	charBufOffset;
	ulong	charBufSize;

	if ( !osFOpen( &file, fileName, OS_FILE_READ ) )
	{
		osFRead( &file, (uchar*)buf, 2, NULL );

		fontType  = buf[0];
		fontType |= ( buf[1] << 8 );

		switch( fontType )
		{
			case  GF_FONT_TYPE_ALPHA4_BITMAP_VAR_WIDTH:

				dest->type = GF_FONT_TYPE_ALPHA4_BITMAP_VAR_WIDTH;


				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->flags = buf[0];
				dest->flags |= ( buf[1] << 8 );

				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->width = buf[0];
				dest->width |= ( buf[1] << 8 );

				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->height = buf[0];
				dest->height |= ( buf[1] << 8 );

				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->charColor = buf[0];
				dest->charColor |= ( buf[1] << 8 );

				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->backgroundColor = buf[0];
				dest->backgroundColor |= ( buf[1] << 8 );

				osFRead( &file, (uchar*)buf, 2, NULL );

				dest->firstChar = buf[0];
				dest->lastChar 	= buf[1];

				//char widths - has to be 22

				osFRead( &file, (uchar*)buf, 4, NULL );

				i  = buf[0];
				i |= ( buf[1] << 8 );
				i |= ( buf[2] << 16 );
				i |= ( buf[3] << 24 );

				if( i != 22)
				{

					osFClose( &file );
					return 2;
				}

				//char buffer offset
				osFRead( &file, (uchar*)buf, 4, NULL );

				charBufOffset  = buf[0];
				charBufOffset |= ( buf[1] << 8 );
				charBufOffset |= ( buf[2] << 16 );
				charBufOffset |= ( buf[3] << 24 );

				dest->charWidths = (uchar *)osAlloc( 256, OS_ALLOC_MEMF_CHIP );
				for( i = 0; i < 256 ; i++ )
				{
					( ( uchar* ) dest->charWidths )[i] = 0;
				}

				charBufSize = 0;

				//char widths
				for( i = dest->firstChar ; i <= dest->lastChar; i ++ )
				{
					osFRead( &file, (uchar*)buf, 1, NULL );
					( ( uchar* ) dest->charWidths )[i - dest->firstChar] = buf[0];

					charBufSize += ( ( uchar* ) dest->charWidths )[i - dest->firstChar];
				}

				charBufSize /= 2;   //2 pixels per byte
				charBufSize *= dest->height;

				dest->charBuffer = osAlloc( charBufSize, OS_ALLOC_MEMF_CHIP );

				for( i = 0; i < charBufSize; i++ )
				{
					osFRead( &file, (uchar*)buf, 1, NULL );
					( ( uchar* ) dest->charBuffer )[i] = buf[0];
				}

				osFClose( &file );

				return 0;

			break;


			default:

				osFClose( &file );

				return 2;
				break;
		}
	}

	return 0;

}


short gfPutChar( tgfBitmap *bmp, tgfFont *font, short x, short y, char c )
{
	short	 cx;
	short 	 cy;
	int      i;
	ulong    letterDataIdx;

	uchar 	*letterPtr;
	char 	 letterData;
	ushort	 alpha1;
	ushort	 alpha2;

	if( c < font->firstChar )
	{
		return 0;
	}
	if( c > font->lastChar )
	{
		return 0;
	}


	
	switch( font->type )
	{
		case GF_FONT_TYPE_MONO_BITMAP_FIXED_WIDTH:

			c -= font->firstChar;
			
			letterPtr = &((uchar *)font->charBuffer)[ c * font->height ];

			for( cy = 0; cy < font->height ; cy++ )
			{
				letterData = *letterPtr++;

				for( cx = 0; cx < font->width; cx++ )
				{
					if( letterData & 0x80 )
					{
						gfPlot( bmp, cx + x, cy + y, font->charColor );
					}else
					{
						if( ! ( font->flags & GF_FONT_FLAG_TRANSPARENT ) )
						{

							if( font->flags & GF_FONT_FLAG_ALPHA_BACKGROUND )
							{
								gfPlotA( bmp, cx + x, cy + y, font->backgroundColor, 128 );
							}
							else
							{
								gfPlot( bmp, cx + x, cy + y, font->backgroundColor );
							}
						}
					}

					letterData <<= 1;

				}
			}

			break;

		case GF_FONT_TYPE_ALPHA4_BITMAP_VAR_WIDTH:

			letterDataIdx = 0;
		   	c -= font->firstChar;

			for( i = 0; i < c; i++ )
			{
				cx =  ( ( uchar * )font->charWidths)[ i ];

				if( cx & 1 )
				{
					cx ++;
				}

                letterDataIdx += cx;
			}

			letterDataIdx /= 2;
			letterDataIdx *= font->height;

			for( cy = 0; cy < font->height; cy++ )
			{
				for( cx = 0; cx < ( ( uchar* )font->charWidths)[ c ] ; cx+=2 )
				{
					letterData = (( uchar *)font->charBuffer)[ letterDataIdx++ ];

					if( ! ( font->flags &  GF_FONT_FLAG_TRANSPARENT ) )
					{
						if( font->flags & GF_FONT_FLAG_ALPHA_BACKGROUND )
						{
							gfPlotA( bmp, cx + x, cy + y, font->backgroundColor, 128 );
							gfPlotA( bmp, cx + x + 1, cy + y, font->backgroundColor, 128 );
						}
						else
						{
							gfPlot( bmp, cx + x, cy + y, font->backgroundColor );

							gfPlot( bmp, cx + x + 1, cy + y, font->backgroundColor );
						}
					}

					alpha1 = letterData & 0xf0;
					alpha2 = ( letterData & 0x0f ) << 4;

					if( alpha1 )
					{	
						if( alpha1 != 0xf0 )
						{
							gfPlotA( bmp, cx + x, cy + y, font->charColor, alpha1 );
						}
						else
						{
							gfPlot( bmp, cx + x, cy + y, font->charColor );							
						}
					}

					if( alpha2 )
					{
						if( alpha2 != 0xf0 )
						{
							gfPlotA( bmp, cx + x + 1, cy + y, font->charColor, alpha2 );
						}
						else
						{
							gfPlot( bmp, cx + x + 1, cy + y, font->charColor );
						}
                    }
				}
			}


			return ( ( uchar* )font->charWidths)[ c ];

			break;


		default:

			return 0;

			break;

	}
	return font->width;
}

short gfPutString( tgfBitmap *bmp, tgfFont *font, short x, short y, char *string )
{
	short 	stringWidth;
	short   sw;
	char    c;

	stringWidth = 0;

	while( ( c = *string++ ) )
	{
		sw = gfPutChar( bmp, font, x, y, c );

		x += sw;

		stringWidth += sw;

	}

	return stringWidth;
}


ulong gfDrawTextOverlay( tgfBitmap *bmp, tgfTextOverlay *textOverlay, short x, short y )
{
	short	 cx;
	short	 cy;

	uchar    letter;
	uchar    attributes;
	uchar    r;
	uchar    g;
	uchar    b;
	uchar    alphaBackground;

	uchar   *textDataPtr;
	tgfFont *font;

	if( textOverlay->type == GF_TEXT_OVERLAY_TYPE_HARDWARE ) 
	{
		//text overlay is drawn by hardware, no need to do anything else
		return 0;
	}
	

	font = textOverlay->font;


	font->flags = 0;    //clear flags

	for( cy = 0; cy < textOverlay->height; cy++ )
	{

		textDataPtr = &textOverlay->textBuffer[ cy * textOverlay->width * 2 ];

		for( cx = 0; cx < textOverlay->width; cx++ )
		{
			attributes  = *textDataPtr++;
			letter		= *textDataPtr++;


			//cursor
			if( textOverlay->flags & GF_TEXT_OVERLAY_FLAG_SHOW_CURSOR )
			{
				if( ( cx == textOverlay->cursX ) && ( cy == textOverlay->cursY ) )
				{
					attributes = 0xf0;

					if( letter == 0 )
					{
						//always display, even if no text
						letter = 32;
					}
				}
			}

			if( letter  != 0 )
			{

				//letter color

				r = 0;
				g = 0;
				b = 0;

				if( attributes & 8 )
				{
					//bright
					if( attributes & 1 )
					{
						r = 0xff;
					}

					if( attributes & 2 )
					{
						g = 0xff;
					}

					if( attributes & 4 )
					{
						b = 0xff;
					}

				}
				else
				{
					//dark
					if( attributes & 1 )
					{
						r = 0x80;
					}

					if( attributes & 2 )
					{
						g = 0x80;
					}

					if( attributes & 4 )
					{
						b = 0x80;
					}

				}

				font->charColor = gfColor( r, g, b );


				//background color

				r = 0;
				g = 0;
				b = 0;

				attributes >>= 4;

				if( attributes & 8 )
				{
					//bright
					if( attributes & 1 )
					{
						r = 0xff;
					}

					if( attributes & 2 )
					{
						g = 0xff;
					}

					if( attributes & 4 )
					{
						b = 0xff;
					}

				}
				else
				{
					//dark
					if( attributes & 1 )
					{
						r = 0x80;
					}

					if( attributes & 2 )
					{
						g = 0x80;
					}

					if( attributes & 4 )
					{
						b = 0x80;
					}

				}



				if( ( attributes & 0x0f ) == 0x07 )
				{
					font->flags = GF_FONT_FLAG_ALPHA_BACKGROUND;
					r = 0;
					g = 0;
                    b = 0;
				}
				else
				{
					font->flags = 0;
				}


				font->backgroundColor = gfColor( r, g, b );

				gfPutChar( bmp, font, x + ( cx * font->width ), y + ( cy * font->height ), letter );
			}
		}
	}

	return 0;
}



ulong toSetCursorPos( tgfTextOverlay *overlay, ushort cursX, ushort cursY )
{
	if( !overlay )
	{
		return 1;
	}

	if( ( cursX < overlay->width ) && ( cursY < overlay->height ) )
	{

		overlay->cursX = cursX;
		overlay->cursY = cursY;

	}
	else
	{
		return 2;
	}

	return 0;
}

ulong toCls( tgfTextOverlay *overlay )
{
	ulong   i;

	if( !overlay )
	{
		return 1;
	}


	for( i = 0; i < ( overlay->width * overlay->height * 2 ); i += 2 )
	{
		overlay->textBuffer[i+1]		= overlay->textAttributes;
		overlay->textBuffer[i]			= 0;
	}

	overlay->cursX = 0;
	overlay->cursY = 0;

	return 0;
}


ulong toScrollUp( tgfTextOverlay *overlay )
{
	ulong   idx;
	ulong   idx2;
	ushort  x;
	ushort  y;

	//scroll up
	if( !overlay )
	{
		return 1;
	}

	
 
	for( y = 0; y < overlay->height ; y++ )
	{
		//dest
		idx 	= ( y * overlay->width * 2 );
		//src
		idx2	= ( ( y + 1 ) * overlay->width * 2 );

		if( y < overlay->height - 1 )
		{
			//scroll

			for( x = 0; x < overlay->width; x++ )
			{
				overlay->textBuffer[ idx++ ] = overlay->textBuffer[ idx2++ ];
				overlay->textBuffer[ idx++ ] = overlay->textBuffer[ idx2++ ];
			}

		}
		else
		{
			//clear last line
			for( x = 0; x < overlay->width; x++ )
			{
				overlay->textBuffer[ idx++ ] = 0;
				overlay->textBuffer[ idx++ ] = overlay->textAttributes;
			}
		}
	}
	
	

	return 0;

}

ulong toPrint( tgfTextOverlay *overlay, char *string )
{
	uchar	c;
	ulong   idx;

	if( !overlay )
	{
		return 1;
	}

	while( ( c = *string++ ) )
	{
		idx = ( overlay->cursX * 2 ) + ( overlay->cursY * overlay->width * 2 );


		if( ( c > 0 ) && ( c != 10 ) )
		{

			overlay->textBuffer[idx++] = c;
			overlay->textBuffer[idx++] = overlay->textAttributes;
			
			overlay->cursX++;

			if( overlay->cursX >= overlay->width )
			{
				overlay->cursX = 0;
				overlay->cursY++;
			}
		}
		else if( c == 10 )
		{
			overlay->cursX = 0;
			overlay->cursY++;
		}


		if( overlay->cursY >= overlay->height )
		{
			overlay->cursY = overlay->height - 1;

			toScrollUp( overlay );

		}
	}

	return 0;
}



ulong toPrintF( tgfTextOverlay *overlay, char *format, ... )
{
    va_list  arp;
    unsigned char       flag;
    ulong      radix;
    ulong      width;
    ulong      value;
    unsigned char       scratch[16];
    unsigned char      *pointer;

    unsigned char       c;
    unsigned char       d; 
    ulong      i; 
    ulong      j;

	char printBuf[2];
	
    printBuf[1] = 0;
	
    va_start( arp, format );

    for( ; ; ) 
    {
    
        c = *format++;

        if(c == 0) break;           /* End of string */

        if(c != '%') 
        {               
            
            /* Non escape character */
			printBuf[0] = c;
			toPrint( overlay, printBuf );

            continue;
        }
        
        
        width = 0;
        flag = 0;
        c = *format++;

        if( c == '0' ) 
        {               
            /* Flag: '0' padding */

            flag = 1; 
            c = *format++;

        }else
        {

            if( c == '-' ) 
            {           
                
                /* Flag: left justified */
                flag = 2; 
                c = *format++;
            }
        }
        
        while( _IS_DIGIT( c ) ) 
        {       
            
            /* Precision */
            width = width * 10 + c - '0';
            c = *format++;
        }
        
        if( (c == 'l') || (c == 'L') ) 
        {   
            /* Prefix: Size is long int */
            
            flag |= 4; 
            c = *format++;
        }
        
        if( !c ) break;
        
        d = c;
        
        if( _IS_LOWER( d ) ) d -= 0x20;
        
        switch( d ) 
        {               
            
            /* Type is... */
            
            case 'S' :                  
                
                /* String */
            
                pointer = va_arg( arp, unsigned char* );
            
                for(j = 0; pointer[j] ; j++);
            
                if( !( flag & 2 ) ) 
                {
                    while( j++ < width ) 
					{
						printBuf[0] = ' ';
						toPrint( overlay, printBuf );

					}
                }
                
                while( *pointer ) 
				{
					printBuf[0] = *pointer++;
					toPrint( overlay, printBuf );

                }
                while( j++ < width ) 
				{
					printBuf[0] = ' ';
					toPrint( overlay, printBuf );
				}
                continue;
            
            case 'C' :                  /* Character */

				printBuf[0] = ( char ) va_arg( arp, int );
				toPrint( overlay, printBuf );
                
                continue;
        
            case 'B' :                  /* Binary */
                
                radix = 2; 
                break;
            
            case 'O' :                  /* Octal */
                radix = 8; 
                break;
        
            case 'D' :                  /* Signed decimal */
            case 'U' :                  /* Unsigned decimal */
                
                radix = 10; 
                break;
        
            case 'X' :                  /* Hexdecimal */
                
                radix = 16; 
                break;
            
            default:                    /* Unknown type (pass-through) */

				printBuf[0] = c;
				toPrint( overlay, printBuf );

                continue;
        }

        /* Get an argument and put it in numeral */
        
        value = (flag & 4) ? (ulong) va_arg( arp, long ) : ( ( d == 'D' ) ? (ulong)(long) va_arg( arp, int ) : (ulong) va_arg( arp, unsigned int ) );
            
        if( d == 'D' && ( value & 0x80000000) ) 
        {
            value = 0 - value;
            flag |= 8;
        }
        
        i = 0;
        
        do 
        {
            d = (char)( value % radix ); 
            value /= radix;

            if ( d > 9 ) d += ( c == 'x' ) ? 0x27 : 0x07;

            scratch[i++] = d + '0';
        
        }while( value && i < sizeof scratch / sizeof scratch[0] );
        
        if( flag & 8 ) scratch[i++] = '-';
        
        j = i; 
        d = ( flag & 1 ) ? '0' : ' ';
        
        while( ! ( flag & 2 ) && j++ < width )
        {
			printBuf[0] = d;
			toPrint( overlay, printBuf );

        }
        
        do
        {
            
			printBuf[0] = scratch[--i];
			toPrint( overlay, printBuf );
            
        }while ( i );

        while( j++ < width ) 
        {
			printBuf[0] = d;
			toPrint( overlay, printBuf );
        }
    }

    va_end( arp );

	return 0;
}
