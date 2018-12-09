.text
    incioPuloVerticalEsquerda: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 39
        ble s0, t0, fimPuloVerticalEsquerda # s0 abaixo do estado
        li t0 50
        bge s0 t0 fimPuloVerticalEsquerda # s0 acima da fronteira   
        jal ra ApagaPersonagem

        li t0 40 # primeiro estado efetivo do pulo vertical
        sub t0 s0 t0
        slli t0, t0, 2 # word = 4 bytes, estado do pulo
        la t1 vetorDeslocamentoPuloVertical
        add t0 t0 t1
        lw t0, 0(t0) # t0 = movimentacao do personagem em y
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual + movimentacao determinada
        sw t2, 0(t1)
        addi s0, s0, 1
        li t3, 49
        rem s0, s0, t3 # se passar do quadragesimo nono estado, zerar
        beq s0 zero pararPersonagemParaAEsquerdaPuloVertical
        j fimPuloVerticalEsquerda

        pararPersonagemParaAEsquerdaPuloVertical:
        li s0 -1
        
		
    fimPuloVerticalEsquerda:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0