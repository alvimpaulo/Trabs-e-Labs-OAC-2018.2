.text
    incioPuloDireita: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 14
        ble s0, t0, fimPuloDireita # s0 fora da faixa para pulo para a direita
        li t0 20
        bge s0 t0 fimPuloDireita # se s0 nao for um estado do pulo direita (>= 20) 
        
        # checar os estados para descobrir qual sprite apagar
            li t0 10 # estado corrida direita 1
			beq s0 t0 la_personagem_correndo_1 # apaga a sprite 1 de personagem correndo
            li t0 11 # estado corrida direita 2
			beq s0 t0 la_personagem_correndo_2 # apaga a sprite 2 de personagem correndo
            li t0 12 # estado corrida direita 3
			beq s0 t0 la_personagem_correndo_3 # apaga a sprite 3 de personagem correndo
            li t0 13 # estado corrida direita 4
			beq s0 t0 la_personagem_correndo_4 # apaga a sprite 4 de personagem correndo
            li t0 14 # estado corrida direita 5
			beq s0 t0 la_personagem_correndo_5 # apaga a sprite 5 de personagem correndo
            li t0 15 # estado pulo 1
			beq s0 t0 la_personagem_pulando_1 # apaga a sprite 1 de personagem pulando
            li t0 16 # estado pulo > 1
			bge s0 t0 la_personagem_pulando_2 # apaga a sprite 2 de personagem pulando
			
        # fim da checagem
        
        # apagar personagem certo
            la_personagem_correndo_1:
                la Personagem_Correndo_16_24_1
                j apagarPersonagemPuloDireita
            la_personagem_correndo_2:
                la Personagem_Correndo_16_24_2
                j apagarPersonagemPuloDireita
            la_personagem_correndo_3:
                la Personagem_Correndo_16_24_3
                j apagarPersonagemPuloDireita
            la_personagem_correndo_4:
                la Personagem_Correndo_16_24_4
                j apagarPersonagemPuloDireita
            la_personagem_correndo_5:
                la Personagem_Correndo_16_24_5
                j apagarPersonagemPuloDireita
            la_personagem_pulando_1:
                la Personagem_Pulando_14_24_1Frame
                j apagarPersonagemPuloDireita
            la_personagem_pulando_2:
                la Personagem_Pulando_14_24_2Frame
                j apagarPersonagemPuloDireita
            
            apagarPersonagemPuloDireita:
                jal ra ApagaPersonagem
            
        # fim do apagar
        li t0 16 # primeiro estado efetivo do pulo diagonal
        add t0 s0 t0
        slli t0, s0, 2 # word = 4 bytes
        addi t0, t0, -4
        la t1 vetorDeslocamentoPuloDiagonal
        add t0 t0 t1

        # movimentacao do personagem em y
        lw t0, 0(t0) # t0 = movimentacao do personagem em y
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual + movimentacao determinada
        sw t2, 0(t1)

        # movimentacao do personagem em x
        lw t0, 0(t0) # t0 = movimentacao do personagem em y
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual + movimentacao determinada
        sw t2, 0(t1)
        addi s0, s0, 1
        li t3, 10
        rem s0, s0, t3 # se passar do nono estado, zerar
        
        
		
    fimPuloDireita:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0