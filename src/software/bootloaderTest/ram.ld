MEMORY 
	{						         
/*system ram shadow for_test*/
/*ram 	: ORIGIN = 0x00f02000, LENGTH = 0x00005fff*/

/*dma ram*/
/*		 ram 	: ORIGIN = 0x00380000, LENGTH = 0x0007ffff*/

/*system ram*/
		 ram 	: ORIGIN = 0x00002000, LENGTH = 0x00005fff

		eram   		: ORIGIN = 0x00400000, LENGTH = 0 
		//fastram 	: ORIGIN = 0x00002000, LENGTH = 0x00005fff
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
