.data	
	a: 	.string "type a number a: "
	b: 	.string "type a number b: "
	c: 	.string "type a number c: "
	msg0:   .string "\na cannot be equal zero! \n"
	msg:    .string "\nRealizar calculo novamente(Sim=1, Nao=0)? "
	r1: 	.string "R(1)="
	r2: 	.string "R(2)="
	tab: 	.string "\n"
	add: 	.string " + "
	sub: 	.string " - "
	i: 	.string " i"
.text

main:	
	# rotine for input of coefficients
	jal input # Results: A->fs2, B->fs3 and C->fs4
	
	# rotine for solve delta
	jal delta # Result -> fs5 | t1 say if is real or not.
	
	# rotine for solve roots and salve value in stack
	jal bhaskara # r1 -> fs6, r2 -> fs7
	
	# rotine for take from stack the roots values 
	jal show
	
	# runner again
	li a7,4
	la a0,msg
	ecall
	li a7, 5
	ecall
	bne a0, zero, main
	
	# rotine to finish program
	jal exit

advise:
	# msg input
	li a7,4
	la a0,msg0	
	ecall

input:
	# msg input read coefficiente a
	li a7,4
	la a0,a	
	ecall
	# storing a in fs2
	li a7,6
	ecall
	fmv.s fs2, fa0

	fcvt.w.s t6,fs2
	beq t6,zero, advise
	
	# msg input msg input read coefficiente b
	li a7,4
	la a0,b	
	ecall
	# storing b in fs3
	li a7,6
	ecall
	fmv.s fs3, fa0
	
	# msg input msg input read coefficiente c
	li a7,4
	la a0,c	
	ecall
	# storing c in fs4
	li a7,6
	ecall
	fmv.s fs4, fa0
	
	jr ra
	
delta:
	# doing a bhaskara rotine
	#  DELTA
	fmul.s fs5,fs3,fs3	# B²
	fmul.s fs6, fs2,fs4     # A*C
	addi t0, zero,4
	fcvt.s.w ft0, t0	# setting a integer into a float
	fmul.s fs6, fs6, ft0	# * 4
	fsub.s fs5, fs5, fs6    # sub operation

	addi t0,zero,0
	fcvt.s.w ft0, t0	# setting a integer into a float
	flt.s t1, fs5, ft0
	
	beq t1, zero, real
	addi t1,zero,2		# else is complex
	jr ra

# label to set 1 if the roots are real
real:
	addi t1,zero,1
	jr ra
	
bhaskara:
	addi t2,zero,1
	fneg.s fs3,fs3 # -B -> fs3
	
	addi t0,zero,2
	fcvt.s.w ft3, t0	# setting a integer 2 into a float  -> ft3
	fmul.s ft4, fs2, ft3    #divisor 2*a -> ft5
	
	bne t1,t2, soluComplex # if t1  equal 1 then raiz are real else go to solution complex
		
	fsqrt.s fs5, fs5 # delta raiz -> ft4
	
	fadd.s fs6,fs3,fs5 	# -b + delta raiz -> fs6
	fsub.s fs7,fs3,fs5 	# -b - delta raiz -> fs6
	
	fdiv.s fs6, fs6, ft4	# raiz ' -> fs6
	fdiv.s fs7, fs7, ft4	# raiz '' -> fs7
	
	
	# saving values in the stack
	addi sp, sp, -8
	fsw fs6,0(sp)
	fsw fs7,4(sp)
	
	jr ra

# solving bhaskara in complex mode
soluComplex:
	
	fneg.s fs5, fs5  # turning delta positive for sqrt calcule
	fsqrt.s fs5, fs5 # delta raiz -> ft4
	
	fdiv.s fs6, fs3, ft4 # -b / 2*a  -> fs6      real part
	fdiv.s fs7, fs5, ft4 # detla / 2*a   -> fs7  immaginarie part
	
	# saving values in the stack
	addi sp, sp, -8
	fsw fs6,0(sp)
	fsw fs7,4(sp)
	
	jr ra

# showing roots in real format 
show:
	bne t1,t2, showComplex
	
	# showing r1
	li a7, 4
	la a0, r1
	ecall
	
	flw fa0, 0(sp)
	li  a7, 2
	ecall
	
	# tab
	li a7,4
	la a0, tab
	ecall
	
	# showing r2
	li a7, 4
	la a0, r2
	ecall
	
	flw fa0, 4(sp)
	li  a7, 2
	ecall
	
	jr ra

# showing roots in complext format 
showComplex:
	
	# showing r1
	li a7, 4
	la a0, r1
	ecall
	
	flw fa0, 0(sp)
	li  a7, 2
	ecall
	
	li a7, 4
	la a0, add
	ecall
	
	flw fa0, 4(sp)
	li  a7, 2
	ecall
	# i
	li a7, 4
	la a0, i
	ecall
	
	# tab
	li a7,4
	la a0, tab
	ecall
	
	
	
	# showing r2
	li a7, 4
	la a0, r2
	ecall
	
	flw fa0, 0(sp)
	li  a7, 2
	ecall
	
	li a7, 4
	la a0, sub
	ecall
	
	flw fa0, 4(sp)
	li  a7, 2
	ecall
	
	# i
	li a7, 4
	la a0, i
	ecall
	
	jr ra
	
exit:
	li a7, 10
	ecall
