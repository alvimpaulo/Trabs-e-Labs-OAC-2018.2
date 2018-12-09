.macro dano_song( %a, %b, %c, %d, %e)
	
li a0,%a   
li a1,%b   
li a2,%c
li a3,%d
li a7,31
ecall
li a7, 32
li a0 %e
ecall
.end_macro

.text
dano_song(20,4000,124,60,0) 
# O 4000 é a duração da nota em nanosegundos, se necessário, pode diminuir











