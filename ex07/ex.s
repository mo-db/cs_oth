	.file	"ex.c"
	.text
	.section	.rodata
.LC0:
	.string	"Choose an option:"
.LC1:
	.string	"1 - Count up using for loop"
	.align 8
.LC2:
	.string	"2 - Print triangle pattern with '|'"
	.align 8
.LC3:
	.string	"3 - Print triangle pattern with 'o'"
.LC4:
	.string	"Your choice: "
.LC5:
	.string	" %c"
.LC6:
	.string	"%d "
.LC7:
	.string	""
.LC8:
	.string	"Invalidselection."
	.align 8
.LC9:
	.string	"Do you want to try again? (y/n): "
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
	subq	$32, %rsp
	movb	$111, -1(%rbp)
.L15:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-17(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT

	# switch
	movzbl	-17(%rbp), %eax
	movsbl	%al, %eax
	cmpl	$51, %eax
	je	.L2
	cmpl	$51, %eax
	jg	.L3
	cmpl	$49, %eax
	je	.L4
	cmpl	$50, %eax
	je	.L5
	jmp	.L3

	# cases
.L4:
	movl	$1, -8(%rbp)
	jmp	.L6
.L7:
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -8(%rbp)
.L6:
	cmpl	$5, -8(%rbp)
	jle	.L7
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L8
.L5:
	movb	$124, -1(%rbp)
.L2:
	movzbl	-17(%rbp), %eax
	cmpb	$3, %al
	jne	.L9
	movb	$111, -1(%rbp)
.L9:
	movl	$1, -12(%rbp)
	jmp	.L10
.L14:
	movl	$1, -16(%rbp)
.L13:
	movl	-16(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	.L11
	movsbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	putchar@PLT
	jmp	.L12
.L11:
	movl	$43, %edi
	call	putchar@PLT
.L12:
	addl	$1, -16(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jle	.L13
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	addl	$1, -12(%rbp)
.L10:
	cmpl	$5, -12(%rbp)
	jle	.L14
	jmp	.L8
.L3:
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L8:
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-18(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movb	$111, -1(%rbp)
	movzbl	-18(%rbp), %eax
	cmpb	$121, %al
	je	.L15
	movzbl	-18(%rbp), %eax
	cmpb	$89, %al
	je	.L15
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
