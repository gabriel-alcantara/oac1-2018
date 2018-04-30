	.file	"teste8.c"
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
	addi	a1,sp,15
	addi	a0,a0,%lo(.LC1)
	call	scanf
	lbu	a4,15(sp)
	li	a5,99
	bgtu	a4,a5,.L6
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
.L1:
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L6:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	j	.L1
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
	.string	"Fora dos Limites"
	.zero	7
.LC3:
	.string	"Dentro dos Limites"
	.ident	"GCC: (GNU) 7.2.0"
