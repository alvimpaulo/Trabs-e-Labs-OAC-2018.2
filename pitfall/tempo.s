.data

.text
.include "macros2.s"
LOOP:
li s0 0xFF200510
li a7 101
lw a0 0(s0)
li a1 160
li a2 120
li a3 0x0038
M_Ecall
j LOOP

.include "SYSTEMv12.s"