.section .data
num:
	.quad 0x123

.section .text
.globl main
.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp

	movq num(%rip), %rsi

	movq $0, %rax
	popq %rbp
	ret
