.data
	MUSICA: .word 61, 500, 62, 500, 64, 500, 73, 1050,     62, 500, 64, 500, 65, 800,       62, 500, 64, 500, 65, 500,        74, 1050,	61, 500, 62, 500, 64, 500, 65, 500, 67, 850,       61, 500, 62, 500, 64, 500, 72, 850,	     62, 500, 64, 500, 65, 1000,      76, 500, 74, 500, 74, 800, 76, 500, 74, 500, 74, 800, 76, 500, 74, 500, 76, 500, 77, 500, 61, 1500
.text		     #c        d        e        C             d        e        f              d        e        f               D             c        d        e        f        g              c        d        e        C		     d        e        f       	      e        d        d        e        d        d        e        d        e        f        c
	li t5, 0
	li t4, 35		#numero de notas
	la t6, MUSICA

TOCA:	slli t3, t5, 3
	add t3, t6, t3 
	lw a0, 0(t3)
	lw a1, 4(t3)
	li a2, 1
	li a3, 127
	li a7, 33
	M_Ecall
	
	addi t5, t5, 1		#contador de notas
	blt t5, t4, TOCA
	
	
	li a7, 10
	M_Ecall