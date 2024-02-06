
TARGET = boot 

AS = riscv-none-embed-as -march=rv32im 
CC = riscv-none-embed-gcc -march=rv32im  -c 
LD = riscv-none-embed-ld -T ram.ld
OBJCOPY = riscv-none-embed-objcopy
OBJDUMP = riscv-none-embed-objdump 
LIBGCC = "c:\Program Files\riscv-none-gcc\lib\gcc\riscv-none-embed\8.2.0\rv32im\ilp32\libgcc.a"


all: $(TARGET).bin $(TARGET).rec $(TARGET).disasm $(TARGET).mi

$(TARGET).disasm: $(TARGET).elf
	$(OBJDUMP) --disassemble -S $(TARGET).elf>$(TARGET).disasm

$(TARGET).rec: $(TARGET).elf
	$(OBJCOPY) -O srec $(TARGET).elf $(TARGET).rec

$(TARGET).elf: main.o startup.o
	$(LD) startup.o main.o $(LIBGCC) -o $(TARGET).elf

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

$(TARGET).mif: $(TARGET).bin
	bin2mif32 $(TARGET).bin $(TARGET).mif

$(TARGET).mi: $(TARGET).bin
	bin2mi32 $(TARGET).bin $(TARGET).mi

main.o: main.cpp
	$(CC) -o main.o main.cpp 

startup.o: startup.s
	$(AS) -o startup.o startup.s

clean:
	rm -f *.o *.rec *.disasm *.elf *.bin *.mif *.mi


send: $(TARGET).rec
	srecsend $(TARGET).rec com3 500000