.data
CORES_NORMAIS: .word 0x07,0x27,0x3F,0x20,0xAA,0xC3,0xC6
CORES_TROCADAS: .word 0xC6,0xC3,0x20,0xAA,0x3F,0x27,0x07
.text
	li s9 0
KEY: 	li t1 0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0 0(t1)			# Le bit de Controle Teclado
   	andi t0 t0,0x0001		# mascara o bit menos significativo
   	beq t0 zero LOOP		# não tem tecla pressionada então volta ao loop
   	lw zero 4(t1)
  	xori s9 s9 1
  	
  	beq s9 zero estado1
  	j estado2 
	ret

estado1: la s8 CORES_NORMAIS
	j main
estado2:
	la s8 CORES_TROCADAS
main:
	lw a1 0(s8)
	li a0 160
	jal DrawOctante
	lw a1 4(s8)
	li a0 150
	jal DrawOctante	
	lw a1 8(s8)	
	li a0 140
	jal DrawOctante
	lw a1 12(s8)
	li a0 130
	jal DrawOctante
	lw a1 16(s8)
	li a0 120
	jal DrawOctante
	lw a1 20(s8)	
	li a0 110
	jal DrawOctante
	lw a1 24(s8)
	li a0 100
	jal DrawOctante
	li a1 0x00
	li a0 90
	jal DrawOctante
	
	j KEY

DrawOctante:

	
	## a0 = raio do arco octante
	## a1 = cor
	addi sp sp -36
	sw s0  0(sp)
	sw s1  4(sp)
	sw s2  8(sp)
	sw s3  12(sp)
	sw s4  16(sp)
	sw s5  20(sp)
	sw s6  24(sp)
	sw s7  28(sp)
	sw ra  32(sp)
	
	mv a2 a1
	
	####
	## d = 1 - r
	li s1 1
	sub s1 s1 a0
	####
	
	####
	## de = 3
	li s2 3
	####
	
	####
	## dse = -2r+5
	li t0 5
	slli s3 a0 1
	sub s3 t0 s3
	####
	
	####
	## x = 0
	li s4 0
	####
	
	####
	## y = r
	mv s5 a0
	####
	
	####
	## y = r
	li s7 0
	####
	
	####
	## r = r 
	mv s6 a0
	####
	
	
	while_DrawOctante: bge s4 s5 fora_while_DrawOctante
		if_while_DrawOctante:  ble x0 s1 else_while_DrawOctante
			add s1 s1 s2
			addi s2 s2 2
			addi s3 s3 2
			j end_while_DrawOctante
		else_while_DrawOctante:
			add s1 s1 s3
			addi s2 s2 2
			addi s3 s3 4
			addi s5 s5 -1
			addi s7 s7 1
			j end_while_DrawOctante
		end_while_DrawOctante:
		
		## a0 = x pra desenhar e a1 = y para desenhar
		
		## primeiro arco  anda pra cima e direita
		li a0 160 # Vai para o centro x do círculo
		sub a0 a0 s6 # Vai Para a borda x inicial do círculo
		add a0 a0 s7 # Add quanto que essa posição vai andar para direita
		li a1 240 # Vai pra posição y inicial, base da tela
		sub a1 a1 s4 # Add quanto essa posição vai andar pra cima
		jal print
		
		## segundo arco anda pra baixo e esquerda
		li a0 160 # Coloca a posição x no centro x da tela
		sub a0 a0 s4 # Add quanto que essa posição vai andar para esquerda
		li a1 240 # Vai pra posição y inicial, base da tela
		sub a1 a1 s6 # Vai pra cima com o raio, em relação a base da tela
		add a1 a1 s7 # Add quanto essa posição vai andar pra baixo
		jal print
		
		## terceiro arco anda pra baixo e direita
		li a0 160 # Coloca a posição x no centro x da tela
		add a0 a0 s4 # Add quanto que essa posição vai andar para direita
		li a1 240 # Vai pra posição y inicial, base da tela
		sub a1 a1 s6 # Vai pra cima com o raio, em relação a base da tela
		add a1 a1 s7 # Add quanto essa posição vai andar pra baixo
		jal print
		
		## quarto arco anda pra cima e esquerda
		addi a0 s6 160 # Vai para direita r em relação ao centro x
		sub a0 a0 s7 # # Add quanto que essa posição vai andar para direita
		li a1 240  # Vai pra posição y inicial, base da tela
		sub a1 a1 s4 # Add quanto essa posição vai andar pra cima
		jal print
		
		addi s4 s4 1
		j while_DrawOctante
	fora_while_DrawOctante:
	
	
	lw s0  0(sp)
	lw s1  4(sp)
	lw s2  8(sp)
	lw s3  12(sp)
	lw s4  16(sp)
	lw s5  20(sp)
	lw s6  24(sp)
	lw s7  28(sp)
	lw ra  32(sp)
	addi sp sp 36
	
	ret
	
print:
	li t0 320
	mul t1 a1 t0
	add t2 t1 a0
	li t0 0xff000000
	add t2 t2 t0
	sb a2 0(t2)
	li t3 240
while_print:
	addi a1 a1 1
	bge a1 t3 fora_while_print
	li t0 320
	mul t1 a1 t0
	add t2 t1 a0
	li t0 0xff000000
	add t2 t2 t0
	sb a2 0(t2)
	j while_print
fora_while_print:
	ret
