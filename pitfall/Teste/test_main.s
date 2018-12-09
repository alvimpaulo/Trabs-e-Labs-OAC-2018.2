.include "macros2.s"
.include "macro_relogio.s"
.data

.text
MAIN: M_SetEcall(exceptionHandling)
	RELOGIO_INICIO(1200000)
MAIN_LOOP:	li a1, 4
	li a2, 226
	jal RELOGIO_LOOP
	j MAIN_LOOP
	
.include "relogio.s"
.include "SYSTEMv12.s"