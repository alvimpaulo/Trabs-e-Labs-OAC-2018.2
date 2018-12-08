######## DEFINES #########
# Defini s11 como registrador global do tempo de jogo (ms)
.eqv STOPWATCH 0xFF200510
.eqv VIDEO 0xFF000000

.include "macros2.s"


.data
FLOAT:      .float 3.14159265659
msg1:       .string "Sou lindu :D"
TEMPO_SIST: .word  0
RELOGIO:    .word  1200000 # ms (20 min) - Tempo inicial

.text
    M_SetEcall(exceptionHandling)
	
	jal CLS
    jal RELOGIO_INICIO

    li a7, 10
    M_Ecall
    
# printar 20 min
RELOGIO_INICIO:  li a7, 130             # tempo do sistema, salvo em a0
	M_Ecall
    la t0, TEMPO_SIST                   # salva em TEMP_SIST
    sw a0, 0(t0)
    la t0, RELOGIO
    lw s11, 0(t0)						# carregando RELOGIO

RELOGIO_CHECK:    li a7, 130
	M_Ecall
    la t0, TEMPO_SIST
    lw t1, 0(t0)                  # t1 <= TEMP_SIST
    sub t2, a0, t1                # t2 <= tempo atual - TEMP_SIST
    li t4, 1000
    slt t4, t4, t2				  # t4 <= (1000 ms < tempo_passado)
    beq t4, x0, RELOGIO_PRINTA      
    add t3, t1, t2                # t3 <= tempo atualizado
    sw t3, 0(t0)                  # TEMP_SIST <= t3
    addi s11, s11, -1000          # t3 (Relogio atualizado) 

RELOGIO_PRINTA: li t1, 60000				  # de ms para min
	li a7, 101
    div t2, s11, t1               # t2 <= RELOGIO/60000
    li t0, 10
    slt t3, t2, t0				  # relogio < 10 min
    bne t3, x0, MINUTOS_CASO1
    mv a0, t2                     # valor 
    li a1, 140                    # coluna
    li a2, 120                    # linha
    li a3, 0x00FF                 # back-front
    M_Ecall
	j DOIS_PONTOS
	
MINUTOS_CASO1: li a0, 0          # valor 
    li a1, 140                    # coluna
    li a2, 120                    # linha
    li a3, 0x00FF                 # back-front
    M_Ecall
    
	mv a0, t2                     # valor 
    li a1, 148                    # coluna
    li a2, 120                    # linha
    li a3, 0x00FF                 # back-front
    M_Ecall

DOIS_PONTOS: li a7, 111                    # printar ':'
    li a0, ':'
    li a1, 156
    li a2, 120
    li a3, 0X00FF
    M_Ecall
    
    li a7, 101
    li t1, 60000				  # de ms para s
    rem t2, s11, t1               # t2 <= RELOGIO/1000
    li t1, 10000
    slt t3, t2, t1				  # t2 < 10 ? 1:0 
    bne t3, x0, SEGUNDOS_CASO1
    li t1, 1000
    div t2, t2, t1				  # ajustes..
    mv a0, t2                     # valor 
    li a1, 164                    # coluna
    li a2, 120                    # linha
    li a3, 0x00FF                 # back-front
    M_Ecall
	
	j RELOGIO_EXIT
# Se a parte dos segundos estiver menor que 10
SEGUNDOS_CASO1: li a7, 101
	li a0, 0
	li a1, 164
	li a2, 120
	li a3, 0x00FF
	M_Ecall
	
	li a7, 101
	li t1, 1000
	div t2, t2, t1				  # ajustes../t2 = tempo em s
	mv a0, t2
	li a1, 172
	li a2, 120
	li a3, 0x00FF
	M_Ecall

RELOGIO_EXIT: bne s11, x0, RELOGIO_CHECK
    li a7, 104
    la a0, msg1
    li a1, 100
    li a2, 2
    li a3, 0x0038
    M_Ecall
    ret


# CLS Clear Screen Randomico (preto atualmente)
CLS:	li a7,141
	# M_Ecall
	li a0,0x00
	li a7,148
	M_Ecall
	ret
	
.include "SYSTEMv12.s"
