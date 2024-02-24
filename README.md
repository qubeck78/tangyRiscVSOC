# tangySOC
RiscV SOC based on PicoRV core for Tang Nano 20K

Contains:
- PicoRV RiscV core ( https://github.com/YosysHQ/picorv32 )
- VGA framebuffer ( 565 color gfx modes + text overlay ), DVI video output
- 2D blitter with alpha channel and bitmap scaling 
- 3D gouraud hw accelerator with texture and light support
- I2S audio controller with fifo and DMA
- Memory mapped floating point ALU (option )
- Serial interface for program upload
- SPI interface - SD card support 
- USB HID host controller ( https://github.com/nand2mario/usb_hid_host ) 
- GW2AR internal SDRAM controller with dma
- Software examples located in src/software directory


No external components needed, unless You want to connect an USB keyboard or external uart ( faster ). Works on plain Tang Nano 20K board.

Most examples require additional files placed on a SD card. Format SD card ( FAT32 ) and copy the 'SD' directory 
of each example to the SD card root dir.

Core relies on Tang Nano external PLL to generate two necesary clocks:

--Ext pll clock 25MHz
extPllClock25:      in      std_logic;   -- pin 10, aux pll output 0
	
--Ext pll clock 12MHz
extPllClock12:      in      std_logic;   -- pin 11, aux pll output 1

Please read Tang Nano 20K wiki article describing how to configure external PLL.

https://wiki.sipeed.com/hardware/en/tang/tang-nano-20k/example/unbox.html#pll_clk


Running software:

When You start the core, bootloader takes control. It displays a welcome message and waits for code to be uploaded via UART.
In order to do so, just execute 'make send' in software example directory.

Note, that the makefile needs to be updated with a valid com port number.

For uploading software, You can use Tang Nano 20K internal USB->UART converter embedded in programmer microcontroler, but I find it
very slow. To speed up upload You will need to connect an external USB->UART converter to the following pins:

FPGA pin 41 ( extUartTX ) to RXD pin of the converter

FPGA pin 42 ( extUartRX ) to TXD pin of the converter

Board GND to converter GND


Please also check the generic definition at the top of "tangyRiscVSOCTop.vhd" file.

useTangUART:  boolean := true;  - means that Tang Nano 20K internal uart will be used

useTangUART:  boolean := false; - selects external uart for program upload ( needs converter )



For USB HID host functionality:

Connect:

FPGA pin 27 to USB D+

FPGA pin 28 to USB D-

Board GND to USB GND

Board 5V to USB 5V


USB D+ and USB D- lines have to be pulled down to GND via 15K Resistors to ensure proper impedance matching.

For details, check nand2mario description ( https://github.com/nand2mario/usb_hid_host ), 

and Gowin USB softPHY IP doc ( https://www.gowinsemi.com/upload/database_doc/1328/document/6073e6c99b401.pdf )



