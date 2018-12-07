.include "macros2.s"
.eqv STOPWATCH 0xFF200510

.data
RELOGIO: .word 1200

.text
	M_SetEcall(exceptionHandling)
	
	jal CLSV
	jal RELOGIO_INICIO
	
	li a7, 10
	M_Ecall
	
RELOGIO_INICIO: li s0, 10
	la t0, RELOGIO
	lw s0, 0(t0)
	li s1, 60
				
RELOGIO_LOOP: nop
	li a0, 1000	# ms
	li a7, 132
	M_Ecall
	addi s0,s0,-1
	addi s1,s1,-1
	mv a0,s0
	li a7,101
	li a1,120
	li a2,120
	li a3,0x00FF
	M_Ecall
	
	li a7,111
	li a0,':'
	li a1,152
	li a2,120
	li a3,0x00FF
	M_Ecall
	
	mv a0,s1
	li a7,101
	li a1,160
	li a2,120
	li a3,0x00FF
	M_Ecall
	
	li t0, STOPWATCH
	lw t1, 0(t0)
	li a7,101
	mv a0,t1
	li a1, 120
	li a2, 128
	li a3, 0X00FF
	M_Ecall
	
	bne s0,x0,RELOGIO_LOOP
	ret
		
# CLS Clear Screen Randomico
CLSV:	li a7,141
	# M_Ecall
	li a0,0x00
	li a7,148
	M_Ecall
	ret
.include "SYSTEMv12.s"
	
	
	