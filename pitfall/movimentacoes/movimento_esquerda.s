# 25 >= s0 > 29  

.data
    .include "../Sprites\source\Personagem_Correndo_16_24_1_Espelhado.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_2_Espelhado.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_3_Espelhado.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_4_Espelhado.s"
	.include "../Sprites\source\Personagem_Correndo_16_24_5_Espelhado.s"

.text 
andarEsquerda:
    # salva stack
    addi sp sp -4 
    sw ra 0(sp)
    
    li t0 24 # estado fora abaixo do intervalo do movimento
    ble s0, t0 , fimAndarEsquerda # s0 nao pertence ao movimento a esquerda
    li t0 30 # estado fora acima do intervalo do movimento
    bge s0 t0 fimAndarEsquerda # s0 nao pertence ao movimento a esquerda
    
    # checagem do ultimo movimento
    li t0 25
    beq s0 t0 frame1_esquerda # se for o primeiro movimento para a esquerda
    li t0 'a'
    bne s4 t0 frame1_esquerda # se nao estiver se movendo para a esquerda
    li t0 26
    beq s0 t0 frame2_esquerda # se for o segundo movimento para a esquerda
    li t0 27
    beq s0 t0 frame3_esquerda # se for o terceiro movimento para a esquerda
    li t0 28
    beq s0 t0 frame4_esquerda # se for o quarto  movimento para a esquerda
    li t0 29
    beq s0 t0 frame5_esquerda # se for o quinto movimento para a esquerda
    # fim checagem do ultimo movimento

    frame1_esquerda:
        la a0 Personagem_Correndo_16_24_1_Espelhado
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoEsquerda
    
    frame2_esquerda:

        la a0 Personagem_Correndo_16_24_2_Espelhado
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoEsquerda

    frame3_esquerda:

        la a0 Personagem_Correndo_16_24_3_Espelhado
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoEsquerda

    frame4_esquerda:

    la a0 Personagem_Correndo_16_24_4_Espelhado
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoEsquerda

    frame5_esquerda:

        la a0 Personagem_Correndo_16_24_5_Espelhado
        # move o personagem
        lw t0 posicaoPersonagemX
        addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
        sw t0 posicaoPersonagemX, t1
        
        j fimMovimentacaoEsquerda
    
    fimMovimentacaoEsquerda:
    addi s0, s0, 1
    li t3, 30
    rem s0, s0, t3 # se passar do vigesimo nono, zerar estado
    beq s0 zero pararPersonagemParaAEsquerda
    j fimAndarEsquerda

    pararPersonagemParaAEsquerda:
    li s0 -1

    fimAndarEsquerda:
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0
