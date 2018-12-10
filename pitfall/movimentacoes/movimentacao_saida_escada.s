# 70 >= s0 >= 79

.text
    incioSaidaEscada: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 69
        ble s0, t0, fimSaidaEscada # s0 fora da faixa para saida da escada
        li t0 80
        bge s0 t0 fimSaidaEscada # se s0 nao for um estado do pulo direita (>= 20) 

        la t0 ApagaPersonagem
	    jalr ra t0 0

        li t0 70 # primeiro estado efetivo do pulo diagonal
        sub t0 s0 t0
        slli t0, t0, 2 # t0 = (s0 - 70) * 4
        la t1 vetorDeslocamentoPuloVerticalEscada
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
        
        fimMovimentacaoSaidaEscada:
        addi s0, s0, 1
        li t3, 80
        rem s0, s0, t3 # se passar do decimo nono estado, zerar
        
        
		
    fimSaidaEscada:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0