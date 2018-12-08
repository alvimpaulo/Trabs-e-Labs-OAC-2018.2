.text
    incioPuloDireita: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 14
        ble s0, t0, fimPuloDireita # s0 fora da faixa para pulo para a direita
        li t0 25
        bge s0 t0 fimPuloDireita # se s0 nao for um estado do pulo direita (>= 20) 
            
        # fim do apagar
        li t0 15
        beq s0 t0 fimMovimentacaoPuloDireita # se for o primeiro estado do pulo,  so apaga a sprite

        jal ra ApagaPersonagem

        li t0 16 # primeiro estado efetivo do pulo diagonal
        sub t0 s0 t0
        slli t0, t0, 2 # t0 = (s0 - 16) * 2
        la t1 vetorDeslocamentoPuloDiagonal
        add t0 t0 t1

        # movimentacao do personagem em y
        lw t0, 0(t0) # t0 = movimentacao do personagem em y
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual em y + movimentacao determinada
        sw t2, 0(t1)

        # movimentacao do personagem em x
        li t0 VELOCIDADE_DOS_PERSONAGEM # sempre se move vel em x
        la t1, posicaoPersonagemX
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual em x + vel
        sw t2, 0(t1)
        
        fimMovimentacaoPuloDireita:
        addi s0, s0, 1
        li t3, 25
        rem s0, s0, t3 # se passar do decimo nono estado, zerar
        
        
		
    fimPuloDireita:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0