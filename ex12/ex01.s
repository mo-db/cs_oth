.section .rodata
format:
	.asciz "Sum = %ld\n"

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
	subq $8, %rsp	# align 16

	# calc 1. expression
	leaq results(%rip), %rdi
	vmovss farr1(%rip), %xmm0
	vmovss farr1+4(%rip), %xmm1
	vsubss %xmm1, %xmm0, %xmm0
	vmovss %xmm0, (%rdi)

	# calc 2. expression
	vmovss farr1+8(%rip), %xmm0
	vmovss farr1+12(%rip), %xmm1
	sqrtss %xmm0, %xmm0
	sqrtss %xmm1, %xmm1
	vaddss %xmm1, %xmm0, %xmm0
	vmovss %xmm0, 4(%rdi)

	# calc 3. expression
	vmovss farr2(%rip), %xmm0
	vmovss farr2+4(%rip), %xmm1
	vmulss %xmm1, %xmm0, %xmm0
	vmovss %xmm0, 8(%rdi)

	# calc 4. expression
	vmovss farr2+8(%rip), %xmm0
	vmovss farr2+12(%rip), %xmm1
	vmaxss %xmm1, %xmm0, %xmm0
	vmovss %xmm0, 12(%rdi)

	call trunc_dec

	# call printf
	leaq format(%rip), %rdi
	movq %rax, %rsi
	movq $0, %rax
	call printf

	# exit main, return 0
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret

### FUNCTIONS ###
	.globl trunc_dec
	.type trunc_dec, @function
trunc_dec:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp	# align 16

	vxorps %xmm0, %xmm0, %xmm0 # sum
	movq $0, %r10 # i

.Ltrunc_dec_for:
	# loop test
	cmpq $4, %r10
	jae .Ltrunc_dec_for_end

	# loop body
	# for later -> use vectorized add here
	vmovss (%rdi, %r10, 4), %xmm1 
	vaddss %xmm1, %xmm0, %xmm0
	incq %r10
	jmp .Ltrunc_dec_for

.Ltrunc_dec_for_end:
	vcvttss2siq %xmm0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
