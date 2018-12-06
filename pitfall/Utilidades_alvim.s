.macro ChecagemDeCor(%endereco,%tipo)
	#armazena o bit do display daquela posicao em $t8 e o bit original do mapa em $t9 para compara�ao
	#CHECAGEM TIPO 0 PARA CARRO E 1 PARA SAPO
	lw $t8, 2572(%endereco)	#salva o word 8 lihas abaixo do endereco
	la $t3, MAPADADOS 	
	sub $t2,$s1,0xff000000	
	add $t3,$t3,$t2 	
	lw $t9, 2572($t3)	
	sw $t9, CORCHECAGEMFUNDO
	sw $t8, CORCHECAGEMBITMAP
	
	li $t1,%tipo
	bne $t1,1,CHECKFIN
	
	lw $t8, 2564(%endereco)	
	la $t3, MAPADADOS 	
	sub $t2,$s1,0xff000000	
	add $t3,$t3,$t2 	
	lw $t9, 2564($t3)
	sw $t9, CORCHECAGEMFUNDO
	sw $t8, CORCHECAGEMBITMAP
CHECKFIN:	
.end_macro

.macro printSprite(%enderecoInicio, %enderecoDados, %largura, %altura) #Cuidado, mexe na $s0!!!
	#Manda a Sprite para o display	
	move $t0, %enderecoInicio #inicio e endere�o atual
	la $t1, %enderecoDados #local (memoria) que o bin esta armazenado
	li $t2, %largura 
	li $t3, %altura 
	li $t4, 0 #contador horizontal
	li $t5, 0 #contador vertical
	li $s0, 320 #largura do mapa
loopDesenhaWord:beq $t5, $t3, fimLoopDesenhaWord
testeFimLinha:	beq $t4, $t2, fimDaLinhaSprite
	lw $t6, 0($t1) #carrega o valor da word que esta em %EnderecoDados
	sw $t6, 0($t0) #manda o valor que est� dentro de PLAYERDADOS para o display, posicao $s0
	addi $t0, $t0, 4 #proximos 4pixel do mapa
	addi $t1, $t1, 4 #proximos 4 pixel do player
	addi $t4, $t4, 4 #itera  horinzontal
	j loopDesenhaWord
fimDaLinhaSprite:
	sub $t7, $s0, $t2 #subtrai largura da sprite de 320
	add $t0, $t0, $t7 #pula uma linha (320 - largura)
	addi $t5, $t5, 1 #itera o contador vertical
	li $t4, 0 #reseta o contador
	j loopDesenhaWord
fimLoopDesenhaWord:
.end_macro