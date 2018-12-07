# a0 = endereco do incio da sprite, a1 = endereco de onde estao armazenados os valores da sprite, a2 = largura da sprite, a3 = altura da sprite
printSprite: #Cuidado, mexe na s0 e s1!!!
	addi sp  sp  -12
	sw ra, 0(sp)
	sw s0  4(sp)
	sw s1 8(sp)
	# Manda a Sprite para o display	
	mv t0  a0 # inicio e endere�o atual
	mv t1  a1 # local (memoria) que o bin esta armazenado
	mv t2  a2 
	mv t3  a3 
	li t4  0 # contador horizontal
	li t5  0 # contador vertical
	li s0  320 # largura do mapa
loopDesenhaHalf:beq t5  t3  fimloopDesenhaHalf
testeFimLinha:	beq t4  t2  fimDaLinhaSprite
	lb t6  0(t1) # carrega o valor da half que esta em a1
	sb t6  0(t0) # manda o valor que esta dentro dos dados para o display  posicao s0
	addi t0  t0  1 # proximos 2pixel do mapa
	addi t1  t1  1 # proximos 2 pixel do player
	addi t4  t4  1 # itera  horizontal
	j loopDesenhaHalf
fimDaLinhaSprite:
	sub s1  s0  t2 #subtrai largura da sprite de 320
	add t0  t0  s1 #pula uma linha (320 - largura)
	addi t5  t5  1 #itera o contador vertical
	li t4  0 #reseta o contador
	j loopDesenhaHalf
fimloopDesenhaHalf:
	lw ra 0(sp)
	lw s0 4(sp)
	lw s1 8(sp)
	addi sp  sp  12
	jalr x0 ra 0

