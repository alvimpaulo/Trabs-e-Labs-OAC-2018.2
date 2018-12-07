.text
    incioPuloVertical: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        beq s0, zero, fimPuloVertical #se s0 estiver zerado, pulo terminou
        li t0 10
        bge s0 t0 fimPuloVertical # se s0 nao for um estado do pulo vertical (>= 10) 
        la a0 Personagem_Parado_10_24_1_Frame
        jal ra ApagaPersonagem
        slli t0, s0, 2 # word = 4 bytes
        addi t0, t0, -4
        la t1 vetorDeslocamentoPulo
        add t0 t0 t1
        lw t0, 0(t0) # t0 = movimentacao do personagem em y
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual + movimentacao determinada
        sw t2, 0(t1)
        addi s0, s0, 1
        li t3, 10
        rem s0, s0, t3 # se passar do nono estado, zerar
        
        
		
    fimPuloVertical:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0

inicioPuloDiagonalDireita:
    # salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 9
        ble s0, t0, fimPuloDiagonalDireita # se s0 for menor que os estados pertencentes ao pulo
        
        # bge s0 t0 fimPuloDiagonalDireita # se s0 nao for um estado do pulo (>= 10) 
        
        # checar qual sprite apagar
        li t0 0
        beq s0 t0 puloVeioDeParado

        puloVeioDeParado:
        la a0 Personagem_Parado_10_24_1_Frame
        jal ra ApagaPersonagem

        # fim da checagem
        
        
        
		
    fimPuloDiagonalDireita:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0