MEMORY 
	{						         

/* dma ram - last 512KB of 8MB */
		 ram 	: ORIGIN = 0x20780000, LENGTH = 0x0007ffff
		 eram   : ORIGIN = 0x20800000, LENGTH = 0

	}

SECTIONS
{

        .text :
	{
	    __text_start = . ;

	    *(.text)

	_etext = . ;
	__data_rom_start = ALIGN ( 4 ) ;
        } > ram

        .data :
	{
	_sdata = . ;
	__data_start = . ;

        *(.data)

	_edata = . ;
	edata = ALIGN( 0x10 ) ;
        } > ram

	.eram :
	{
	__ramend = . ;
	__bss_end__ = .;
    	_end = __bss_end__;
    	end = _end; 
	} > eram
}
