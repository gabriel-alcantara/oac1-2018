main:
	addi	sp,sp,-16
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a5,10
	mv	a0,a5
	lw	s0,8(sp)
	addi	sp,sp,16
