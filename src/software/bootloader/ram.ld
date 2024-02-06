MEMORY 
	{

/*	bootloader ram*/
	ram    : ORIGIN = 0x00000000, LENGTH = 0x00001fff
	eram   : ORIGIN = 0x00200000, LENGTH = 0

/*	sdram - test mode*/
/*	ram    : ORIGIN = 0x40000000, LENGTH = 0x00001fff
	eram   : ORIGIN = 0x40200000, LENGTH = 0
*/
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
	} > eram
}
