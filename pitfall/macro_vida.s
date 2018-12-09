.macro inicializar_vida(%qtd)
	li t0, %qtd
	la t1, VIDAS
	sw t0, 0(t1)		# Salvando qtd de vidas na MEM
.end_macro