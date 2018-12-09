.macro BotaoMenu_song( %a, %b, %c, %d, %e)
	
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
BotaoMenu_song(61,350,118,60,0)


