######## DEFINES #########
# s11 -> registrador global do tempo de jogo (ms)
# a1 -> coluna
# a2 -> linha
# .include "macros2.s"
# .include "macro_relogio.s"

.data
# FLOAT:      .float 3.14159265659
TEMPO_SIST: .word  0
# relogio_linha:	  .word 226
# relogio_coluna:	  .word 4
# RELOGIO:    .word  1200000 # ms (20 min) - Tempo inicial

.text
	# M_SetEcall(exceptionHandling)
	# RELOGIO_INICIO(1200000)
	# li a1, 4
	# li a2, 226
# RELOGIO:    jal RELOGIO_LOOP
    # bne s11,x0,RELOGIO
    # jal EXIT 
RELOGIO_LOOP:	li a7, 130
	M_Ecall
    la t0, TEMPO_SIST
    lw t1, 0(t0)                  # t1 <= TEMP_SIST
    sub t2, a0, t1                # t2 <= tempo atual - TEMP_SIST
    li t4, 1000
    slt t4, t4, t2				  # t4 <= (1000 ms < tempo_passado)
    beq t4, x0, RELOGIO_PRINTA    # caso não tenha passado 1000 ms    
    add t3, t1, t2                # t3 <= tempo atualizado
    sw t3, 0(t0)                  # TEMP_SIST <= t3
    beq s11, x0, RELOGIO_PRINTA   # caso o relógio já tenha chegado em zero
    li t1, 1000
    div t4, t2, t1                # t4 em s (int) <= tempo decorrido / 1000
    mul t4, t4, t1                # t4 para ms
    sub s11, s11, t4              # t3 (Relogio atualizado) 

RELOGIO_PRINTA: li t1, 60000	  # de ms para min
	li a7, 101
    div t2, s11, t1               # t2 <= RELOGIO/60000
    li t0, 10
    slt t3, t2, t0				  # relogio < 10 min
    bne t3, x0, MINUTOS_CASO1
    mv a0, t2                     # valor 
    li a3, 0x00FF                 # back-front
    M_Ecall
    addi a1,a1,8				  # correção para o 2 pontos 
	j DOIS_PONTOS
	
MINUTOS_CASO1: li a0, 0           # valor 
    li a3, 0x00FF                 # back-front
    M_Ecall
    
	mv a0, t2                     # valor 
    addi a1, a1, 8                # coluna
    li a3, 0x00FF                 # back-front
    M_Ecall

DOIS_PONTOS: li a7, 111                    # printar ':'
    li a0, ':'
    addi a1, a1, 8
    li a3, 0X00FF
    M_Ecall
    
    li a7, 101                    # printar os segundos
    li t1, 60000				  # de ms para s
    rem t2, s11, t1               # t2 <= RELOGIO/1000
    li t1, 10000
    slt t3, t2, t1				  # t2 < 10 ? 1:0 
    bne t3, x0, SEGUNDOS_CASO1
    li t1, 1000
    div t2, t2, t1				  # ajustes..
    mv a0, t2                     # valor 
    addi a1, a1, 8
    li a3, 0x00FF                 # back-front
    M_Ecall
	
	j RELOGIO_EXIT
# Se a parte dos segundos estiver menor que 10
SEGUNDOS_CASO1: li a7, 101
	li a0, 0
    addi a1, a1, 8
	li a3, 0x00FF
	M_Ecall
	
	li a7, 101
	li t1, 1000
	div t2, t2, t1				  # ajustes../t2 = tempo em s
	mv a0, t2
    addi a1, a1, 8
	li a3, 0x00FF
	M_Ecall
	
RELOGIO_EXIT: ret
# EXIT:	li a7,10
    # M_Ecall
# .include "SYSTEMv12.s"
