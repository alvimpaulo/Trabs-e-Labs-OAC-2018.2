.data
BURACO: .word 0, 10, 20, 30, 40, 50, 60 
CORES: 	.word 0xA3A3A3A3, 0xF0F0F0F0, 0x24242424, 0x11111111, 0xB8B8B8B8, 0xA3A3A3A3, 0xAAAAAAAA
.text
.include "macro.s"


la s0 BURACO # carega o & do BURACO
la s6 CORES # carrga o ENdereco da cor
li s1 0  # estado do buravo
li s2 -4 # valor pra ser add/sub endere�o
li s3 -1  # valor add/sub estado
li s4 6 #  final do estado
li s5 -1 # registrador -1
LOOP: bgt s1 s4 LOOP2 # se for == ao final do estado
	beqz s1 LOOP1
	li t4 160
	lw t3 0(s0)
	li a1 40 # y canto suderior esquerdo
	sub a0 t4 t3 # a esquerda do centro da tela
	li a3 80 # y canto inferior direito
	add a2 t4 t3 # a direita do centro da tela
	lw a4 0(s6) # cor do treco
	
	la t0 DrawQuadrado
	jalr ra t0 0
	
	
	add s6 s6 s2 # soma  endere�o CORES
	add s1 s1 s3 # soma estado 
	add s0 s0 s2 # Soma endere�o BURACO
	
	li a7 32
	li a0 100
	ecall
	
	
	j LOOP
LOOP1:
	mul s2 s2 s5
	mul s3 s3 s5
	add s1 s1 s3
	add s0 s0 s2
j LOOP
LOOP2:
	mul s2 s2 s5
	mul s3 s3 s5
	add s1 s1 s3
	add s0 s0 s2
j LOOP
.include "utilidades.s"
