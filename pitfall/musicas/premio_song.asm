.macro premio_song( %a, %b, %c, %d, %e)
	
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
premio_song(72, 500, 1, 60, 250) # D� 
premio_song(72, 500, 1, 60, 250) # D� 
premio_song(76,500,1,60,250) #Mi 1 oitava a mais
premio_song (79,500,1,60,250)  #Sol 1 oitava a mais
premio_song(76,500,1,60,250) #Mi 1 oitava a mais




