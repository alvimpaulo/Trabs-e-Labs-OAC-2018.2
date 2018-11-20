.data
N:	.float 5.5
N2:	.float 30.25
N3:	.float -5.5
MSG:	.string "Endereco do erro : "
MSG2:	.string "Nao ha erros :)"

.include "macros2.s"

.text
	la t1, N		#t0 = N     flw     fsw
	flw ft0, 0(t1)
	fcvt.s.w ft1, zero
	fsw ft0, 8(t1)
	flw ft0, 8(t1)
	feq.s t0, ft0, ft1
	beq t0, zero, PULAERRO1
	jal t0, ERRO 
	
PULAERRO1: li t0, 11		#ft0 = 5.5 + 5.5     fadd.s
	fcvt.s.w ft0, t0
	la t1, N
	flw ft1, 0(t1)
	fadd.s ft1, ft1, ft1
	feq.s t0, ft1, ft0
	li t1, 1
	beq t0, t1, PULAERRO2
	jal t0, ERRO


PULAERRO2: la t0, N		#ft1 = 5.5 - 5.5 = 0    fsub.s
	flw ft0, 0(t0)
	fsub.s ft0, ft0, ft0
	fcvt.w.s t0, ft0
	beq t0, zero, PULAERRO3
	jal t0, ERRO

PULAERRO3: la t0, N		#ft1 = 5.5 * 5.5 = 30.25   mul
	la t1, N2
	flw ft0, 0(t0)
	flw ft1, 0(t1)
	fmul.s ft0, ft0, ft0
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO4
	jal t0, ERRO
	
PULAERRO4: la t0, N		#fmin.s
	flw ft0, 0(t0)
	flw ft1, 0(t0)
	fmin.s ft1, ft0, ft1
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO5
	jal t0, ERRO
	
PULAERRO5: la t0, N2		#sqrt
	la t1, N
	flw ft0, 0(t0)
	flw ft1, 0(t1)
	fsqrt.s ft0, ft0
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO6
	jal t0, ERRO
	
PULAERRO6: li t1, -4		#fcvt.s.w
	li t0, -2
	fcvt.s.w ft0, t1
	fcvt.s.w ft1, t0
	fadd.s ft1, ft1, ft1
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO7
	jal t0, ERRO
	
PULAERRO7: li t1, 4		#fcvt.s.wu
	li t0, 2
	fcvt.s.wu ft0, t1
	fcvt.s.wu ft1, t0
	fadd.s ft1, ft1, ft1
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO8
	jal t0, ERRO
	
PULAERRO8: la t0, N3		#fcvt.w.s
	flw ft0, 0(t0)
	fcvt.w.s t0, ft0
	li t1, 6
	beq t0, t1, PULAERRO9
	jal t0, ERRO
	
PULAERRO9: la t0, N		#fcvt.wu.s
	flw ft0, 0(t0)
	fcvt.wu.s t0, ft0
	li t1, 6
	beq t0, t1, PULAERRO10
	jal t0, ERRO
	
PULAERRO10: li t0, 0x40b00000	#fmv.s.x
	fmv.s.x ft0, t0
	la t1, N
	flw ft1, 0(t1)
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO11
	jal t0, ERRO
	
PULAERRO11: la t0, N		#fmv.x.s
	flw ft0, 0(t0)
	fmv.x.s t0, ft0
	li t1, 0x40b00000
	beq t0, t1, PULAERRO12
	jal t0, ERRO
	
PULAERRO12: la t0, N		#feq.s
	flw ft0, 0(t0)
	flw ft1, 0(t0)
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO13
	jal t0, ERRO
	
PULAERRO13: la t0, N		#fle.s
	flw ft0, 0(t0)
	flw ft1, 0(t0)
	fle.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO14
	jal t0, ERRO
	
PULAERRO14: la t0, N		#flt.s
	flw ft0, 0(t0)
	flw ft1, 4(t0)
	flt.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO15
	jal t0, ERRO
	
PULAERRO15: la t0, N		#fsgnj.s
	flw ft0, 0(t0)
	fneg.s ft1, ft0
	fsgnj.s ft0, ft1, ft0
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO16
	jal t0, ERRO
	
PULAERRO16: la t0, N		#fsgnjn.s
	flw ft0, 0(t0)
	fsgnjn.s ft1, ft0, ft0
	feq.s t0, ft0, ft1
	beq t0, zero, PULAERRO17
	jal t0, ERRO
	
PULAERRO17: la t0, N		#fsgnjx.s
	flw ft0, 0(t0)
	fneg.s ft1, ft0
	fsgnjx.s ft1, ft1, ft1
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO18
	jal t0, ERRO

PULAERRO18: la t0, N		#fmax.s
	flw ft0, 0(t0)
	flw ft1, 4(t0)
	fmax.s ft0, ft0, ft1
	feq.s t0, ft0, ft1
	li t1, 1
	beq t0, t1, PULAERRO19
	jal t0, ERRO
	
PULAERRO19: la t0, N		#ft0 = 5.5 / 5.5 = 1
	flw ft0, 0(t0)
	fdiv.s ft0, ft0, ft0
	fcvt.w.s t0, ft0
	li t1, 1
	beq t0, t1, SUCESSO
	jal t0, ERRO

SUCESSO: M_SetEcall(exceptionHandling)	

   	li a0, 0x38
	li a7, 148
	M_Ecall

	#print string sucesso
	li a3,0x3800
LOOP:	li a7, 104
	la a0, MSG2
	li a1, 100
	li a2, 0
	M_Ecall
	addi a3,a3,1
	j LOOP
	
	#end
	addi a7, zero, 10
	M_Ecall
	
ERRO:	mv s0,t0
	M_SetEcall(exceptionHandling)
		
	li a0, 0x07
	li a7, 148
	M_Ecall
	
	#Print string erro
	li a7, 104
	la a0, MSG
	li a1, 0
	li a2, 0
	li a3, 0x0700
	M_Ecall
	
	#print endereco erro
	addi a0, s0, -12 #Endereco onde ocorreu o erro
	li a7, 134
	li a1, 148
	li a2, 0
	li a3, 0x0700
	M_Ecall
	
	#end
END: addi a7, zero, 10
	M_Ecall
	
.include "SYSTEMv12.s"
