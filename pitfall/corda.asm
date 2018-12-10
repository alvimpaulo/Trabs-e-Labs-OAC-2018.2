.data
	POSISOES: .word
	100, 0,
	101, 0,
	102, 1,
	102, 2,
	103, 3,
	104, 4,
	104, 5,
	105, 6,
	105, 7,
	106, 8,
	107, 9,
	108, 10,
	109, 11,
	110, 12,
	111, 13,
	112, 14,
	113, 15,
	114, 15,
	115, 16,
	116, 17,
	117, 18,
	118, 18,
	119, 18,
	120, 19,
	121, 20,
	122, 20,
	123, 20,
	124, 21,
	125, 21,
	126, 22,
	127, 22,
	128, 22,
	129, 23,
	130, 23,
	131, 23,
	132, 24,
	133, 24,
	134, 24,
	135, 24,
	136, 25,
	137, 25,
	138, 25,
	139, 25,
	140, 25,
	141, 26,
	142, 26,
	143, 26,
	144, 26,
	145, 26,
	146, 26,
	147, 26,
	148, 26,
	149, 27,
	150, 27,
	151, 27,
	152, 27,
	153, 27,
	154, 27,
	155, 27,
	156, 27,
	157, 27,
	158, 27,
	159, 27,
	160, 27,
	161, 27,
	162, 27,
	163, 27,
	164, 27,
	165, 27,
	166, 27,
	167, 27,
	168, 27,
	169, 27,
	170, 27,
	171, 27,
	172, 26,
	173, 26,
	174, 26,
	175, 26,
	176, 26,
	177, 26,
	178, 26,
	179, 26,
	180, 25,
	181, 25,
	182, 25,
	183, 25,
	184, 25,
	185, 24,
	186, 24,
	187, 24,
	188, 24,
	189, 23,
	190, 23,
	191, 23,
	192, 22,
	193, 22,
	194, 22,
	195, 21,
	196, 21,
	197, 20,
	198, 20,
	199, 20,
	200, 19,
	201, 18,
	202, 18,
	203, 18,
	204, 17,
	205, 16,
	206, 15,
	207, 15,
	208, 14,
	209, 13,
	210, 12,
	211, 11,
	212, 10,
	213, 9,
	214, 8,
	215, 7,
	215, 6,
	216, 5,
	216, 4,
	217, 3,
	218, 2,
	218, 1,
	219, 0

	Espera: .word
	1000, 16
	500, 16
	250, 16
	125, 15
	125, 16
	250, 16
	500, 16
	1000, 16
.text
.include "macro.s"
.include "macros2.s"


la s0 POSISOES # carega o & do BURACO
li s1 0  # estado do buravo
li s2 -8 # valor pra ser add/sub endere�o
li s3 -1  # valor add/sub estado
li s4 125 #  final do estado
li s5 -1 # registrador -1
li s6 0xff000000
la t0 Espera # estado tempo
li t2 0


	
LOOP: bgt s1 s4 LOOP2 # se for == ao final do estado
	beqz s1 LOOP1

	li t4 320
	lw t5 0(s0)
	lw t6 4(s0)
	mul t6 t6 t4
	add t6 t6 t5
	add t6 t6 s6
	
	li a7 41
	mv a0 t6
	M_Ecall

	sb a0 0(t6)
	
	add s1 s1 s3 # soma estado 
	add s0 s0 s2 # Soma endere�o BURACO
	
	li a7 32
	lw a0 0(t0)
	lw t3 4(t0)
	bne t2 t3 PULA
		add t0 t0 s2
		lw a0 0(t0)
		li t2 0
	PULA:
	M_Ecall
	

	
	addi t2 t2 1
	j LOOP
LOOP1:

		li t2 1
	mul s2 s2 s5
	mul s3 s3 s5
	# mul t1 t1 s5

	add s1 s1 s3
	add s0 s0 s2
	#add t0 t0 s2
j LOOP
LOOP2:
		li t2 1
	mul s2 s2 s5
	mul s3 s3 s5
	# mul t1 t1 s5

	add s1 s1 s3
	add s0 s0 s2
	add t0 t0 s2

j LOOP
.include "utilidades.s"
.include "SYSTEMv12.s"
