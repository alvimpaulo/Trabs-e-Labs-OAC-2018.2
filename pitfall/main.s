# | --- Tabela de registradores salvos --- 					|
# | s0 -> Estado atual do personagem						|	
# | s1 -> Vetor de movimentacao para o pulo do personagem 	|
# | s2 -> Mapa atual										|
# | s3 - > Endereco da memoria onde esta o mapa atual 		|
# | s4 -> ultimo input										|
# | s5 -> tempo que o loop começou							|
# | s6 -> ultimo estado										|
# | s7 -> vazio												|
# | s8 -> vazio												|
# | s9 -> vazio												|
# | s10-> vazio												|
# | s11-> relogio do jogo

# | 					Tabela dos Estados					|
# | 0 - > Parado 											|
# | 1 - 9 -> Pulo vertical									|
# | 10 - 14 -> movimentacao para a direita					|
# | 15 - 24 -> movimentacao para a direita					|

.data
	estadoDoJogo: .space 4
	ultimaTeclaPressionada: .space 4
	# TEMPO_SIST: .word  0
	vetorDeslocamentoPuloVertical: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
	vetorDeslocamentoPuloDiagonal: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
	.include "Sprites\source\Personagem_Parado_16_24_1_Frame.s"
	.include "Sprites\source\Cobra_10_10_1_Frame.s"
	.include "Sprites\source\Cobra_10_10_2_Frame.s"
	.include "Sprites\source\Cobra_10_10_3_Frame.s"
	.include "Sprites\source\Cobra_10_10_4_Frame.s"
	.include "Sprites\source\Cobra_10_10_5_Frame.s"
	.include "Sprites\source\Cobra_10_10_6_Frame.s"
	.include "Sprites\source\Cobra_10_10_7_Frame.s"
	.include "Sprites\source\Cogumelo_10_10_1Frame.s"
	.include "Sprites\source\Cogumelo_10_10_2Frame.s"
	.include "Sprites\source\DragonBall_10_10_1Frame.s"
	.include "Sprites\source\Fogueira_10_10_1Frame.s"
	.include "Sprites\source\Fogueira_10_10_2Frame.s"
	.include "Sprites\source\Fogueira_10_10_3Frame.s"
	.include "Sprites\source\Fogueira_10_10_4Frame.s"
	.include "Sprites\source\Jacare_10_10_1Frame.s"
	.include "Sprites\source\Jacare_10_10_2Frame.s"
	.include "Sprites\source\Moeda_10_10_1Frame.s"
	.include "Sprites\source\Moeda_10_10_2Frame.s"
	.include "Sprites\source\Moeda_10_10_3Frame.s"
	.include "Sprites\source\Moeda_10_10_4Frame.s"
	.include "Sprites\source\Moeda_10_10_5Frame.s"
	.include "Sprites\source\Moeda_10_10_6Frame.s"
	.include "Sprites\source\Personagem_Correndo_16_24_1.s"
	.include "Sprites\source\Personagem_Correndo_16_24_2.s"
	.include "Sprites\source\Personagem_Correndo_16_24_3.s"
	.include "Sprites\source\Personagem_Correndo_16_24_4.s"
	.include "Sprites\source\Personagem_Correndo_16_24_5.s"
	.include "Sprites\source\Personagem_Pulando_14_24_1Frame.s"
	.include "Sprites\source\Personagem_Pulando_14_24_2Frame.s"
	.include "Sprites\source\Pokebola_10_10_1Frame.s"
	.include "Sprites\source\Pokebola_10_10_2Frame.s"
	.include "Sprites\source\Pokebola_10_10_3Frame.s"
	.include "Sprites\source\Pokebola_10_10_4Frame.s"
	.include "Sprites\source\fase2.s"
													
.text
.include "macros2.s"
.include "macro.s"
.include "macro_personagem.s"
.include "macro_relogio.s"

M_SetEcall(exceptionHandling)
jal ra Main
FimDoPrograma: jal x0 FimDoPrograma
Main: nop
	addi sp sp -4
	sw ra 0(sp)
	li s0 0 # estado inicial
	li s4 0
	la s3 fase2
	addi s3 s3 8 # s3 = mapa inicial
	
	RELOGIO_INICIO(1200000)
	# printa o mapa
		li a0 0xff000000
		mv a1 s3
		li a2 320
		li a3 224
		jal ra printSprite
	
	InitPersonagem (POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X, POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y) #inicia o personagem
	loop_do_jogo_Main:
		# ecall tmepo
		li a7 30
		ecall
		mv s5 a0
		# end
				
		jal ra LeTeclaDoTeclado  # chama a funcao que le a tecla do teclado
		sw a0 ultimaTeclaPressionada, t0
		li t0 '\n'
		if_jogo_pausar_loop_do_jogo_Main: bne a0 t0 else_jogo_pausar_loop_do_jogo_Main
			la t0 estadoDoJogo
			lw t1 0(t0)
			xori t1 t1 1
			sw t1 0(t0)
			j loop_do_jogo_Main
		else_jogo_pausar_loop_do_jogo_Main:
			# a0 vem  daqui jal ra LeTeclaDoTeclado
			jal ra MovePersonagem
			# mv s4 a0 # ultima tecla pressionada

			# testes para ver qual personagem imprime
			li t0 0
			beq s0 t0 imprimir_personagem_parado # parado
			li t0 10 
			beq s0 t0 imprimir_personagem_correndo1 # 1 frame da corrida
			li t0 11 
			beq s0 t0 imprimir_personagem_correndo2 # 2 frame da corrida
			li t0 12 
			beq s0 t0 imprimir_personagem_correndo3 # 3 frame da corrida
			li t0 13 
			beq s0 t0 imprimir_personagem_correndo4 # 4 frame da corrida
			li t0 14 
			beq s0 t0 imprimir_personagem_correndo5 # 5 frame da corrida
			# fim dos testes

			imprimir_personagem_parado:
				la a0 Personagem_Parado_16_24_1_Frame
				j desenho_personagem
			imprimir_personagem_correndo1:
				la a0 Personagem_Correndo_16_24_1
				j desenho_personagem
			imprimir_personagem_correndo2:
				la a0 Personagem_Correndo_16_24_2
				j desenho_personagem
			imprimir_personagem_correndo3:
				la a0 Personagem_Correndo_16_24_3
				j desenho_personagem
			imprimir_personagem_correndo4:
				la a0 Personagem_Correndo_16_24_4
				j desenho_personagem
			imprimir_personagem_correndo5:
				la a0 Personagem_Correndo_16_24_5
				j desenho_personagem
				
			
			desenho_personagem:
			jal ra DesenhaSpritePersonagem
			lw s4 ultimaTeclaPressionada # salvando a ultima tecla pressionada
			mv s6 s0 # salva o ultimo estado
			
			
		while_nao_aconteceu_30_FPS:
			li t0 33
			li a7 30
			ecall
			sub a0 a0 s5
			blt a0 t0 while_nao_aconteceu_30_FPS # se o tempo for < 30 segundo fica preso no loop
		
		li a1, 4				# coluna do relogio
		li a2, 228				# linha do relogio
		jal RELOGIO_LOOP
		jal x0 loop_do_jogo_Main
	end_loop_do_jogo_Main:
	lw ra 0(sp)
	addi sp sp 4
FimMain: jalr x0 ra 0
.include "personagem.s"
.include "relogio.s"
.include "utilidades.s"
.include "movimentacoes/movimento_pulo.s"
.include "movimentacoes/movimento_direita.s"
.include "movimentacoes/movimento_pulo_direita.s"
.include "Utilidades_alvim.s"
.include "SYSTEMv12.s"
