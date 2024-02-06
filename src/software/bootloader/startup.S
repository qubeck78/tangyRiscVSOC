
	.equ		stackPointer, 		0x30080000

	.org 0x0

	j start

.balign 16

irq_vec:
#	picorv32_retirq_insn()


	.globl start
	.type start,@function

start:

#init stack pointer 

#	li sp, stackPointer
	
# initialize control and status registers
#	csrw mepc,        zero
#	csrw mcause,      zero
#	csrw mscratch,    zero
#	csrw mtval,       zero

	#push argc and argv to stack

	addi sp,sp,-16
	sw zero,0(sp)
	sw zero,4(sp)
	sw zero,8(sp)
	sw zero,12(sp) 


	# jump to main C code
	jal ra,main

1:
	j 1b

