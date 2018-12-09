# 10 >= s0 > 15  

.data
	.include "../Sprites\source\Personagem_Correndo_16_24_1.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_2.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_3.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_4.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_5.s"

.text 
andarDireita:
    # salva stack
    addi sp sp -4 
    sw ra 0(sp)
    
    li t0 9 # estado fora abaixo do intervalo do movimento
    ble s0, t0 , fimAndarDireita # s0 nao pertence ao movimento a direita
    li t0 15 # estado fora acima do intervalo do movimento
    bge s0 t0 fimAndarDireita # s0 nao pertence ao movimento a direita
    
    # checagem do ultimo movimento
    li t0 10
    beq s0 t0 frame1_direita # se for o primeiro movimento para a direita
    li t0 'd'
    bne s4 t0 frame1_direita # se nao estiver se movendo para a direita
    li t0 11
    beq s0 t0 frame2_direita # se for o segundo movimento para a direira
    li t0 12
    beq s0 t0 frame3_direita # se for o terceiro movimento para a direira
    li t0 13
    beq s0 t0 frame4_direita # se for o quarto  movimento para a direira
    li t0 14
    beq s0 t0 frame5_direita # se for o segundo movimento para a direira
    # fim checagem do ultimo movimento

    frame1_direita:
        la a0 Personagem_Correndo_16_24_1
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoDireita
    
    frame2_direita:

        la a0 Personagem_Correndo_16_24_2
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoDireita

    frame3_direita:

        la a0 Personagem_Correndo_16_24_3
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoDireita

    frame4_direita:

    la a0 Personagem_Correndo_16_24_4
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoDireita

    frame5_direita:

        la a0 Personagem_Correndo_16_24_5
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoDireita
    
    fimMovimentacaoDireita:
    addi s0, s0, 1
    li t3, 15
    rem s0, s0, t3 # se passar do decimo quarto, zerar estado
        

    fimAndarDireita:
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0
