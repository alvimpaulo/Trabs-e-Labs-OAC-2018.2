
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X		296
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y		120
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X		20
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y		120
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_X		296
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_Y		220
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_X		12
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_Y		220
.eqv LARGURA_PERSONAGEM 															12
.eqv ALTURA_PERSONAGEM																24
.eqv VELOCIDADE_DOS_PERSONAGEM												2
.macro InitPersonagem (%posicao_x, %posicao_y)
	la t0 posicaoPersonagemX
	li t1 %posicao_x
	sw t1 0(t0)
	la t0 posicaoPersonagemY
	li t1 %posicao_y
	sw t1 0(t0)
.end_macro										
.macro InitPersonagemReg (%posicao_x, %posicao_y)
	la t0 posicaoPersonagemX
	sw %posicao_x 0(t0)
	la t0 posicaoPersonagemY
	sw %posicao_y 0(t0)
.end_macro
