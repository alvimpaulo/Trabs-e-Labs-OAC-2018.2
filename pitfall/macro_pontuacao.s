.macro inicializar_pontuacao(%qtd)
    li t0, %qtd
    la t1, pontos
    sw t0, 0(t1)            # Salvando o valor inicial de pontos
.end_macro

.macro atualizar_pontuacao(%qtd)
    li t0, %qtd
    la t1, pontos
    lw t2, 0(t1)            # Carregando pontos atuais
    add t2, t2, t0          # Atualizando
    blt t2, x0, atualizar_pontuacao_zero 	# Caso pontos < 0
    sw t2, 0(t1)            # Salvando em pontos
    j atualizar_pontuacao_exit
    
atualizar_pontuacao_zero: sw x0, 0(t1)            # Salvando em pontos
atualizar_pontuacao_exit: nop
.end_macro

.macro atualizar_pontuacao_reg(%qtd)
    la t1, pontos
    lw t2, 0(t1)            # Carregando pontos atuais
    add t2, t2, %qtd          # Atualizando
    blt t2, x0, atualizar_pontuacao_zero 	# Caso pontos < 0
    sw t2, 0(t1)            # Salvando em pontos
    j atualizar_pontuacao_exit
    
atualizar_pontuacao_zero: sw x0, 0(t1)            # Salvando em pontos
atualizar_pontuacao_exit: nop
.end_macro