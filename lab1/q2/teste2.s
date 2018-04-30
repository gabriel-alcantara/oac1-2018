main:
	addi	sp,sp,-32
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,12288
	addi	a5,a5,57
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	slli	a5,a5,1
	#sext.w	a5,a5
	addi a5,a5,0
	mv	a0,a5
	lw	s0,24(sp)
	addi	sp,sp,32