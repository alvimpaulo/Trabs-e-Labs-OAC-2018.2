
.data
	DADO: .word 0x0A
	FLOAT: .float 16.0
.text
	li t0,0
	la s0,DADO
	lw t1,0(s0)
LOOP:	beq t0,t1,FIM
	addi t0,t0,1
	j LOOP
FIM:	li t0,0x958c96d5
	li t1,0x7
	remu t2,t0,t1
	div t0,t0,t1
	flw ft5,4(s0)
	fsqrt.s ft5,ft5
fim:	j fim
