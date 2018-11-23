.data
	estadoDoJogo: .space 4 	# 0 está pausado
													# 1 não está pausado
.text
.include "macro.s"
.include "macro_personagem.s"
jal ra Main
FimDoPrograma: jal x0 FimDoPrograma
Main: nop
	addi sp sp -4
	sw ra 0(sp)
	InitPersonagem (POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X, POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y) #inicia o personagem
	loop_do_jogo_Main:
		jal ra LeTeclaDoTeclado  #chama a função que le a tecla do teclado
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
			jal ra DesenhaPersonagem
		jal x0 loop_do_jogo_Main
	end_loop_do_jogo_Main:
	lw ra 0(sp)
	addi sp sp 4
FimMain: jalr x0 ra 0
.include "personagem.s"
.include "utilidades.s"
