.text
## a0 = x_0; a1 = y_0; a2 = x_1; a3 = y_1; a4 = cor;
DrawQuadrado: nop
	li t0 INIT_MEMORIA_VIDEO	# carrega a memória inicial de video
	li t1 320					# carrega a largura da tela
	sub t2 a2 a0				# calcula a largura do personagem
	sub t3 t1 t2				# calcula qtd a ser adicionada para ir para proxima linha
	li t4 0 					# contador j = 0				
	
	# o endereço inicial/ contador i
	mul t5 a1 t1 #ini t5 = y * 320 
	add t5 t5 a0 #ini t5 += x
	add t5 t5 t0 #ini t5 += 0xff000000
	
	# o endereço final
	mul t6 a3 t1 #fim
	add t6 t6 a2 #fim
	add t6 t6 t0 #fim
	loop_cria_quadrado_linha_DrawQuadrado: nop
		sb a4 0(t5)								# salva a cor do do quadrado a ser desenhado
		if_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado: blt t4 t2 else_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado # if es
			li t4 0
			add t5 t5 t3
			bne t5 t6 loop_cria_quadrado_linha_DrawQuadrado
		else_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado: nop
		addi t5 t5 1 
		addi t4 t4 1 
		bne t5 t6 loop_cria_quadrado_linha_DrawQuadrado
	end_loop_cria_quadrado_linha_DrawQuadrado:
	sb a4 0(t5)
FimDrawQuadrado: jalr x0 ra 0

## Retorna true se (x, y) est� dentro do quadrado ((x_0, y_0), (x_1, y_1)) e false caso contr�rio
## a0 = x_0; a1 = y_0; a2 = x_1; a3 = y_1; a4 = x; a5 y
ColisaoObj: nop
	#t0 = a0 < a4
	slt t0 a0 a4
	#t1 = a2 > a4
	slt t1 a4 a2
	#t0 &= t1
	and t0 t0 t1
	#t1 = a1 > a5
	slt t1 a5 a1
	#t0 &= t1
	and t0 t0 t1
	#t1 = a3 < a5
	slt t1 a3 a5
	#t0 &= t1
	and a0 t0 t1
FimColisaoObj: jalr x0 ra 0

LeTeclaDoTeclado:	nop
	li a0 0
	li t1 INIT_MEMORIA_TECLADO # carrega valor da memória inicial do tecla
	lw a1 ADD_MEMORIA_TECLADO_ESTA_ATIVO(t1) # carrega a word onde tem o bit que diz que uma teca foi apertada
	andi a1 a1 MASK_MEMORIA_TECLADO # deixa somente o bit que diz que uma teca foi apertada
  if_tem_tecla_apertada_LeTeclaDoTeclado: beq a1 x0 FimLeTeclaDoTeclado # if nenhuma tecla foi apertada ele cai fora
  	lw a0, ADD_MEMORIA_TECLADO_LE(t1) # carrega o valor da tecla apertada em a0
  	sw a0, ADD_MEMORIA_TECLADO_MOSTRA(t1) # mostra no display a tecla pressionada
	else_tem_tecla_apertada_LeTeclaDoTeclado:
FimLeTeclaDoTeclado: jalr x0 ra 0

printSpriteWord: #Cuidado, mexe na s0 e s1!!!
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
loopDesenhaWord:beq t5  t3  fimloopDesenhaWord
testeFimLinhaWord:	beq t4  t2  fimDaLinhaSpriteWord
	lw t6  0(t1) # carrega o valor da half que esta em a1
	sw t6  0(t0) # manda o valor que esta dentro dos dados para o display  posicao s0
	addi t0  t0  4 # proximos 2pixel do mapa
	addi t1  t1  4 # proximos 2 pixel do player
	addi t4  t4  4 # itera  horizontal
	j loopDesenhaWord
fimDaLinhaSpriteWord:
	sub s1  s0  t2 #subtrai largura da sprite de 320
	add t0  t0  s1 #pula uma linha (320 - largura)
	addi t5  t5  1 #itera o contador vertical
	li t4  0 #reseta o contador
	j loopDesenhaWord
fimloopDesenhaWord:
	lw ra 0(sp)
	lw s0 4(sp)
	lw s1 8(sp)
	addi sp  sp  12
	jalr x0 ra 0
