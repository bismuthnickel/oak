	.file	"kernel.c"
	.text
	.globl	putc
	.type	putc, @function
putc:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$28, %esp
	movl	8(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movb	%cl, -20(%ebp)
	movw	%dx, -24(%ebp)
	movw	%ax, -28(%ebp)
	movl	$753664, -4(%ebp)
	movsbw	-20(%ebp), %dx
	movzwl	-24(%ebp), %eax
	movl	%edx, %ecx
	orl	%eax, %ecx
	movzwl	-28(%ebp), %eax
	leal	(%eax,%eax), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movl	%ecx, %edx
	movw	%dx, (%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	putc, .-putc
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	$0
	pushl	$3072
	pushl	$104
	call	putc
	addl	$12, %esp
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
