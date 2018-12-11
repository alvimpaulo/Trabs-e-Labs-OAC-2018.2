### Pontuacao do jogo ###

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

.include "../macros2.s"
.include "../macro.s"

.data
pontos: 		.word 0
pontos_zero: 	.string "0000"
.text
MAIN: M_SetEcall(exceptionHandling)
    inicializar_pontuacao(2000)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall

    atualizar_pontuacao(5000)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall
    
    atualizar_pontuacao(6000)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall
    
    atualizar_pontuacao(-12500)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall

    atualizar_pontuacao(-3885)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall
    
    atualizar_pontuacao(-7555)
    jal imprimir_pontuacao
    li a7, 132
    li a0, 2000
    M_Ecall
    
    li a7, 10
    M_Ecall
imprimir_pontuacao: li a7, 101
    li a0, 11111111
    li a1, 130
    li a2, 226
    li a3, 0x0000
    M_Ecall                             # apagar pontuação

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
    bge t1, t2, imprimir_pontuacao_c5		# 1 < pontos > 10 ? imprimir_caso5
    
    li a7, 104                          # caso pontos < 0
    la a0, pontos_zero           
    li a1, 142                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c1: li a7, 101          # caso pontos > 10000
    mv a0, t1            
    li a1, 134                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c2: li a7, 101          # caso pontos > 1000
    mv a0, t1            
    li a1, 142                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c3: li a7, 101          # caso pontos > 100
    mv a0, t1            
    li a1, 150                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
    M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c4: li a7, 101          # caso pontos > 10
    mv a0, t1            
    li a1, 158                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
	M_Ecall
    j imprimir_pontuacao_exit

imprimir_pontuacao_c5: li a7, 101          # caso  0 < pontos > 10
    mv a0, t1            
    li a1, 164                          # coluna
    li a2, 226                          # linha
    li a3, 0x00FF
    M_Ecall
    
imprimir_pontuacao_exit: ret

.include "../Utilidades_alvim.s"
.include "../SYSTEMv12.s"
