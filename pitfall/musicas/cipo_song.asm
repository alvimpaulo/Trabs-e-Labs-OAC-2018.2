.macro cipo_song( %a, %b, %c, %d, %e)
	
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
cipo_song(61,500,104,60,500)
cipo_song(65,250,104,60,250)
cipo_song(61,1000,104,60,1000)
cipo_song(65,350,104,60,350)
cipo_song(61,350,104,60,350)
cipo_song(65,350,104,60,350)


