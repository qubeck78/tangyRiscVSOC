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

No external components needed, unless You want to connect an USB keyboard. Works on plain Tang Nano 20K board.

Most examples require additional files placed on a SD card. Format SD card ( FAT32 ) and copy the 'SD' directory 
of each example to the SD card root dir.


For USB HID host functionality:

Connect:
FPGA pin 27 to USB D+
FPGA pin 28 to USB D-
Board GND to USB GND
Board 5V to USB 5V

USB D+ and USB D- lines have to be pulled down to GND via 15K Resistors to ensure proper impedance matching.

For details, check nand2mario description ( https://github.com/nand2mario/usb_hid_host ), 

and Gowin USB softPHY IP doc ( https://www.gowinsemi.com/upload/database_doc/1328/document/6073e6c99b401.pdf )



