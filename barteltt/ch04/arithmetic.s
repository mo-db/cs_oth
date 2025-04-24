.globl _start
.section .text
_start:
	movq $5, %rdi
	movq $5, %rax
	movq %rdi, %rax
	addq %rdi, %rax
	mulq %rdi
	movq $2, %rdi
	addq %rdi, %rax
	movq $4, %rdi
	mulq %rdi
	movq %rax, %rdi

	# Set syscall number code
	movq $60, %rax

	# Perform the Syscall
	syscall
