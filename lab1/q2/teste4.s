.data

	.LC0: .asciz "Numero: "

.text
	addi	sp,sp,-16
	sw	ra,8(sp)
	sw	s0,0(sp)
	li	s0,12288
	addi	a1,s0,57
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	
	li  a7, 4
	la  a0, .LC0
	ecall
	
	
	addi	a0,s0,59
	lw	ra,8(sp)
	lw	s0,0(sp)
	addi	sp,sp,16
	
	li  a7, 1
	ecall