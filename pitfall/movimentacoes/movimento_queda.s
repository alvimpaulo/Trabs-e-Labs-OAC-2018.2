# 61 >= s0 >= 70

.text
    incioQueda: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
		
        li t0 60
        ble s0, t0, fimQueda # se s0 fora da faixa
        li t0 71
        bge s0 t0 fimQueda # se s0 fora da faixa
        la t0 ApagaPersonagem
	    jalr ra t0 0

        
        li t0, 2 # t0 = movimentacao do personagem em y (2 por ciclo)
        lw t1, posicaoPersonagemY
        add t2, t1, t0 # t2 = posicao atual + movimentacao determinada
        la t1 posicaoPersonagemY
        sw t2, 0(t1)
        addi s0, s0, 1
        li t3, 70
        rem s0, s0, t3 # se passar do 69, zerar
        
        
		
    fimQueda:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0