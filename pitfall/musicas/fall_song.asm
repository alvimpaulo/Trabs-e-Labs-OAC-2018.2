.macro fall_song( %a, %b, %c, %d, %e)
	
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

fall_song(61,500,16,60,10)
fall_song(59,500,16,60,10)
fall_song(57,500,16,60,10)
fall_song(55,500,16,60,10)
fall_song(53,500,16,60,10)


