# #################################################
# 0     1 word = ponteiro superior esquerda
# 4     1 word = ponteiro interior esquerda
# 8     1 word = ponteiro superior direita
# 12    1 word = ponteiro inferior direita
# 16    1 word = ponteiro pro cipo
# 20    1 word = ponteiro para o lago ou jacarés
# 24    1 word = número de troncos
# 28    1 word = ponteiro para troncos/cobras/fogueiras/tesouros
# 32    1 word = tipo basico de chão/escada/tojolo
# 36    1 word = escorpiao
# 40    1 word = parede
# 44    1 word = tem escada
# 48    1 word = buraco
# #################################################
.data
vectorFases: .space 11220

.text

InitFases:
    la t0 vectorFases
# init fase 1
    addi t1 t0 468 # ponteiro da fase 10
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 2
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # li t1 1
    # sw t1 24(t0) # número de troncos

    la t1 InitTroncoUmParado
    sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase1
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # sw x0 36(t0) # escorpiao

    # sw x0 40(t0) # parede

    li t1 1
    sw t1 44(t0)

    # sw x0 48(t0)
# fim fase 1
    addi t0 t0 52
# init fase 2
    addi t1 t0 52 # ponteiro da fase 1
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 3
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # li t1 2
    # sw t1 24(t0) # número de troncos

    # la t1 InitTroncoMexendo
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase2
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # sw x0 36(t0) # escorpiao

    # sw x0 40(t0) # parede
    
    li t1 1
    sw t1 44(t0)
    
    li t1 1
    sw t1 48(t0)
# fim fase 2
    addi t0 t0 52
# init fase 3
    addi t1 t0 52 # ponteiro da fase 2
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 4
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # la t1 InitLagoEstatico
    # sw t1 20(t0) # ponteiro para o lago ou jacarés

    # li t1 2
    # sw t1 24(t0) # número de troncos

    # la t1 InitTroncoMexendo
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase3
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 3
    addi t0 t0 52
# init fase 4
    addi t1 t0 52 # ponteiro da fase 3
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 5
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # la t1 InitJacare
    # sw t1 20(t0) # ponteiro para o lago ou jacarés

    # sw x0 24(t0) # número de troncos

    # sw x0 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase4
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 4
    addi t0 t0 52
# init fase 5
    addi t1 t0 52 # ponteiro da fase 4
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 6
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # li t1 3
    # sw t1 24(t0) # número de troncos

    # la t1 InitTroncoMexendo
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase5
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # sw x0 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    li t1 1
    sw t1 44(t0)
    
    li t1 1
    sw t1 48(t0)
# fim fase 5
    addi t0 t0 52
# init fase 6
    addi t1 t0 -52 # ponteiro da fase 5
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 7
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # la t1 InitCipo
    # sw t1 16(t0) # ponteiro pro cipo

    # la t1 InitBuraco
    # sw t1 20(t0) # ponteiro para o lago ou jacarés

    # sw x0 24(t0) # número de troncos

    # sw x0 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase6
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # esfcorpiao
    
    # sw x0 40(t0) # parede
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 6
    addi t0 t0 52
# init fase 7
    addi t1 t0 -52 # ponteiro da fase 6
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 8
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # la t1 InitBuracoMexendo
    # sw t1 20(t0) # ponteiro para o lago ou jacarés

    # sw x0 24(t0) # número de troncos

    # la t1 InitTesouroGold
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase7
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 7
    addi t0 t0 52
# init fase 8
    addi t1 t0 -52 # ponteiro da fase 7
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 9
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # la t1 InitCipo
    # sw t1 16(t0) # ponteiro pro cipo

    # la t1 InitJacare
    # sw t1 20(t0) # ponteiro para o lago ou jacarés

    # sw x0 24(t0) # número de troncos

    # sw x0 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase8
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 8
    addi t0 t0 52
# init fase 9
    addi t1 t0 -52 # ponteiro da fase 8
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 52 # ponteiro da fase 10
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # sw x0 24(t0) # número de troncos

    # sw x0 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase9
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # sw x0 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede
    
    li t1 1
    sw t1 44(t0)

    # sw x0 48(t0)
# fim fase 9
    addi t0 t0 52
# init fase 10
    addi t1 t0 -52 # ponteiro da fase 8
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 -468 # ponteiro da fase 10
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # li t1 1
    # sw t1 24(t0) # número de troncos

    # la t1 InitTroncoMexendo
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase10
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # li t1 InitEscorpiao
    # sw t1 36(t0) # escorpiao
    
    # sw x0 40(t0) # parede)
    
    # sw x0 44(t0)

    # sw x0 48(t0)
# fim fase 10
FimInitFases: jalr x0 ra 0

InitTroncoUmParado:
    addi sp sp -12
    sw ra 0(sp)
    sw t0 4(sp)
    sw t1 8(sp)
    
    li a0 257
    li a1 144
    li a2 271
    li a3 261
    la t0 posicaoPersonagemX
    lw a4 0(t0)
    lw a5 4(t0)
    addi a5 a5 24
    jal ra ColisaoObj
    mv t2 a0
    
    li a0 257
    addi a4 a4 12
    jal ra ColisaoObj
    
    or a0 a0 t2

    beq a0 x0 FimInitTroncoUmParado
        atualizar_pontuacao(-12)
 FimInitTroncoUmParado:
    lw t1 8(sp) 
    lw t0 4(sp)
    lw ra 0(sp)
    addi sp sp 12
    jalr x0 ra 0