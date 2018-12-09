# #################################################
# 1 word = ponteiro superior esquerda
# 1 word = ponteiro interior esquerda
# 1 word = ponteiro superior direita
# 1 word = ponteiro inferior direita
# 1 word = ponteiro pro cipo
# 1 word = ponteiro para o lago ou jacarés
# 1 word = número de troncos
# 1 word = ponteiro para troncos/cobras/fogueiras/tesouros
# 1 word = tipo basico de chão/escada/tojolo
# 1 word = escorpiao
# 1 word = parede
# #################################################
.data
vectorFases: .space 11220

.text

InitFases:
    la t0 vectorFases
# init fase 1
    addi t1 t0 396 # ponteiro da fase 10
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 2
    sw t1 8(t0)  # ponteiro superior direita
    sw t1 12(t0) # ponteiro inferior direita

    # sw x0 16(t0) # ponteiro pro cipo

    # sw x0 20(t0) # ponteiro para o lago ou jacarés

    # li t1 1
    # sw t1 24(t0) # número de troncos

    # la t1 InitTroncoParado
    # sw t1 28(t0) # ponteiro para troncos/cobras/fogueiras/tesouros
    
    la t1 fase1
    sw t1 32(t0) # tipo basico de chão/escada/tojolo

    # sw x0 36(t0) # escorpiao

    # sw x0 40(t0) # parede
# fim fase 1
    addi t0 t0 44
# init fase 2
    addi t1 t0 44 # ponteiro da fase 1
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 3
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
# fim fase 2
    addi t0 t0 44
# init fase 3
    addi t1 t0 44 # ponteiro da fase 2
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 4
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
# fim fase 3
    addi t0 t0 44
# init fase 4
    addi t1 t0 44 # ponteiro da fase 3
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 5
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
# fim fase 4
    addi t0 t0 44
# init fase 5
    addi t1 t0 44 # ponteiro da fase 4
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 6
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
# fim fase 5
    addi t0 t0 44
# init fase 6
    addi t1 t0 -44 # ponteiro da fase 5
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 7
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
# fim fase 6
    addi t0 t0 44
# init fase 7
    addi t1 t0 -44 # ponteiro da fase 6
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 8
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
# fim fase 7
    addi t0 t0 44
# init fase 8
    addi t1 t0 -44 # ponteiro da fase 7
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 9
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
# fim fase 8
    addi t0 t0 44
# init fase 9
    addi t1 t0 -44 # ponteiro da fase 8
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 44 # ponteiro da fase 10
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
# fim fase 9
    addi t0 t0 44
# init fase 10
    addi t1 t0 -44 # ponteiro da fase 8
    sw t1 0(t0) # ponteiro superior esquerda
    sw t1 4(t0) # ponteiro interior esquerda

    addi t1 t0 -396 # ponteiro da fase 10
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
    
    # sw x0 40(t0) # parede
# fim fase 10
FimInitFases: jalr x0 ra 0
