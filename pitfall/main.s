d# | --- Tabela de registradores salvos --- 					|
# | s0 -> Estado atual do personagem						|
# | s1 -> Vetor de movimentacao para o pulo do personagem 	|
# | s2 -> Mapa atual										|
# | s3 - > Endereco da memoria onde esta o mapa atual 		|
# | s4 -> ultimo input										|
# | s5 -> tempo que o loop começou							|
# | s6 -> ultimo estado										|
# | s7 -> fase do jogo										|
# | s8 -> estado vai pra proxima fase						|			
# | s9 -> proxima fase										|
# | s10-> vazio												|
# | s11-> relogio do jogo									|

# | 			Tabela dos Estados de s0					|
# | -1 -> Parado para a esquerda							|
# | 0 - > Parado para a direita 							|
# | 1 - 9 -> Pulo vertical virado a direita					|
# | 10 - 14 -> movimentacao para a direita					|
# | 15 - 24 -> pulo para a direita							|
# | 30 - 39 -> pulo para a esquerda							|
# | 40 - 49 -> Pulo vertical virado a esquerda 				|
# | 50 - 60 -> Movimento Escada								|
# | 61 - 69 -> Queda										|
# | 70 - 79 -> saida da escada								|

# | 			   .data importados         				|
# | vidas (.word)  -> Vidas do jogador						|
# | pontos (.word) -> Quantidade de pontos do jogador		|

.data
	estadoDoJogo: .space 4
	ultimaTeclaPressionada: .space 4
	funcoesObjetosDoJogo: .space 44
	vetorDeslocamentoPuloVertical: .word -4,-2, -2, -2, 0, 2, 2, 2, 4
	vetorDeslocamentoPuloDiagonalEscada: .word -10,-8, -4, -2, 0, 2, 2, 2, 4
	vetorDeslocamentoPuloDiagonal: .word -4,-2, -2, -2, 0, 2, 2, 2, 4
	vectorImagensMenu: .space 12
	vectorFuncoesMenu: .space 12			
	.include "Sprites/source/sourcezao.s"	
	.include "Sprites/source/fase1.s"	
	.include "Sprites/source/fase3.s"	
	.include "Sprites/source/fase4.s"	
	.include "Sprites/source/fase5.s"	
	.include "Sprites/source/fase6.s"	
	.include "Sprites/source/fase7.s"	
	.include "Sprites/source/fase8.s"	
	.include "Sprites/source/fase9.s"	
	.include "Sprites/source/fase10.s"	
							

.text
.include "macros2.s"
.include "macro.s"
.include "macro_personagem.s"
.include "macro_relogio.s"
.include "macro_vida.s"
.include "macro_pontuacao.s"
.include "macro_song.s"
M_SetEcall(exceptionHandling)
jal ra Main
FimDoPrograma: jal x0 FimDoPrograma
Main:
	addi	sp sp -8
	sw ra 0(sp)
	sw t1 4(sp)
	jal ra InitFases
	lw t1 0(sp)
	addi sp sp 4
reset_MenuDoJogo:
    li t1 2
    la t2 vectorImagensMenu

    la t3 menuSair
    sw t3 0(t2)

    la t3 menuCreditos
    sw t3 4(t2)

    la t3 menuJogar
    sw t3 8(t2)


    la t2 vectorFuncoesMenu

    la t3 fim_while_loop_menu
    sw t3 0(t2)

    la t3 fim_while_loop_menu
    sw t3 4(t2)

    la t3 Jogo
    sw t3 8(t2)
    while_loop_menu:
    		addi sp sp -4
    		sw t1 0(sp)
        jal ra LeTeclaDoTeclado
    		lw t1 0(sp)
        addi sp sp 4
        li t0 'w'
        if_tecla_w_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_w_foi_apertada_MovePersonagem
            addi t1 t1 1
            li t3 3
            macro_song(61,350,118,60,0)          #BotaoMenu_song
            if_passou_do_limite_superior:bne t1 t3 else_passou_do_limite_superior
                addi t1 t1 -3
            else_passou_do_limite_superior:

                li a0 0xff004530

                la a1 vectorImagensMenu
  	            slli t2 t1 2
    	          add a1 a1 t2
      	        lw a1 0(a1)
	              addi a1 a1 8

                li a2 100

                li a3 129


                addi sp sp -4
                sw t1 0(sp)
                jal ra printSpriteWord
                lw t1 0(sp)
                addi sp sp 4

            jal x0 while_loop_menu
        else_tecla_w_foi_apertada_MovePersonagem:
            li t0 's'
            if_tecla_s_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_s_foi_apertada_MovePersonagem
                addi t1 t1 -1
                li t3 -1
                macro_song(61,350,118,60,0)          #BotaoMenu_song
                if_passou_do_limite_inferior: bne t1 t3 else_passou_do_limite_inferior
                    addi t1 t1 3
                else_passou_do_limite_inferior:

                li a0 0xff004530

                la a1 vectorImagensMenu
  	            slli t2 t1 2
    	          add a1 a1 t2
      	        lw a1 0(a1)
	              addi a1 a1 8

                li a2 100

                li a3 129

                addi sp sp -4
                sw t1 0(sp)
                jal ra printSpriteWord
                lw t1 0(sp)
                addi sp sp 4

                jal x0 while_loop_menu
            else_tecla_s_foi_apertada_MovePersonagem:
                li t0 ' '
                if_tecla_sp_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_sp_foi_apertada_MovePersonagem

                    addi sp sp -4
                    sw t1 0(sp)

                    la t2 vectorFuncoesMenu
                    slli t3 t1 2
                    add t2 t2 t3
                    lw t2 0(t2)

                    addi sp sp -4
                    sw t1 0(sp)
                    jalr ra t2 00
                    lw t1 0(sp)
                    addi sp sp 4

                    lw t1 0(sp)
                    addi sp sp 4

                    jal x0 reset_MenuDoJogo
                    jal x0 while_loop_menu
                else_tecla_sp_foi_apertada_MovePersonagem:
                    li a0 0xff004530

                    la a1 vectorImagensMenu
                    slli t2 t1 2
                    add a1 a1 t2
                    lw a1 0(a1)
                    addi a1 a1 8

                    li a2 100

                    li a3 129

                    addi sp sp -4
                    sw t1 0(sp)
                    jal ra printSpriteWord
                    lw t1 0(sp)
                    addi sp sp 4

	  jal x0 while_loop_menu
	  fim_while_loop_menu:

		lw ra 0(sp)
		addi	sp sp 4
FimMain: jalr x0 ra 0

Jogo: nop
	addi sp sp -4
	sw ra 0(sp)
	li s0 0 # estado inicial
	li s4 0
	la s9 vectorFases
	addi s3 s3 8 # s3 = mapa inicial
	RELOGIO_INICIO(1200000)				# Inicializar relogio do jogo
	inicializar_vida(3)					# Inicializar vidas
	li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X # argumentos de inicialização dos prsonagens
	li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y # argumentos de inicialização dos prsonagens
	inicializar_pontuacao(2000)			# Inicializar pontuacao

	loop_troca_fase_Jogo:
		mv s7 s9
		li s0 0 # estado inicial
		li s4 0
		lw s3 32(s7) # carrega o mapa da fase
		addi s3 s3 8 # s3 = mapa inicial
		# printa o mapa
	# printa o mapa
		li a0 0xff000000
		mv a1 s3
		li a2 320
		li a3 224
		jal ra printSprite
		

		# parte do codic[go responsavel po colocar coisa variaveis entre fase
		la t4 funcoesObjetosDoJogo 
		addi t2 s7 44
		addi t1 s7 16
		li s10 0
		loop_descobre_funcoes_do_jogo: beq t1 t2 end_loop_descobre_funcoes_do_jogo
			lw t3 0(t1)
			addi t1 t1 4
			if_tem_funcao_do_jogo: beq t3 x0 loop_descobre_funcoes_do_jogo
				la t0 funcoesObjetosDoJogo
				addi t0 s7 36
				beq t1 t0 loop_descobre_funcoes_do_jogo
					addi s10 s10 4
					sw t3 0(t4)
					addi t4 t4 4
		jal x0 loop_descobre_funcoes_do_jogo
		end_loop_descobre_funcoes_do_jogo:

		InitPersonagemReg(a4, a5) #inicializar o personagem
		
		loop_do_jogo_Jogo:
			# ecall tmepo
			li a7 30
			ecall
			mv s5 a0
			# end
			
		# estados que nao podem ter teclas lidas
		li t0 0											# \
		sgt t1 s0 t0									#  \
		li t0 10										#   - Pulo Vertical
		slt t2 s0 t0									#   /
		mv a0 s4										#  /
		beq t1 t2 else_jogo_pausar_loop_do_jogo_Jogo 	# /	

		li t0 14										# \	
		sgt t1 s0 t0									#  \
		li t0 25										#    - Pulo Diagonal direita
		slt t2 s0 t0									#   /
		mv a0 s4										#  /
		beq t1 t2 else_jogo_pausar_loop_do_jogo_Jogo	# /

		li t0 29										# \	
		sgt t1 s0 t0									#  \
		li t0 40										#    - Pulo Diagonal direita
		slt t2 s0 t0									#   /
		mv a0 s4										#  /
		beq t1 t2 else_jogo_pausar_loop_do_jogo_Jogo	# /

		li t0 60										# \	
		sgt t1 s0 t0									#  \
		li t0 70										#    - Queda
		slt t2 s0 t0									#   /
		mv a0 s4										#  /
		beq t1 t2 else_jogo_pausar_loop_do_jogo_Jogo	# /

		li t0 69										# \	
		sgt t1 s0 t0									#  \
		li t0 80										#    - Saida Escada
		slt t2 s0 t0									#   /
		mv a0 s4										#  /
		beq t1 t2 else_jogo_pausar_loop_do_jogo_Jogo	# /

		# fim desses estados
		jal ra LeTeclaDoTeclado  # chama a funcao que le a tecla do teclado
		sw a0 ultimaTeclaPressionada, t0
		li t0 1
		li t0 '\n'
		if_jogo_pausar_loop_do_jogo_Jogo: bne a0 t0 else_jogo_pausar_loop_do_jogo_Jogo
			la t0 estadoDoJogo
			lw t1 0(t0)
			xori t1 t1 1
			sw t1 0(t0)
			j loop_do_jogo_Jogo
		else_jogo_pausar_loop_do_jogo_Jogo:
			# a0 vem  daqui jal ra LeTeclaDoTeclado
			jal ra MovePersonagem
			# mv s4 a0 # ultima tecla pressionada

			# Se estiver caindo, pular colisao
			li t0 60										# \	
			sgt t1 s0 t0									#  \
			li t0 70										#    - Queda
			slt t2 s0 t0									#   /
			mv a0 s4										#  /
			beq t1 t2 fim_acoes								# /

			# Colocar colisao aqui

			# buracos sem ser o buracao

			li t0 125
			lw t1 posicaoPersonagemY
			blt t1 t0 fim_acoes # se ele estiver acima do buraco
			li t0 180
			bge t1 t0 fim_acoes # se ele estiver abaixo do buraco

			li t0 85
			lw t1 posicaoPersonagemX
			sgt t2 t1 t0
			li t0 114
			slt t3 t1 t0 # se o personagem estiver no primeiro buraco
			beq t3 t2 caiu_buraco

			li t0 203
			lw t1 posicaoPersonagemX
			sgt t2 t1 t0
			li t0 234
			slt t3 t1 t0 # se o personagem estiver no primeiro buraco
			beq t3 t2 caiu_buraco	
		
			# Fim das colisoes
			fim_colisoes:
			j fim_acoes

			# acoes com base nas colisoes
			caiu_buraco:
				li s0 61
				la t0 incioQueda
				jalr t0 0
				j fim_acoes
			# fim das acoes

			fim_acoes:

			# testes para ver qual personagem imprime
			li t0 -1
			beq s0 t0 imprimir_personagem_parado_esquerda # parado para a esquerda
			li t0 0
			beq s0 t0 imprimir_personagem_parado_direita # parado para a direita

			li t0 0
			sgt t1 s0 t0  # s0 >= 1
			li t0 10
			slt t2 s0 t0  # s0 < 10
			beq t2 t1 imprimir_personagem_pulo_direita2 # pulo vertical para a direita

			li t0 10 
			beq s0 t0 imprimir_personagem_correndo1_direita # 1 frame da corrida para a direita
			li t0 11 
			beq s0 t0 imprimir_personagem_correndo2_direita # 2 frame da corrida para a direita
			li t0 12 
			beq s0 t0 imprimir_personagem_correndo3_direita # 3 frame da corrida para a direita
			li t0 13 
			beq s0 t0 imprimir_personagem_correndo4_direita # 4 frame da corrida para a direita
			li t0 14 
			beq s0 t0 imprimir_personagem_correndo5_direita # 5 frame da corrida para a direita

			li t0 15 
			beq s0 t0 imprimir_personagem_pulo_direita1 # pulo para a direita
			li t0 15
			sgt t1 s0 t0  # s0 >= 16
			li t0 25
			slt t2 s0 t0  # s0 <= 26
			beq t2 t1 imprimir_personagem_pulo_direita2
			li t0 25 
			beq s0 t0 imprimir_personagem_correndo1_esquerda # 1 frame da corrida para a esquerda
			li t0 26 
			beq s0 t0 imprimir_personagem_correndo2_esquerda # 2 frame da corrida para a esquerda
			li t0 27 
			beq s0 t0 imprimir_personagem_correndo3_esquerda # 3 frame da corrida para a esquerda
			li t0 28 
			beq s0 t0 imprimir_personagem_correndo4_esquerda # 4 frame da corrida para a esquerda
			li t0 29 
			beq s0 t0 imprimir_personagem_correndo5_esquerda # 5 frame da corrida para a esquerda

			li t0 30 
			beq s0 t0 imprimir_personagem_pulo_direita1_Espelhado # pulo para a direita
			li t0 30
			sgt t1 s0 t0  # s0 >= 31
			li t0 40
			slt t2 s0 t0  # s0 <= 39
			beq t2 t1 imprimir_personagem_pulo_direita2_Espelhado

			li t0 39
			sgt t1 s0 t0  # s0 >= 40
			li t0 50
			slt t2 s0 t0  # s0 <= 49
			beq t2 t1 imprimir_personagem_pulo_direita2_Espelhado

			li t0 49
			sgt t1 s0 t0  # s0 >= 50
			li t0 61
			slt t2 s0 t0  # s0 <= 60
			beq t2 t1 imprimir_personagem_escada

			li t0 60
			sgt t1 s0 t0  # s0 >= 50
			li t0 70
			slt t2 s0 t0  # s0 <= 60
			beq t2 t1 imprimir_personagem_queda # queda

			li t0 69
			sgt t1 s0 t0  # s0 >= 50
			li t0 80
			slt t2 s0 t0  # s0 <= 60
			beq t2 t1 imprimir_personagem_saida_escada

			# fim dos testes

			imprimir_personagem_parado_esquerda:
				la a0 Personagem_Parado_16_24_1_Frame_Espelhado
				j desenho_personagem
			imprimir_personagem_parado_direita:
				la a0 Personagem_Parado_16_24_1_Frame
				j desenho_personagem

			imprimir_personagem_correndo1_direita:
				la a0 Personagem_Correndo_16_24_1
				j desenho_personagem
			imprimir_personagem_correndo2_direita:
				la a0 Personagem_Correndo_16_24_2
				j desenho_personagem
			imprimir_personagem_correndo3_direita:
				la a0 Personagem_Correndo_16_24_3
				j desenho_personagem
			imprimir_personagem_correndo4_direita:
				la a0 Personagem_Correndo_16_24_4
				j desenho_personagem
			imprimir_personagem_correndo5_direita:
				la a0 Personagem_Correndo_16_24_5
				j desenho_personagem

			imprimir_personagem_pulo_direita1:
				macro_song(61,500,115,127,10)
				macro_song(63,500,115,127,10)
				macro_song(65,500,115,127,10)
				macro_song(67,500,115,127,10)
				macro_song(69,500,115,127,10)
				la a0 Personagem_Pulando_14_24_1Frame
				j desenho_personagem
			imprimir_personagem_pulo_direita2:
				macro_song(61,500,115,127,10)
				macro_song(63,500,115,127,10)
				macro_song(65,500,115,127,10)
				macro_song(67,500,115,127,10)
				macro_song(69,500,115,127,10)
				la a0 Personagem_Pulando_14_24_2Frame
				j desenho_personagem

			imprimir_personagem_correndo1_esquerda:
				la a0 Personagem_Correndo_16_24_1_Espelhado
				j desenho_personagem
			imprimir_personagem_correndo2_esquerda:
				la a0 Personagem_Correndo_16_24_2_Espelhado
				j desenho_personagem
			imprimir_personagem_correndo3_esquerda:
				la a0 Personagem_Correndo_16_24_3_Espelhado
				j desenho_personagem
			imprimir_personagem_correndo4_esquerda:
				la a0 Personagem_Correndo_16_24_4_Espelhado
				j desenho_personagem
			imprimir_personagem_correndo5_esquerda:
				la a0 Personagem_Correndo_16_24_5_Espelhado
				j desenho_personagem

			imprimir_personagem_pulo_direita1_Espelhado:
				macro_song(61,500,115,127,10)
				macro_song(63,500,115,127,10)
				macro_song(65,500,115,127,10)
				macro_song(67,500,115,127,10)
				macro_song(69,500,115,127,10)
				la a0 Personagem_Pulando_14_24_1Frame_Espelhado
				j desenho_personagem
			imprimir_personagem_pulo_direita2_Espelhado:
				macro_song(61,500,115,127,10)
				macro_song(63,500,115,127,10)
				macro_song(65,500,115,127,10)
				macro_song(67,500,115,127,10)
				macro_song(69,500,115,127,10)
				la a0 Personagem_Pulando_14_24_2Frame_Espelhado
				j desenho_personagem

			imprimir_personagem_escada:
				li t0 2
				rem t0 s0 t0 # descobrir se s0 e impar ou par
				beq t0 zero imprimir_personagem_escada_2
					la a0 Personagem_Escalando_10_26_1Frame
					j desenho_personagem
			imprimir_personagem_escada_2:
				la a0 Personagem_Escalando_10_26_2Frame
				j desenho_personagem
			imprimir_personagem_queda:
				la a0 Personagem_Parado_16_24_1_Frame
				j desenho_personagem
			imprimir_personagem_saida_escada:
				la a0 Personagem_Pulando_14_24_2Frame
				j desenho_personagem
				
				desenho_personagem:
				jal ra DesenhaSpritePersonagem
				lw s4 ultimaTeclaPressionada # salvando a ultima tecla pressionada
				mv s6 s0 # salva o ultimo estado

				# chama as funções dos objetos do jogo
				la t0 funcoesObjetosDoJogo
				add t1 t0 s10
				while_chama_funcoes_do_jogo: beq t1 t0 fim_while_chama_funcoes_do_jogo
					lw t2 0(t0)
					jalr ra t2 0
					addi t0 t0 4
					jal x0 while_chama_funcoes_do_jogo
				fim_while_chama_funcoes_do_jogo:

				la t0 posicaoPersonagemY
				lw t0 0(t0)
				li t1 144
				if_esta_em_cima: bgt t0 t1 else_esta_em_cima
					la t0 posicaoPersonagemX
					lw t0 0(t0)
					li t1 308
					if_esta_na_direita_cima: blt t0 t1 else_esta_na_direita_cima
						lw s9 8(s7)
						li s8 1
						li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X
						li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y
						jal x0 loop_troca_fase_Jogo
					else_esta_na_direita_cima:
						li t1 12
						if_esta_na_esquerda_cima: bgt t0 t1 else_esta_em_baixo
							lw s9 0(s7)
							li s8 1
							li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X
							li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y
							jal x0 loop_troca_fase_Jogo
						else_esta_na_esquerda_cima:
				else_esta_em_cima:
					if_esta_em_baixo:
						la t0 posicaoPersonagemX
						lw t0 0(t0)
						li t1 308
						if_esta_na_direita_baixo: blt t0 t1 else_esta_na_direita_baixo
							lw s9 12(s7)
							li s8 1
							li a4 POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_X
							li a5 POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_Y
							jal x0 loop_troca_fase_Jogo
						else_esta_na_direita_baixo:
							li t1 12
							if_esta_na_esquerda_baixo:  bgt t0 t1 else_esta_em_baixo
								lw s9 4(s7)
								li s8 1
								li a4 POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_X
								li a5 POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_Y
								jal x0 loop_troca_fase_Jogo
							else_esta_na_esquerda_baixo:
					else_esta_em_baixo:
				
				
			li t0 100
			while_nao_aconteceu_30_FPS:
				li a7 30
				ecall
				sub a0 a0 s5
				blt a0 t0 while_nao_aconteceu_30_FPS # se o tempo for < 30 segundo fica preso no loop
			
			li a1, 4				# coluna do relogio
			li a2, 228				# linha do relogio
			jal RELOGIO_LOOP

			li a0, 0XFF000000		# end. bitmap
			li a1, 228				# coord Y
			li a2, 280				# coord X
			jal imprimir_vida	

			jal imprimir_pontuacao

			jal x0 loop_do_jogo_Jogo
			end_loop_do_jogo_Jogo:
		jal x0 loop_troca_fase_Jogo
	end_loop_troca_fase_Jogo:
	lw ra 0(sp)
	addi sp sp 4
FimJogo: jalr x0 ra 0
.include "Utilidades_alvim.s"
.include "vetorJogo.s"
.include "utilidades.s"
.include "personagem.s"
.include "relogio.s"
.include "pontuacao.s"
.include "vida.s"
.include "movimentacoes/movimento_pulo.s"
.include "movimentacoes/movimento_pulo_vertical_esquerda.s"
.include "movimentacoes/movimento_direita.s"
.include "movimentacoes/movimento_esquerda.s"
.include "movimentacoes/movimento_pulo_direita.s"
.include "movimentacoes/movimento_pulo_esquerda.s"
.include "movimentacoes/movimento_escada.s"
.include "movimentacoes/movimento_queda.s"
.include "movimentacoes/movimentacao_saida_escada.s"
.include "SYSTEMv12.s"

