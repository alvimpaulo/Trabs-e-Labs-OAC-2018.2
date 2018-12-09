# | --- Tabela de registradores salvos --- 					|
# | s0 -> Estado atual do personagem						|
# | s1 -> Vetor de movimentacao para o pulo do personagem 	|
# | s2 -> Mapa atual										|
# | s3 - > Endereco da memoria onde esta o mapa atual 		|
# | s4 -> ultimo input										|
# | s5 -> tempo que o loop começou							|
# | s6 -> ultimo estado										|
# | s7 -> fase do jogo										|
# | s8 -> estado vai pra proxima fase												|
# | s9 -> proxima fase												|
# | s10-> vazio												|
# | s11-> relogio do jogo

# | 			Tabela dos Estados de s0					|
# | -1 -> Parado para a esquerda							|
# | 0 - > Parado para a direita 							|
# | 1 - 9 -> Pulo vertical virado a direita					|
# | 10 - 14 -> movimentacao para a direita					|
# | 15 - 24 -> pulo para a direita							|
# | 25 - 29 -> movimentacao para a esquerda					|
# | 30 - 39 -> pulo para a esquerda							|
# | 40 - 49 -> Pulo vertical virado a esquerda 				|

.data
	estadoDoJogo: .space 4
	ultimaTeclaPressionada: .space 4
	funcoesObjetosDoJogo: .space 44
	vetorDeslocamentoPulo: .word -10,-8, -5, -3, 0, 3, 5, 8, 10
	vetorDeslocamentoPuloVertical: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
	vetorDeslocamentoPuloDiagonal: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
  vectorImagensMenu: .space 12
  vectorFuncoesMenu: .space 12
	.include "Sprites\source\output.s"
	# .include "Sprites\source\Cobra_10_10_1_Frame.s"
	# .include "Sprites\source\Cobra_10_10_2_Frame.s"
	# .include "Sprites\source\Cobra_10_10_3_Frame.s"
	# .include "Sprites\source\Cobra_10_10_4_Frame.s"
	# .include "Sprites\source\Cobra_10_10_5_Frame.s"
	# .include "Sprites\source\Cobra_10_10_6_Frame.s"
	# .include "Sprites\source\Cobra_10_10_7_Frame.s"
	# .include "Sprites\source\Cogumelo_10_10_1Frame.s"
	# .include "Sprites\source\Cogumelo_10_10_2Frame.s"
	# .include "Sprites\source\DragonBall_10_10_1Frame.s"
	# .include "Sprites\source\Fogueira_10_10_1Frame.s"
	# .include "Sprites\source\Fogueira_10_10_2Frame.s"
	# .include "Sprites\source\Fogueira_10_10_3Frame.s"
	# .include "Sprites\source\Fogueira_10_10_4Frame.s"
	# .include "Sprites\source\Jacare_10_10_1Frame.s"
	# .include "Sprites\source\Jacare_10_10_2Frame.s"
	# .include "Sprites\source\Moeda_10_10_1Frame.s"
	# .include "Sprites\source\Moeda_10_10_2Frame.s"
	# .include "Sprites\source\Moeda_10_10_3Frame.s"
	# .include "Sprites\source\Moeda_10_10_4Frame.s"
	# .include "Sprites\source\Moeda_10_10_5Frame.s"
	# .include "Sprites\source\Moeda_10_10_6Frame.s"
	#.include "Sprites\source\Personagem_Parado_16_24_1_Frame_Espelhado.s"
	# .include "Sprites\source\Cobra_10_10_1_Frame.s"
	# .include "Sprites\source\Cobra_10_10_2_Frame.s"
	# .include "Sprites\source\Cobra_10_10_3_Frame.s"
	# .include "Sprites\source\Cobra_10_10_4_Frame.s"
	# .include "Sprites\source\Cobra_10_10_5_Frame.s"
	# .include "Sprites\source\Cobra_10_10_6_Frame.s"
	# .include "Sprites\source\Cobra_10_10_7_Frame.s"
	# .include "Sprites\source\Cogumelo_10_10_1Frame.s"
	# .include "Sprites\source\Cogumelo_10_10_2Frame.s"
	# .include "Sprites\source\Personagem_Parado_16_24_1_Frame.s"
	# .include "Sprites\source\DragonBall_10_10_1Frame.s"
	# .include "Sprites\source\Fogueira_10_10_1Frame.s"
	# .include "Sprites\source\Fogueira_10_10_2Frame.s"
	# .include "Sprites\source\Fogueira_10_10_3Frame.s"
	# .include "Sprites\source\Fogueira_10_10_4Frame.s"
	# .include "Sprites\source\Jacare_10_10_1Frame.s"
	# .include "Sprites\source\Jacare_10_10_2Frame.s"
	# .include "Sprites\source\Moeda_10_10_1Frame.s"
	# .include "Sprites\source\Moeda_10_10_2Frame.s"
	# .include "Sprites\source\Moeda_10_10_3Frame.s"
	# .include "Sprites\source\Moeda_10_10_4Frame.s"
	# .include "Sprites\source\Moeda_10_10_5Frame.s"
	# .include "Sprites\source\Moeda_10_10_6Frame.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_1.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_2.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_3.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_4.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_5.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_1_Espelhado.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_2_Espelhado.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_3_Espelhado.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_4_Espelhado.s"
	# .include "Sprites\source\Personagem_Correndo_16_24_5_Espelhado.s"
	# .include "Sprites\source\Personagem_Pulando_14_24_1Frame.s"
	# .include "Sprites\source\Personagem_Pulando_14_24_2Frame.s"
	# .include "Sprites\source\Pokebola_10_10_1Frame.s"
	# .include "Sprites\source\Pokebola_10_10_2Frame.s"
	# .include "Sprites\source\Pokebola_10_10_3Frame.s"
	# .include "Sprites\source\Pokebola_10_10_4Frame.s"
	# .include "Sprites\source\fase1.s"
	# .include "Sprites\source\fase2.s"
	# .include "Sprites\source\fase3.s"
	# .include "Sprites\source\fase4.s"
	# .include "Sprites\source\fase5.s"
	# .include "Sprites\source\fase6.s"
	# .include "Sprites\source\fase7.s"
	# .include "Sprites\source\fase8.s"
	# .include "Sprites\source\fase9.s"
	# .include "Sprites\source\fase10.s"
	# .include "Sprites\source\Personagem_Pulando_14_24_1Frame_Espelhado.s"
	# .include "Sprites\source\Personagem_Pulando_14_24_2Frame_Espelhado.s"
	# .include "Sprites\source\Pokebola_10_10_1Frame.s"
	# .include "Sprites\source\Pokebola_10_10_2Frame.s"
	# .include "Sprites\source\Pokebola_10_10_3Frame.s"
	# .include "Sprites\source\Pokebola_10_10_4Frame.s"
	# .include "/Sprites/source/Coracao_10_8_1Frame.s"
  
	# .include "Sprites\source\menuJogar.s"
	# .include "Sprites\source\menuCreditos.s"
	# .include "Sprites\source\menuSair.s"
  .include "macros2.s"
  .include "macro.s"
  .include "macro_personagem.s"
  .include "macro_relogio.s"
  .include "macro_vida.s"
.text

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
	li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X
	li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y

	loop_troca_fase_Jogo:
		mv s7 s9
		li s0 0 # estado inicial
		li s4 0
		lw s3 32(s7)
		addi s3 s3 8 # s3 = mapa inicial
		# printa o mapa

	# printa o mapa
		li a0 0xff000000
		mv a1 s3
		li a2 320
		li a3 224
		jal ra printSprite
		
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
		InitPersonagemReg(a4, a5)

		# loop_do_jogo_Jogo:
		# 	# ecall tmepo
		# 	li a7 30
		# 	ecall
		# 	mv s5 a0
		# 	# end

		# 	jal ra LeTeclaDoTeclado  # chama a funcao que le a tecla do teclado
		# 	sw a0 ultimaTeclaPressionada, t0
		# 	li t0 '\n'
		# 	if_jogo_pausar_loop_do_jogo_Jogo: bne a0 t0 else_jogo_pausar_loop_do_jogo_Jogo
		# 		la t0 estadoDoJogo
		# 		lw t1 0(t0)
		# 		xori t1 t1 1
		# 		sw t1 0(t0)
		# 		j loop_do_jogo_Jogo
		# 	else_jogo_pausar_loop_do_jogo_Jogo:
		# 		# a0 vem  daqui jal ra LeTeclaDoTeclado
		# 		jal ra MovePersonagem
		# 		# mv s4 a0 # ultima tecla pressionada

		# 		# testes para ver qual personagem imprime
		# 		li t0 0
		# 		beq s0 t0 imprimir_personagem_parado # parado
		# 		li t0 10
		# 		beq s0 t0 imprimir_personagem_correndo1 # 1 frame da corrida
		# 		li t0 11
		# 		beq s0 t0 imprimir_personagem_correndo2 # 2 frame da corrida
		# 		li t0 12
		# 		beq s0 t0 imprimir_personagem_correndo3 # 3 frame da corrida
		# 		li t0 13
		# 		beq s0 t0 imprimir_personagem_correndo4 # 4 frame da corrida
		# 		li t0 14
		# 		beq s0 t0 imprimir_personagem_correndo5 # 5 frame da corrida
		# 		# fim dos testes

		# 		imprimir_personagem_parado:
		# 			la a0 Personagem_Parado_16_24_1_Frame
		# 			j desenho_personagem
		# 		imprimir_personagem_correndo1:
		# 			la a0 Personagem_Correndo_16_24_1
		# 			j desenho_personagem
		# 		imprimir_personagem_correndo2:
		# 			la a0 Personagem_Correndo_16_24_2
		# 			j desenho_personagem
		# 		imprimir_personagem_correndo3:
		# 			la a0 Personagem_Correndo_16_24_3
		# 			j desenho_personagem
		# 		imprimir_personagem_correndo4:
		# 			la a0 Personagem_Correndo_16_24_4
		# 			j desenho_personagem
		# 		imprimir_personagem_correndo5:
		# 			la a0 Personagem_Correndo_16_24_5
		# 			j desenho_personagem


		# 		desenho_personagem:
		# 		jal ra DesenhaSpritePersonagem
		# 		lw s4 ultimaTeclaPressionada # salvando a ultima tecla pressionada
		# 		mv s6 s0 # salva o ultimo estado

		# 		la t0 funcoesObjetosDoJogo
		# 		add t1 t0 s10
		# 		while_chama_funcoes_do_jogo: beq t1 t0 fim_while_chama_funcoes_do_jogo
		# 			lw t2 0(t0)
		# 			jalr ra t2 0
		# 			addi t0 t0 4
		# 			jal x0 while_chama_funcoes_do_jogo
		# 		fim_while_chama_funcoes_do_jogo:

		# 		la t0 cimaOuBaixo
		# 		lw t0 0(t0)
		# 		if_esta_em_cima: bne t0 x0 else_esta_em_cima
		# 			la t0 posicaoPersonagemX
		# 			lw t0 0(t0)
		# 			li t1 308
		# 			if_esta_na_direita_cima: blt t0 t1 else_esta_na_direita_cima
		# 				lw s9 8(s7)
		# 				li s8 1
		# 				li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X
		# 				li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y
		# 				jal x0 loop_troca_fase_Jogo
		# 			else_esta_na_direita_cima:
		# 				li t1 12
		# 				if_esta_na_esquerda_cima: bgt t0 t1 else_esta_em_baixo
		# 					lw s9 0(s7)
		# 					li s8 1
		# 					li a4 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X
		# 					li a5 POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y
		# 					jal x0 loop_troca_fase_Jogo
		# 				else_esta_na_esquerda_cima:
		# 		else_esta_em_cima:
		# 			if_esta_em_baixo:
		# 				la t0 posicaoPersonagemX
		# 				lw t0 0(t0)
		# 				li t1 308
		# 				if_esta_na_direita_baixo: blt t0 t1 else_esta_na_direita_baixo
		# 					lw s9 16(s7)
		# 					li s8 1
		# 					li a4 POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_X
		# 					li a5 POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_Y
		# 					jal x0 loop_troca_fase_Jogo
		# 				else_esta_na_direita_baixo:
		# 					li t1 12
		# 					if_esta_na_esquerda_baixo:  bgt t0 t1 else_esta_em_baixo
		# 						lw s9 4(s7)
		# 						li s8 1
		# 						li a4 POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_X
		# 						li a5 POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_Y
		# 						jal x0 loop_troca_fase_Jogo
		# 					else_esta_na_esquerda_baixo:
		# 			else_esta_em_baixo:

		# 	li t0 33
		# 	while_nao_aconteceu_30_FPS:
		# 		li a7 30
		# 		ecall
		# 		sub a0 a0 s5
		# 		blt a0 t0 while_nao_aconteceu_30_FPS # se o tempo for < 30 segundo fica preso no loop
		# 	#beq s8 x0 loop_do_jogo_Jogo
		# 	jal x0 loop_do_jogo_Jogo
		# end_loop_do_jogo_Jogo:
		
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
					la a0 Personagem_Pulando_14_24_1Frame
					j desenho_personagem
				imprimir_personagem_pulo_direita2:
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
					la a0 Personagem_Pulando_14_24_1Frame_Espelhado
					j desenho_personagem
				imprimir_personagem_pulo_direita2_Espelhado:
					la a0 Personagem_Pulando_14_24_2Frame_Espelhado
					j desenho_personagem
					
				
				desenho_personagem:
				jal ra DesenhaSpritePersonagem
				lw s4 ultimaTeclaPressionada # salvando a ultima tecla pressionada
				mv s6 s0 # salva o ultimo estado


				la t0 funcoesObjetosDoJogo
				add t1 t0 s10
				while_chama_funcoes_do_jogo: beq t1 t0 fim_while_chama_funcoes_do_jogo
					lw t2 0(t0)
					jalr ra t2 0
					addi t0 t0 4
					jal x0 while_chama_funcoes_do_jogo
				fim_while_chama_funcoes_do_jogo:
				la t0 cimaOuBaixo
				lw t0 0(t0)
				if_esta_em_cima: bne t0 x0 else_esta_em_cima
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
							lw s9 16(s7)
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

			jal x0 loop_do_jogo_Jogo
		end_loop_do_jogo_Jogo:
		jal x0 loop_troca_fase_Jogo
	end_loop_troca_fase_Jogo:
	lw ra 0(sp)
	addi sp sp 4
FimJogo: jalr x0 ra 0
.include "personagem.s"
.include "relogio.s"
.include "vida.s"
.include "utilidades.s"
.include "movimentacoes/movimento_pulo.s"
.include "movimentacoes/movimento_pulo_vertical_esquerda.s"
.include "movimentacoes/movimento_direita.s"
.include "movimentacoes/movimento_esquerda.s"
.include "movimentacoes/movimento_pulo_direita.s"
.include "movimentacoes/movimento_pulo_esquerda.s"
.include "Utilidades_alvim.s"
.include "vetorJogo.s"
.include "SYSTEMv12.s"
