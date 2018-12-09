# 50 >= s0 >= 60

.data
	.include "../Sprites\source\Personagem_Escalando_10_26_1Frame.s"
.text
    incioEscadaCima: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)

        # movimentacao do personagem em y
        li t0 -5 # sobe 5 pixels para cada passo
        la t1, posicaoPersonagemY
        lw t2, 0(t1)
        add t2, t2, t0 # t2 = posicao atual em y + movimentacao determinada
        sw t2, 0(t1)
        
        fimMovimentacaoEscadaCima:
        li t3, 61
        rem s0, s0, t3 # se passar do septuagesimo estado, zerar
        
        
		
    fimEscadaCima:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0