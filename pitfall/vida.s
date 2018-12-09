######### IMPRIMI VIDA #########
# a0 -> endereço do bitmap
# a1 -> Y inicial
# a2 -> X inicial
# VIDAS -> (word) para armazenar a qtd de vida restante


# .include "../macros2.s"
# .include "../macro.s"
.data
	# .include "../Sprites/source/Coracao_10_8_1Frame.s"
	VIDAS: .word 0
	
.text
# MAIN: inicializar_vida(3)
#	li a0, 0XFF000000
#	li a1, 226
#	li a2, 280
#	jal imprimir_vida

#	li a7, 10
#	ecall
imprimir_vida: 	addi sp, sp, -32
	sw s0, 0(sp)					# liberando s0
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	sw a4, 16(sp)
	sw a5, 20(sp)
	sw a0, 24(sp)
	sw ra, 28(sp)
	la t4, VIDAS	    			# qtd de vida	
	lw s0, 0(t4)
	mv a4, a1						# a1 vai ser utilizado para end. do sprite
	mv a5, a2
	
imprimir_loop:	beq s0, x0, imprimir_exit		# vidas = 0 ? exit:printa
	li t2, 320		    			# offset (comprimeto da tela)
	lw a0, 24(sp)     				# end. do bitmap
	mul t3, a4, t2					# encontrado a linha (Y * 320)				
	add t3, t3, a5					# encotrado a coluna
	add a0, a0, t3					# somando ao end. do bitmap
	la a1, Coracao_10_8_1Frame		# end. do sprite 
	addi a1, a1, 8					
	li a2, 10						# tamanho coluna
	li a3, 8					    # tamanho linha
	jal printSprite
	
	addi s0, s0, -1					# decrementa um do contador
	addi a5, a5, 12					# end. do prox. coracao
	j imprimir_loop
	
imprimir_exit: lw s0, 0(sp)
	lw a1, 4(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	lw a4, 16(sp)
	lw a5, 20(sp)
	lw a0, 24(sp)
	lw ra, 28(sp)
	addi sp, sp, 32
	ret
# .include "../Utilidades_alvim.s"
