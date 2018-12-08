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
# | s11-> relógio do jogo

# | 					Tabela dos Estados					|
# | 0 - > Parado 											|
# | 1 - 9 -> Pulo vertical									|
# | 10 - 14 -> movimentacao para a direita					|
# | 15 - 24 -> movimentacao para a direita					|

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
.include "macro.s"
.include "macro_personagem.s"

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

		jal ra LeTeclaDoTeclado  # chama a funcao que le a tecla do teclado
		sw a0 ultimaTeclaPressionada, t0
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
			
			
		li t0 33
		while_nao_aconteceu_30_FPS:
			li a7 30
			ecall
			sub a0 a0 s5
			blt a0 t0 while_nao_aconteceu_30_FPS # se o tempo for < 30 segundo fica preso no loop
		jal x0 loop_do_jogo_Jogo
	end_loop_do_jogo_Jogo:
	lw ra 0(sp)
	addi sp sp 4
FimJogo: jalr x0 ra 0
.include "personagem.s"
.include "utilidades.s"
.include "movimentacoes/movimento_pulo.s"
.include "movimentacoes/movimento_direita.s"
.include "movimentacoes/movimento_pulo_direita.s"
.include "Utilidades_alvim.s"
