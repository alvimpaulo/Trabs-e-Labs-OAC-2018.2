.data
	MUSICA: .word 61, 800, 67, 1000, 65, 500, 64, 500, 62, 500, 72, 800,   67, 1200, 65, 500, 64, 500, 62, 500, 72, 800,   67, 1200, 65, 500, 64, 500, 65, 500, 62, 1500
.text		     #c        g         f        e        d        C          g         f        e        d        C	       g         f        e        f	    d
	li t5, 0
	li t4, 16	#numero de notas
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