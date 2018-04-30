	.file	"teste9.c"
	.option nopic
	.text
	.align	2
	.globl	proc
	.type	proc, @function
proc:
	add	a1,a0,a1
	lbu	a5,1(a1)
	lbu	a4,0(a1)
	mulw	a5,a5,a4
	fcvt.s.w	fa0,a5
	ret
	.size	proc, .-proc
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	ld	a4,0(a5)
	lhu	a5,8(a5)
	lui	a0,%hi(.LC1)
	addi	sp,sp,-48
	addi	a0,a0,%lo(.LC1)
	sd	ra,40(sp)
	sd	a4,16(sp)
	sh	a5,24(sp)
	call	printf
	lui	a0,%hi(.LC2)
	addi	a1,sp,15
	addi	a0,a0,%lo(.LC2)
	call	scanf
	lbu	a5,15(sp)
	addi	a4,sp,32
	lui	a0,%hi(.LC3)
	add	a5,a4,a5
	lbu	a1,-15(a5)
	lbu	a5,-16(a5)
	addi	a0,a0,%lo(.LC3)
	mulw	a1,a1,a5
	fcvt.d.w	fa5,a1
	fmv.x.d	a1,fa5
	call	printf
	ld	ra,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
.LC0:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"Digite um numero:"
	.zero	6
.LC2:
	.string	"%d"
	.zero	5
.LC3:
	.string	"Resultado:%f\n"
	.ident	"GCC: (GNU) 7.2.0"
