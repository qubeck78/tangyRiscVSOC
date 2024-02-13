# tangySOC
RiscV SOC based on PicoRV core for Tang Nano 20K

Contains:
- PicoRV RiscV core ( https://github.com/YosysHQ/picorv32 )
- VGA framebuffer ( 565 color gfx modes + text overlay ), DVI video output
- 2D blitter with alpha channel and bitmap scaling 
- 3D gouraud hw accelerator with texture and light support ( not implemented yet )
- Memory mapped floating point ALU ( not implemented yet )
- Serial interface for program upload
- SPI interface - sd card support 
- USB HID host controller ( https://github.com/nand2mario/usb_hid_host ) 
- GW2AR internal SDRAM controller with dma


Contact info: qubeck78@wp.pl
