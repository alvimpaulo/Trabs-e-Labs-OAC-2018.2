.data
estadoPersonagem:
vidas: .space 4
pontuacao:  .space 4
cimaOuBaixo: .space 4
esqOuDir:  .space 4
cipo: .space 4
perdeVidas: .space 4
atualizaTela: .space 4
posicaoPersonagemX: .space 4
posicaoPersonagemY: .space 4
vectorAditionalParaPulo: .half -2, -1, -1, -1, 0, 0, 0, 1, 1, 1, 2 
numElementosNoVetor: .half 11
direcaoDoMovimento: .word 0
estadoDoPulo: .word 0
.text



#s1 = endereco do vetor do pulo
# a0 = tecla precionada
MovePersonagem:
	la s1 vectorAditionalParaPulo
	li t0 ' '
	lw t1 32(s1)
	addi sp, sp, -4
	sw ra 0(sp)
	jal ra incioPuloVertical
	jal ra incioPuloDireita

	li t0 ' '
	if_tecla_de_pular_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_de_pular_foi_apertada_MovePersonagem
		
		addi t1 t1 1
		li t0 11
		rem t1 t1 t0
		sw t1 48(s1)
		
		beq t1 x0 FimMovePersonagem
		bnez s0, else_estado_zero 
		if_estado_zero:
			li s0 1
		else_estado_zero:
		li t0 'd'
		beq s4 t0 espaco_precedido_de_d
			jal ra incioPuloVertical
			j finalPulo
		espaco_precedido_de_d:
			li s0 15
			jal ra incioPuloDireita
			j finalPulo

		finalPulo:
		lw ra 0(sp)
		addi sp, sp, 4
		jalr x0 ra 0
	else_tecla_de_pular_foi_apertada_MovePersonagem: nop
		li t0 'a'
		if_tecla_de_a_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_de_a_foi_apertada_MovePersonagem
			# apaga sprite
			la a0 Personagem_Parado_16_24_1_Frame
			jal ra ApagaPersonagem
			# Altera a posição do personagem pra esquerda
			lw t0 -8(s1)
			addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
			sw t0 -8(s1)
			
			#rotina de final
			lw ra 0(sp)
			addi sp, sp, 4
			jalr x0 ra 0
		else_tecla_de_a_foi_apertada_MovePersonagem: nop
			li t0 'd'	 
			if_tecla_de_d_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_de_d_foi_apertada_MovePersonagem
				
				li t0 9
				ble s0, t0, if_esta_correndo_direita 
				li t0 15
				bge s0, t0, if_esta_correndo_direita 
				j else_esta_correndo_direita
				if_esta_correndo_direita:
					li s0 10
				else_esta_correndo_direita:
				jal ra andarDireita

			else_tecla_de_d_foi_apertada_MovePersonagem: nop
	
FimMovePersonagem: 
		lw ra 0(sp)
		addi sp, sp, 4
		jalr x0 ra 0

DesenhaPersonagem:
	# salva stack
	addi sp sp -4 
	sw ra 0(sp)
	
	la t0 posicaoPersonagemX 
	lw a0 0(t0)	#carrega em a0 o ponto x superior esquerdo do personagem
	addi a2 a0 LARGURA_PERSONAGEM #carrega em a0 o ponto x inferior direito do personagem
	lw a1 4(t0) #carrega em a0 o ponto y superior esquerdo do personagem
	addi a3 a1 ALTURA_PERSONAGEM #carrega em a0 o ponto y inferior direito do personagem
	
	#desenha o quadrado atual
	li a4 0xAA
	jal ra DrawQuadrado

	# carrega stack
	lw ra 0(sp)
	addi sp sp 4
FimDesenhaPersonagem: jalr x0 ra 0

# a0 = endereco memoria da sprite
DesenhaSpritePersonagem:
	# salva stack
	addi sp sp -4 
	sw ra 0(sp)
	mv t1 a0

	lw a2, 0(t1) # a2 = largura da sprite
	lw a3 4(t1) # a3 = altura da sprite

	lw a0 posicaoPersonagemY
	li t0 320
	mul a0 a0 t0 # a0 = y*320
	lw t0 posicaoPersonagemX
	add a0 t0 a0 # a0 = y*320 + x
	li t0 0xff000000
	add a0 a0 t0 # a0 = posicao da memoria que a sprite comeca
	mv a1 t1 
	addi a1 a1 8 # a1 = dados do sprite
	jal ra printSprite

	# carrega stack
	lw ra 0(sp)
	addi sp sp 4
	jalr x0 ra 0

# a0 = endereco memoria da sprite
ApagaPersonagem:

	addi sp sp -28 
	sw ra 0(sp)
	sw s0 4(sp)
	sw s1 8(sp)
	sw s2 12(sp)
	sw s3 16(sp)
	sw s4 20(sp)
	sw s5 24(sp)
	
	lw s0, 0(a0) # s0 = largura da sprite
	lw s1 4(a0) # s1 = altura da sprite
	lw s2 posicaoPersonagemY # s2 = posicao y
	lw s3 posicaoPersonagemX # s3 = posicao x
	li s4 0 # inicia contador de linhas da sprite
	mv s5 a0 # s5 tem o endereco do sprite
LoopApagaSprite: 	
	addi t0 s4 1 # t0 = contador + 1 
	beq s4 s1 fimLoopApagaSprite  # se (contador + 1) == altura 
		addi a3 zero 1 # altura = 1
		lw a1 16(sp) # a1 tem o mapa atual
		li t0 320
		add t1 s2 s4 # t1 = y + linha atual
		mul t0 t1 t0 # t5 = (y + linha atual) * 320
		add a0 t0 s3 # a0 = (y + linha atual)*320 + x
		mv t1 a0 # t1 = (y + linha atual)*320 + x
		li t0 0xff000000
		add a0 a0 t0 # a0 = posicao da memoria que a sprite comeca
		add a1 a1 t1 # local atual do mapa + memoria do mapa
		jal ra printSprite
		addi s4 s4 1
		j LoopApagaSprite
fimLoopApagaSprite:
	# carrega stack
	lw ra 0(sp)
	lw s0 4(sp)
	lw s1 8(sp)
	lw s2 12(sp)
	lw s3 16(sp)
	lw s4 20(sp)
	lw s5 24(sp)
	addi sp sp 28
	jalr x0 ra 0