.section .bss
	.lcomm sum, 8

.section .data
n:
	.long -5
l:
	.quad 0x3000
c:
	.byte 65
h:
	.short 012
format_printf:
	.asciz "sum = %ld\n"

.section .text
.globl main
.type main, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	# Accumulate in rax
	movl n, %eax
	cltq
	addq l, %rax
	movzbq c, %r10
	addq %r10, %rax
	movzwq h, %r10
	addq %r10, %rax

	# Copy to sum variable
	movq %rax, sum(%rip)
	
	# Print sum
	movq $format_printf, %rdi
	movq sum, %rsi
	movq $0, %rax
	call printf
	movq $60, %rax
	popq %rbp
	syscall
