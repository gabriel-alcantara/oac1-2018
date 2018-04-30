	.file	"teste6.c"
	.option nopic
	.text
	.align	2
	.globl	proc
	.type	proc, @function
proc:
	addiw	a0,a0,2
	ret
	.size	proc, .-proc
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a0,12288
	addi	a0,a0,62
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
