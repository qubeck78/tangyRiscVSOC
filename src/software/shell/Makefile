#
# Makefile for WhiteDragon user program
#

TARGET = shell
AS = riscv-none-embed-as -march=rv32im 
CC = riscv-none-embed-gcc -march=rv32im -c -O3 
LD = riscv-none-embed-ld -T ram.ld
OBJCOPY = riscv-none-embed-objcopy
OBJDUMP = riscv-none-embed-objdump 
LIBGCC =   "c:\Program Files\riscv-none-gcc\lib\gcc\riscv-none-embed\8.2.0\rv32im\ilp32\libgcc.a"
LIBSTDCC = "c:\Program Files\riscv-none-gcc\riscv-none-embed\lib\rv32im\ilp32\libstdc++.a"
LIBC     = "c:\Program Files\riscv-none-gcc\riscv-none-embed\lib\rv32im\ilp32\libc.a"
LIBM     = "c:\Program Files\riscv-none-gcc\riscv-none-embed\lib\rv32im\ilp32\libm.a" 
LIBNOSYS = "c:\Program Files\riscv-none-gcc\riscv-none-embed\lib\rv32im\ilp32\libnosys.a"

all: $(TARGET).bin $(TARGET).rec $(TARGET).disasm 

$(TARGET).disasm: $(TARGET).elf
	$(OBJDUMP) --disassemble -S $(TARGET).elf>$(TARGET).disasm

$(TARGET).rec: $(TARGET).elf
	$(OBJCOPY) -O srec $(TARGET).elf $(TARGET).rec

$(TARGET).elf: main.o objViewer.o shellUI.o bsp.o startup.o osAlloc.o osFile.o gfBitmap.o gfDrawing.o gfFont.o gfGouraud.o gfJPEG.o picojpeg.o diskio.o ccsbcs.o ff.o osUIEvents.o usbHID.o 
	$(LD) startup.o main.o objViewer.o shellUI.o ../gfxLib/bsp.o ../gfxLib/diskio.o ../gfxLib/ccsbcs.o ../gfxLib/ff.o ../gfxLib/osAlloc.o ../gfxLib/osFile.o ../gfxLib/gfBitmap.o ../gfxLib/gfDrawing.o ../gfxLib/gfFont.o ../gfxLib/gfGouraud.o ../gfxLib/gfJPEG.o ../gfxLib/picojpeg.o ../gfxLib/osUIEvents.o ../gfxLib/usbHID.o $(LIBC) $(LIBNOSYS) $(LIBM) $(LIBGCC)  -o $(TARGET).elf

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

$(TARGET)_L.mif: $(TARGET).bin
	bin2mif16 $(TARGET).bin $(TARGET)

objViewer.o: objViewer.cpp
	$(CC) -o objViewer.o objViewer.cpp 

shellUI.o: shellUI.cpp	
	$(CC) -o shellUI.o shellUI.cpp 

main.o: main.cpp
	$(CC) -o main.o main.cpp 

bsp.o: ../gfxLib/bsp.cpp
	$(CC) -o ../gfxLib/bsp.o ../gfxLib/bsp.cpp 

startup.o: startup.s
	$(AS) -o startup.o startup.s

gfBitmap.o: ../gfxLib/gfBitmap.cpp
	$(CC) -o ../gfxLib/gfBitmap.o ../gfxLib/gfBitmap.cpp 
	
gfDrawing.o: ../gfxLib/gfDrawing.cpp
	$(CC) -o ../gfxLib/gfDrawing.o ../gfxLib/gfDrawing.cpp 

gfGouraud.o: ../gfxLib/gfGouraud.cpp
	$(CC) -o ../gfxLib/gfGouraud.o ../gfxLib/gfGouraud.cpp 

gfFont.o: ../gfxLib/gfFont.cpp
	$(CC) -o ../gfxLib/gfFont.o ../gfxLib/gfFont.cpp 
	
gfJPEG.o: ../gfxLib/gfJPEG.cpp
	$(CC) -o ../gfxLib/gfJPEG.o ../gfxLib/gfJPEG.cpp 

picojpeg.o: ../gfxLib/picojpeg.cpp
	$(CC) -o ../gfxLib/picojpeg.o ../gfxLib/picojpeg.cpp 

osAlloc.o: ../gfxLib/osAlloc.cpp
	$(CC) -o ../gfxLib/osAlloc.o ../gfxLib/osAlloc.cpp 

osFile.o: ../gfxLib/osFile.cpp
	$(CC) -o ../gfxLib/osFile.o ../gfxLib/osFile.cpp 

diskio.o: ../gfxLib/diskio.cpp
	$(CC) -o ../gfxLib/diskio.o ../gfxLib/diskio.cpp 

ff.o: ../gfxLib/ff.cpp
	$(CC) -o ../gfxLib/ff.o ../gfxLib/ff.cpp  

ccsbcs.o: ../gfxLib/ccsbcs.cpp 
	$(CC) -o ../gfxLib/ccsbcs.o ../gfxLib/ccsbcs.cpp  

osUIEvents.o: ../gfxLib/osUIEvents.cpp
	$(CC) -o ../gfxLib/osUIEvents.o ../gfxLib/osUIEvents.cpp  

usbHID.o: ../gfxLib/usbHID.cpp
	$(CC) -o ../gfxLib/usbHID.o ../gfxLib/usbHID.cpp

clean:
	rm -f *.o *.rec *.disasm *.elf *.mif *.mi *.bin *.map
	rm -f ../gfxLib/*.o

send: $(TARGET).rec
	srecsend $(TARGET).rec com3 230400
	