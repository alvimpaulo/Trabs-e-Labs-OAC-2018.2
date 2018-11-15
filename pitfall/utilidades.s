.text
## a0 = x_0; a1 = y_0; a2 = x_1; a3 = y_1;
DrawQuadrado: nop
	li t0 INIT_MEMORIA_VIDEO
	li t1 320
	sub t2 a2 a0
	sub t3 t1 t2
	li t4 0
	mul t5 a1 t1 #ini
	add t5 t5 a0 #ini
	add t5 t5 t0 #ini
	mul t6 a3 t1 #fim
	add t6 t6 a2 #fim
	add t6 t6 t0 #fim
	li a0 0xAA
	loop_cria_quadrado_linha_DrawQuadrado: nop
		sb a0 0(t5)
		if_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado: blt t4 t2 else_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado
			li t4 0
			add t5 t5 t3
			bne t5 t6 loop_cria_quadrado_linha_DrawQuadrado
		else_vai_proxima_linha_loop_cria_quadrado_linha_DrawQuadrado: nop
		addi t5 t5 1 
		addi t4 t4 1 
		bne t5 t6 loop_cria_quadrado_linha_DrawQuadrado
	end_loop_cria_quadrado_linha_DrawQuadrado:
	sb a0 0(t5)
FimDrawQuadrado: jalr x0 ra 0

## Retorna true se (x, y) está dentro do quadrado ((x_0, y_0), (x_1, y_1)) e false caso contrário
## a0 = x_0; a1 = y_0; a2 = x_1; a3 = y_1; a4 = x; a5 y
ColisaoObj:
	#t0 = a0 < a4
	slt t0 a0 a4
	#t1 = a2 > a4
	slt t1 a4 a2
	#t0 &= t1
	and t0 t0 t1
	#t1 = a1 > a5
	slt t1 a5 a1
	#t0 &= t1
	and t0 t0 t1
	#t1 = a3 < a5
	slt t1 a3 a5
	#t0 &= t1
	and a0 t0 t1
FimColisaoObj: jalr x0 ra 0

LeTeclaDoTeclado:	nop
	li t1 INIT_MEMORIA_TECLADO_ESTA_ATIVO
	lw t0 ADD_MEMORIA_TECLADO_ESTA_ATIVO(t1)
	andi t0 t0 MASK_MEMORIA_TECLADO
  if_tem_tecla_apertada_LeTeclaDoTeclado: beq t0 x0 FimLeTeclaDoTeclado
  	lw a0, ADD_MEMORIA_TECLADO_LE(t1)
	else_tem_tecla_apertada_LeTeclaDoTeclado:
FimLeTeclaDoTeclado: jalr x0 ra 0
