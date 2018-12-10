.macro dano_song( %a, %b, %c, %d, %e)
	
li a0,%a   
li a1,%b   
li a2,%c
li a3,%d
li a7,31
M_Ecall
li a7, 32
li a0 %e
M_Ecall
.end_macro

.text
dano_song(20,4000,124,60,0) 
# O 4000 � a dura��o da nota em nanosegundos, se necess�rio, pode diminuir











