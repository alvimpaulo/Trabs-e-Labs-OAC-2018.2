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
	vetorDeslocamentoPulo: .word -10,-8, -5, -3, 0, 3, 5, 8, 10
	vetorDeslocamentoPuloVertical: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
	vetorDeslocamentoPuloDiagonal: .word -10,-8, -4, -2, 0, 2, 4, 8, 10
    vectorImagensMenu: .space 12
    vectorFuncoesMenu: .space 12
	.include "Sprites\source\menuJogar.s"
	.include "Sprites\source\menuCreditos.s"
	.include "Sprites\source\menuSair.s"
	.include "Sprites\source\Personagem_Parado_16_24_1_Frame.s"
	.include "Sprites\source\Personagem_Parado_16_24_1_Frame_Espelhado.s"
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
	.include "Sprites\source\Personagem_Correndo_16_24_1_Espelhado.s"
	.include "Sprites\source\Personagem_Correndo_16_24_2_Espelhado.s"
	.include "Sprites\source\Personagem_Correndo_16_24_3_Espelhado.s"
	.include "Sprites\source\Personagem_Correndo_16_24_4_Espelhado.s"
	.include "Sprites\source\Personagem_Correndo_16_24_5_Espelhado.s"
	.include "Sprites\source\Personagem_Pulando_14_24_1Frame.s"
	.include "Sprites\source\Personagem_Pulando_14_24_2Frame.s"
	.include "Sprites\source\Personagem_Pulando_14_24_1Frame_Espelhado.s"
	.include "Sprites\source\Personagem_Pulando_14_24_2Frame_Espelhado.s"
	.include "Sprites\source\Pokebola_10_10_1Frame.s"
	.include "Sprites\source\Pokebola_10_10_2Frame.s"
	.include "Sprites\source\Pokebola_10_10_3Frame.s"
	.include "Sprites\source\Pokebola_10_10_4Frame.s"
	.include "Sprites\source\fase2.s"
	.include "/Sprites/source/Coracao_10_8_1Frame.s"										
.text
.include "macros2.s"
.include "macro.s"
.include "macro_personagem.s"
.include "macro_relogio.s"
.include "macro_vida.s"

M_SetEcall(exceptionHandling)
jal ra Main
FimDoPrograma: jal x0 FimDoPrograma
Main:
reset_MenuDoJogo:
		addi	sp sp -4
		sw ra 0(sp)
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
	la s3 fase2
	addi s3 s3 8 # s3 = mapa inicial
	
	RELOGIO_INICIO(1200000)				# Inicializar relogio do jogo
	inicializar_vida(3)					# Inicializar vidas
	# printa o mapa
		li a0 0xff000000
		mv a1 s3
		li a2 320
		li a3 224
		jal ra printSprite
	
	
	InitPersonagem (POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X, POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y) #inicia o personagem
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
.include "movimentacoes/movimento_escada_cima.s"
.include "Utilidades_alvim.s"
.include "SYSTEMv12.s"
