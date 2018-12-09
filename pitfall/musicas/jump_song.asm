.macro jump_song( %a, %b, %c, %d, %e)
	
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

jump_song(61,500,115,60,10)
jump_song(63,500,115,60,10)
jump_song(65,500,115,60,10)
jump_song(67,500,115,60,10)
jump_song(69,500,115,60,10)
