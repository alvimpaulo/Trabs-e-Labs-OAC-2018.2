.macro dead_song( %a, %b, %c, %d, %e)
	
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
dead_song(69,500,1,60,500) # L�
dead_song(69,500,1,60,500) # L�
dead_song(69,250,1,60,250) # L�
dead_song(69,500,1,60,500) # L�
dead_song(72, 500, 1, 60, 500) # D�
dead_song (71,250,1,60,250) #Si
dead_song (71,250,1,60,250) #Si
dead_song(69,250,1,60,250) # L�
dead_song(69,500,1,60,500) # L�
dead_song(68,250,1,60,250) # L�
dead_song(69,500,1,60,500) # L�




