.globl _start

.section .data
n:
	.long -5
l:
	.quad 0x3000
c:
	.byte 65
h:
	.short 012

.section .bss
	.lcomm sum, 8

.section .text
_start:
	movl n, %eax
	cltq 
	addq l, %rax
	movzbq c, %r10
	addq %r10, %rax
	movzwq h, %r10
	addq %r10, %rax
	movq $2, %rdi
	movq $60, %rax
	syscall
