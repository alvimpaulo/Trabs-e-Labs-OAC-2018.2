.data
    vectorImagensMenu: .space 12
    vectorFuncoesMenu: .space 12
.text
MenuDoJogo:
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
    
    la t3 FimDoPrograma
    sw t3 0(t2)
    
    la t3 FimDoPrograma
    sw t3 4(t2)
    
    la t3 Main
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
FimMenuDoJogo: jal x0 MenuDoJogo

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
loopDesenhaHalfWord:beq t5  t3  fimloopDesenhaHalfWord
testeFimLinhaWord:	beq t4  t2  fimDaLinhaSpriteWord
	lw t6  0(t1) # carrega o valor da half que esta em a1
	sw t6  0(t0) # manda o valor que esta dentro dos dados para o display  posicao s0
	addi t0  t0  4 # proximos 2pixel do mapa
	addi t1  t1  4 # proximos 2 pixel do player
	addi t4  t4  4 # itera  horizontal
	j loopDesenhaHalfWord
fimDaLinhaSpriteWord:
	sub s1  s0  t2 #subtrai largura da sprite de 320
	add t0  t0  s1 #pula uma linha (320 - largura)
	addi t5  t5  1 #itera o contador vertical
	li t4  0 #reseta o contador
	j loopDesenhaHalfWord
fimloopDesenhaHalfWord:
	lw ra 0(sp)
	lw s0 4(sp)
	lw s1 8(sp)
	addi sp  sp  12
	jalr x0 ra 0
