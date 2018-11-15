.data
posicaoPersonagemX: .space 4
posicaoPersonagemY: .space 4
vectorAditionalParaPulo: .half -2, -1, -1, -1, 0, 0, 0, 1, 1, 1, 2 
numElementosNoVetor: .half 11
estadoDoPulo: .word 0

.text

# a0 = tecla precionada
MovePersonagem:
	la s1 vectorAditionalParaPulo
	li t0 ' '
	lw t1 48(s1)
	
	sub t0 t0 a0
	snez t2 t1
	snez t0 t0
	if_tecla_de_pular_foi_apertada_MovePersonagem: bne t2 t0 else_tecla_de_pular_foi_apertada_MovePersonagem
		addi t1 t1 1
		li t0 11
		rem t1 t1 t0
		sw t1 48(s1)
		
		beq t1 x0 FimMovePersonagem
		
		addi t1 t1 -1
		slli t1 t1 2
		add t1 t1 s1
		lw t0 -4(s1)
		lh t2 0(t1)
		add t0 t2 t0
		sw t0 -4(s1)
		
		jalr x0 ra 0
	else_tecla_de_pular_foi_apertada_MovePersonagem: nop
		li t0 'a'
		if_tecla_de_a_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_de_a_foi_apertada_MovePersonagem
			lw t0 -8(s1)
			addi t0 t0 -VELOCIDADE_DOS_PERSONAGEM
			sw t0 -8(s1)
			jalr x0 ra 0
		else_tecla_de_a_foi_apertada_MovePersonagem: nop
			li t0 'd'	 
			if_tecla_de_d_foi_apertada_MovePersonagem: bne a0 t0 else_tecla_de_d_foi_apertada_MovePersonagem	
				lw t0 -8(s1)
				addi t0 t0 VELOCIDADE_DOS_PERSONAGEM
				sw t0 -8(s1)
				jalr x0 ra 0
			else_tecla_de_d_foi_apertada_MovePersonagem: nop
	
FimMovePersonagem: jalr x0 ra 0

DesenhaPersonagem:
	addi sp sp -4
	sw ra 0(sp)
	la t0 posicaoPersonagemX
	lw a0 0(t0)
	addi a2 a0 LARGURA_PERSONAGEM
	lw a1 4(t0)
	addi a3 a1 ALTURA_PERSONAGEM
	jal ra DrawQuadrado
	lw ra 0(sp)
	addi sp sp 4
FimDesenhaPersonagem: jalr x0 ra 0
