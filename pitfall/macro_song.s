.macro macro_song( %a, %b, %c, %d, %e)
	
li a0,%a   
li a1,%b   
li a2,%c
li a3,%d
li a7,31
M_Ecall
li a7, 32
li a0,%e
M_Ecall
.end_macro
