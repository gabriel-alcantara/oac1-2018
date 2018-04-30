.data
	

.text
	addi	sp,sp,-32
	sw	ra,24(sp)
	sw	s0,16(sp)
	addi	s0,sp,32
	li	a5,12288
	addi	a5,a5,57
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	proc
	mv	a5,a0
	mv	a0,a5
	lw	ra,24(sp)
	lw	s0,16(sp)
	addi	sp,sp,32


proc:
	addi	sp,sp,-48
	sw	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	addi	a5,a5,2
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra