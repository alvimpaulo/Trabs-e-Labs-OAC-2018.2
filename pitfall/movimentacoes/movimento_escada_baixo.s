# 50 >= s0 >= 60

.text
    incioEscadaBaixo: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)

        # movimentacao do personagem em y
        li t0 5 # desce 5 pixels para cada passo
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual em y + movimentacao determinada
        sw t2, 0(t1)
        
        fimMovimentacaoEscadaBaixo:
        li t3, 50
        rem s0, s0, t3 # se chegar na base da escada, zerar
        
        
		
    fimEscadaBaixo:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0