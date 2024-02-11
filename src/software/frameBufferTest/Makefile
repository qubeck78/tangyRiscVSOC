
AS = riscv-none-embed-as -march=rv32im 
CC = riscv-none-embed-gcc -march=rv32im -O2 -c 
LD = riscv-none-embed-ld -T ram.ld
OBJCOPY = riscv-none-embed-objcopy
OBJDUMP = riscv-none-embed-objdump 
LIBGCC = "c:\Program Files\riscv-none-gcc\lib\gcc\riscv-none-embed\8.2.0\rv32im\ilp32\libgcc.a"


all: prog.bin prog.rec prog.disasm prog.mif

prog.disasm: prog.elf
	$(OBJDUMP) --disassemble -S prog.elf>prog.disasm

prog.rec: prog.elf
	$(OBJCOPY) -O srec prog.elf prog.rec

prog.elf: main.o startup.o
	$(LD) startup.o main.o $(LIBGCC) -o prog.elf

prog.bin: prog.elf
	$(OBJCOPY) -O binary prog.elf prog.bin

prog.mif: prog.bin
	bin2mif32 prog.bin prog.mif

main.o: main.cpp
	$(CC) -o main.o main.cpp 

startup.o: startup.s
	$(AS) -o startup.o startup.s

clean:
	rm -f *.o *.rec *.disasm *.elf *.mif *.bin

send: prog.rec
	srecsend prog.rec com3 230400