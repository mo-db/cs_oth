.section .rodata
format:
#.asciz "Sum = %ld\n"
	.asciz "sum = %f\n"
.section .bss
.lcomm results, 16
.section .data
.align 16
farr1:
.float 13.99, 17.4, 2.0, 3.0
.align 16
farr2:
.float -214.0, 0.75, 5.5, 30.52
.section .text
.globl main
.type main, @function
main:
	# start boilerplate
	pushq %rbp
	movq %rsp, %rbp
	# subq $8, %rsp # <-- align stack

	# calc 1. expression
	leaq results(%rip), %rdi
	vmovss farr1(%rip), %xmm0
	vmovss farr1+4(%rip), %xmm1
	vsubss %xmm1, %xmm0, %xmm0
	vmovss %xmm0, (%rdi)
	# vcvttss2siq %xmm0, %rax
	# movq %rax, (%rdi)

	# call printf
	movq results(%rip), %rsi
	leaq format(%rip), %rdi
	movq $0, %rax
	call printf

	# exit main, return 0
	movq $0, %rax
	movq %rsp, %rbp
	popq %rbp
	ret
	.globl truncDec
	.type truncDec, @function
truncDec:
	# …
	ret
