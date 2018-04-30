	.file	"teste7.c"
	.option nopic
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC0)
	addi	sp,sp,-32
	addi	a0,a0,%lo(.LC0)
	sd	ra,24(sp)
	call	printf
	lui	a0,%hi(.LC1)
	addi	a1,sp,12
	addi	a0,a0,%lo(.LC1)
	call	scanf
	lw	a5,12(sp)
	andi	a4,a5,1
	beqz	a4,.L6
	li	a1,9
	mulw	a1,a1,a5
	fcvt.s.w	fa5,a1
.L3:
	fcvt.d.s	fa5,fa5
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	fmv.x.d	a1,fa5
	call	printf
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L6:
	li	a1,3
	mulw	a1,a1,a5
	fcvt.s.w	fa5,a1
	j	.L3
	.size	main, .-main
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Digite um numero:"
	.zero	6
.LC1:
	.string	"%d"
	.zero	5
.LC2:
	.string	"O resultado eh %f\n"
	.ident	"GCC: (GNU) 7.2.0"
