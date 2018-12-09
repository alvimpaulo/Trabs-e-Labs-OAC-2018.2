.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_X		0
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_DIREITA_Y		215
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_X		320
.eqv POSICAO_INICIAL_PERSONAGEM_SUPERIOR_ESQUERDA_Y		215
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_X		0
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_DIREITA_Y		30
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_X		320
.eqv POSICAO_INICIAL_PERSONAGEM_INFERIOR_ESQUERDA_Y		30
.eqv LARGURA_PERSONAGEM 															12
.eqv ALTURA_PERSONAGEM																24
.eqv VELOCIDADE_DOS_PERSONAGEM												2
.macro InitPersonagem (%posicao_x, %posicao_y)
	la t0 posicaoPersonagemX
	li t1 %posicao_x
	sw t1 0(t0)
	li t1 %posicao_y
	sw t1 4(t0)
.end_macro
