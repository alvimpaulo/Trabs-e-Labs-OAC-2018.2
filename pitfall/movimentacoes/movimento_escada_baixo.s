# 50 >= s0 >= 60

.text
    incioEscada: nop
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
        li t0, 50
        beq s0 t0 if_chegou_no_chao_da_escada
        j fimEscadaBaixo
        if_chegou_no_chao_da_escada: 
            li s0 0

        
        
		
    fimEscadaBaixo:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0