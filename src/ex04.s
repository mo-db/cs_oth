	.file	"ex04.c"
	.text
	.globl	n
	.data
	.align 4
	.type	n, @object
	.size	n, 4
n:
	.long	-5
	.globl	l
	.align 8
	.type	l, @object
	.size	l, 8
l:
	.quad	12288
	.globl	c
	.type	c, @object
	.size	c, 1
c:
	.byte	65
	.globl	h
	.align 2
	.type	h, @object
	.size	h, 2
h:
	.value	10
	.globl	sum
	.bss
	.align 8
	.type	sum, @object
	.size	sum, 8
sum:
	.zero	8
	.section	.rodata
.LC0:
	.string	"sum = %ld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	n(%rip), %eax
	movslq	%eax, %rdx
	movq	l(%rip), %rax
	addq	%rax, %rdx
	movzbl	c(%rip), %eax
	movsbq	%al, %rax
	addq	%rax, %rdx
	movzwl	h(%rip), %eax
	movswq	%ax, %rax
	addq	%rdx, %rax
	movq	%rax, sum(%rip)
	movq	sum(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
