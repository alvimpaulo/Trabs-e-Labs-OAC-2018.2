.macro menu_song( %a, %b, %c, %d, %e)
	
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
.data
menuSong: .word

.text
li s0,0

FIM: menu_song(55,400,1,60,200) #Sol 1 oitava a menos
menu_song(55,400,1,60,200) #Sol 1 oitava a menos
menu_song(55,400,1,60,200) #Sol 1 oitava a menos
menu_song(72,1200,1,60,1000) # Dó
menu_song(64,1200,1,60,0) #Mi
menu_song (67,1200,1,60,1000)  #Sol

menu_song (65,400,1,60,200)  #Fá
menu_song(64,400,1,60,200) #Mi
menu_song(62,400,1,60,200) #Ré
menu_song (65,1200,1,60,0)  #Fá
menu_song(84,1200,1,60,1000) # Dó 1 oitava a mais
menu_song(64,800,1,60,0) #Mi
menu_song (67,800,1,60,600)  #Sol
menu_song (65,400,1,60,200)  #Fá
menu_song(64,400,1,60,200) #Mi
menu_song(62,400,1,60,200) #Ré
menu_song (65,1200,1,60,0)  #Fá
menu_song(84,1200,1,60,1000) # Dó 1 oitava a mais
menu_song(64,800,1,60,0) #Mi
menu_song (67,800,1,60,600)  #Sol
menu_song(62,400,1,60,0) #Ré
menu_song (65,400,1,60,200)  #Fá
menu_song(64,400,1,60,200) #Mi
menu_song (65,400,1,60,200)  #Fá
menu_song (59,1200,1,60,0) #Si 1 oitava a menos
menu_song(62,1200,1,60,1000) #Ré
beq s0,zero,FIM





