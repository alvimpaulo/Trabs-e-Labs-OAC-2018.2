### Pontuacao do jogo ###
# pontos (.word) -> Armazena a qtd de pontos do jogador

.data
pontos:         .word 0
pontos_zero1: 	.string "0"
pontos_zero2: 	.string "00"
pontos_zero3: 	.string "000"
pontos_zero4: 	.string "0000"
pontos_zero5: 	.string "00000"
.text
imprimir_pontuacao:
    la t0, pontos
    lw t1, 0(t0)                        # pontos
    li t2, 10000                        # 130 X
    bge t1, t2, imprimir_pontuacao_c1      # pontos > 10000 ? imprimir_caso1
    li t2, 1000                         # 138 X                
    bge t1, t2, imprimir_pontuacao_c2      # pontos > 1000  ? imprimir_caso2
    li t2, 100                          # 146 X
    bge t1, t2, imprimir_pontuacao_c3      # pontos > 100   ? imprimir_caso3
    li t2, 10                           # 154 X
    bge t1, t2, imprimir_pontuacao_c4      # pontos > 10    ? imprimir_caso4
    li t2, 1 
    bge t1, t2, imprimir_pontuacao_c5		# 1 < pontos < 10 ? imprimir_caso5
    
    li a7, 104          
    la a0, pontos_zero4          
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x0000
    M_Ecall 

    li a7, 104                          # caso pontos =< 0
    la a0, pontos_zero1           
    li a1, 164                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c1: li a7, 101          # caso pontos > 10000
    mv a0, t1            
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c2:  li a7, 104          
    la a0, pontos_zero1           
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x0000
    M_Ecall

    li a7, 101          # caso pontos > 1000
    mv a0, t1            
    li a1, 142                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c3:  li a7, 104          
    la a0, pontos_zero2          
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x0000
    M_Ecall
    
    li a7, 101          # caso pontos > 100
    mv a0, t1            
    li a1, 150                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c4:  li a7, 104          
    la a0, pontos_zero3          
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x0000
    M_Ecall
    
    li a7, 101          # caso pontos > 10
    mv a0, t1            
    li a1, 158                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
	M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c5:  li a7, 104          
    la a0, pontos_zero4          
    li a1, 134                          # coluna
    li a2, 228                          # linha
    li a3, 0x0000
    M_Ecall 
    
    li a7, 101          # caso  0 < pontos < 10
    mv a0, t1            
    li a1, 164                          # coluna
    li a2, 228                          # linha
    li a3, 0x00FF
    M_Ecall
    
imprimir_pontuacao_exit: ret
