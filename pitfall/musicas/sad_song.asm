.macro sad_song( %a, %b, %c, %d, %e)
	
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
sad_song(72, 1000, 1, 60, 0) # Dó
sad_song(93, 500, 1, 60, 500) #Lá 2 oitavas a mais
sad_song(64,750,1,60,0) #Mi
sad_song (95,750,1,60,500) #Si 2 oitavas a mais
sad_song (67,500,1,60,500)  #Sol
sad_song (91,750,1,60,500) #Sol 2 oitavas a mais
sad_song(62,750,1,60,500) #Ré
sad_song(66,500,1,60,0) # 3º tecla escura F#
sad_song(90,1000,1,60,500) # 3º teclada escura 2 oitavas a mais F#
sad_song(69,500,1,60,500) # Lá
sad_song(88,2750,1,60,500) # Mi 2 oitavas a mais
sad_song (64,2000,1,60,500) #Mi
sad_song (67,1500,1,60,500)  #Sol
sad_song(74,1000,1,60,500) #Ré 1 oitava a mais
sad_song (71,500,1,60,750) #Si
sad_song(72, 2000, 1, 60, 500) # Dó
sad_song (64,1500,1,60,0) #Mi
sad_song(93,1000,1,60,500) # Lá 2 oitavas a mais
sad_song (67,1000,1,60,500)  #Sol
sad_song (91,500,1,60,500) #Sol 2 oitavas a mais
sad_song(90,750,1,60,750) # 3º teclada escura 2 oitavas a mais F#
sad_song(62,1500,1,60,500) #Ré
sad_song(66,1000,1,60,500) # 3º tecla escura F#
sad_song(69,500,1,60,0) # Lá
sad_song (95,500,1,60,750) #Si 2 oitavas a mais
sad_song (67,1500,1,60,0)  #Sol
sad_song (95,1500,1,60,0) #Si 2 oitavas a mais
sad_song(86,1500,1,60,500) #Ré 2 oitavas a mais
sad_song (71,1000,1,60,500) #Si
sad_song(74,500,1,60,700) #Ré 1 oitava a mais
sad_song(62,1500,1,60,0) #Ré
sad_song(86,1500,1,60,0) #Ré 2 oitavas a mais
sad_song(93,1500,1,60,500) # Lá 2 oitavas a mais
sad_song(66,1000,1,60,500) # 3º tecla escura F#
sad_song(69,500,1,60,700) # Lá
sad_song(72, 1500, 1, 60, 0) # Dó
sad_song(93,500,1,60,500) # Lá 2 oitavas a mais
sad_song (64,1000,1,60,0) #Mi
sad_song (95,1000,1,60,500) #Si 2 oitavas a mais
sad_song (67,500,1,60,500)  #Sol
sad_song (91,1000,1,60,500)  #Sol 2 oitavas a mais
sad_song(62,1500,1,60,500) #Ré
sad_song(66,1000,1,60,0) # 3º tecla escura F#
sad_song(90,1000,1,60,500) # 3º teclada escura 2 oitavas a mais F#
sad_song(69,500,1,60,500) # Lá
sad_song(88,2000,1,60,1000) # Mi 2 oitavas a mais
sad_song (64,2000,1,60,500) #Mi
sad_song (67,1500,1,60,500)  #Sol
sad_song(74,1000,1,60,500) #Ré 1 oitava a mais
sad_song (71,500,1,60,700) #Si
sad_song(72, 1500, 1, 60, 0) # Dó
sad_song (91,500,1,60,500)  #Sol 2 oitavas a mais
sad_song (64,1000,1,60,0) #Mi
sad_song(93,500,1,60,500) # Lá 2 oitavas a mais
sad_song (67,500,1,60,0)  #Sol
sad_song (91,500,1,60,500)  #Sol 2 oitavas a mais
sad_song(90,500,1,60,500) # 3º teclada escura 2 oitavas a mais F#
sad_song(50,1500,1,60,500) #Ré 1 oitava a menos
sad_song(54,1000,1,60,500) # 3º tecla escura 1 oitava a menos F#
sad_song(57,500,1,60,700) # Lá 1 oitava a menos

sad_song(60, 2500, 1, 60, 0) # Dó 1 oitava a menos
sad_song(76,2000,1,60,0) # Mi uma oitava a mais
sad_song(88,2000,1,60,500) # Mi 2 oitavas a mais
sad_song (55,500,1,60,500)  #Sol 1 oitava a menos
sad_song(72, 1500, 1, 60, 500) # Dó
sad_song (55,1000,1,60,1300)  #Sol 1 oitava a menos
sad_song(78,500,1,60,0) # 3º tecla escura uma oitava a mais F#
sad_song(52, 3250, 1, 60, 500) # Mi 1 oitava a menos
sad_song(76,750,1,60,250) # Mi 1 oitava a mais
sad_song (71,1500,1,60,0) #Si
sad_song (55,2000,1,60,500)  #Sol 1 oitava a menos
sad_song (59,1500,1,60,500) # Si 1 oitava a menos
sad_song(64,1000,1,60,500) # Mi 
sad_song(76,1000,1,60,1000) # Mi 1 oitava a mais
sad_song (79,500,1,60,500)  #Sol 1 oitava a menos
sad_song(60, 2000, 1, 60, 0) # Dó 1 oitava a menos
sad_song (81,2000,1,60,500) # Lá 1 oitava a mais
sad_song (55,500,1,60,500)  #Sol 1 oitava a menos
sad_song(72, 1000, 1, 60, 500) # Dó
sad_song (55,500,1,60,700)  #Sol 1 oitava a menos
sad_song(50,3000,1,60,0) #Ré 1 oitava a menos
sad_song (79,1500,1,60,500)  #Sol 1 oitava a mais
sad_song (57,2500,1,60,500) # Lá 1 oitava a menos
sad_song(62,2000,1,60,500) #Ré
sad_song(78,500,1,60,500) # 3º tecla escura uma oitava a mais F#
sad_song (79,500,1,60,500)  #Sol 1 oitava a mais
sad_song (81,500,1,60,500) # Lá 1 oitava a mais
sad_song(74,500,1,60,500) #Ré 1 oitava a mais
sad_song (79,1500,1,60,0)  #Sol 1 oitava a menos
sad_song (83,1500,1,60,500) # Si 1 oitava a mais
sad_song(62,1000,1,60,500) #Ré
sad_song (67,500,1,60,500)  #Sol
sad_song(50,1500,1,60,0) #Ré 1 oitava a menos
sad_song (81,1000,1,60,500) # Lá 1 oitava a mais
sad_song (57,1000,1,60,500) # Lá 1 oitava a menos
sad_song(62,500,1,60,500) #Ré







