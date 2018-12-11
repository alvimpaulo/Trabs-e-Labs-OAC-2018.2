.eqv STOPWATCH 0xFF200510
.macro RELOGIO_INICIO(%relogio)         # inicializar relogio
    li a7, 130                          # tempo do sistema, salvo em a0
	M_Ecall
    la t0, TEMPO_SIST                   # salva em TEMP_SIST
    sw a0, 0(t0)
    li s11, %relogio
.end_macro                              # end RELOGIO_INICIO();
