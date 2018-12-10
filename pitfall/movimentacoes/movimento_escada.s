# 50 >= s0 >= 60
# a0 = Tecla pressioanda
.text
    incioEscada: nop
		# salva stack
		addi sp sp -4 
		sw ra 0(sp)
        
        li t0 'w'
        beq a0 t0 andar_para_cima_escada
        andar_para_baixo_escada:
            addi s0 s0 -1
            j checagem_estado_escada
            
        andar_para_cima_escada:
            addi s0 s0 1
        
        checagem_estado_escada:
        # checagem de estado
        li t0 50
        beq s0 t0 estado_50
        li t0 51
        beq s0 t0 estado_51
        li t0 52
        beq s0 t0 estado_52
        li t0 53
        beq s0 t0 estado_53
        li t0 54
        beq s0 t0 estado_54
        li t0 55
        beq s0 t0 estado_55
        li t0 56
        beq s0 t0 estado_56
        li t0 57
        beq s0 t0 estado_57
        li t0 58
        beq s0 t0 estado_58
        li t0 59
        beq s0 t0 estado_59
        li t0 60
        beq s0 t0 estado_60
        # fim da checagem

        estado_50:
            li t0 194
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_51:
            li t0 189
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_52:
            li t0 184
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_53:
            li t0 179
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_54:
            li t0 174
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_55:
            li t0 169
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_56:
            li t0 164
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_57:
            li t0 159
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_58:
            li t0 154
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_59:
            li t0 149
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima
        estado_60:
            li t0 149
            sw t0 posicaoPersonagemY, t1
            j fimMovimentacaoEscadaCima


        fimMovimentacaoEscadaCima:
        li t0 156
        sw t0 posicaoPersonagemX, t1 # coloca o personagem na posicao x certa
        li t0, 60
        beq s0 t0 personagem_em_cima_escada
        li t0 50
        beq s0 t0 personagem_em_baixo_escada
        j fimEscada
        personagem_em_cima_escada:
        li s0 59
        j fimEscada
        personagem_em_baixo_escada:
        li s0 0
        j fimEscada 
        
        
		
    fimEscada:    
    # carrega stack
    lw ra 0(sp)
    addi sp sp 4
    jalr x0 ra 0