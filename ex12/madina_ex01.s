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
	pushq %rbp
	movq %rsp, %rbp

	leaq farr1, %rax
	vmovss (%rax), %xmm0
	vmovss 4(%rax), %xmm1
	vsubss %xmm1, %xmm0, %xmm0 #f[0] is saved in xmm0

	vmovss 8(%rax), %xmm2
	vmovss 12(%rax), %xmm1
	sqrtss %xmm2, %xmm3
	sqrtss %xmm1, %xmm2
	vaddss %xmm2, %xmm3, %xmm3 #f[1] is saved here in xmm3

	leaq farr2, %rax
	vmovss (%rax), %xmm1
	vmovss 4(%rax), %xmm2
	vmulss %xmm1, %xmm2, %xmm2 #f[2] stored here in xmm2

	vmovss 8(%rax), %xmm1
	vmovss 12(%rax), %xmm3
	vmaxss %xmm1, %xmm3, %xmm5 #f[3] stored here in xmm5

	leaq results, %rdi
	vmovss %xmm0, (%rdi)
	vmovss %xmm3, 4(%rdi)
	vmovss %xmm2, 8(%rdi)
	vmovss %xmm5, 12(%rdi)
	call truncDec

	 # call printf
	 leaq format, %rdi
	 movq %rax, %rsi
	 movq $0, %rax
	 call printf
	 # exit main
	 movq $0, %rax
	 popq %rbp
	 ret

.globl truncDec
.type truncDec, @function
truncDec:
	vxorps %xmm0, %xmm0, %xmm0 #xmm initialized with zero
	movq $0, %rcx #index saved here
	jmp .for_test
	.for:
	vmovss (%rdi, %rcx, 4), %xmm1
	vaddss %xmm1, %xmm0, %xmm0
	addq $1, %rcx
	.for_test:
	cmpq $4, %rcx
	jge .for
	cvttss2si %xmm0, %rax #converting the return value to long from float 
	ret
