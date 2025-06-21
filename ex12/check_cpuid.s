.section .rodata
out_str:
	.asciz "%d\n"

.section .text
.globl main
.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp #make rbp = rsp
	movl $0x0, %eax
	cpuid 
	or $0x5, %eax
	leaq out_str(%rip), %rdi
	movslq %eax, %rsi
	movq $0, %rax
	call printf
	movq %rbp, %rsp #make rsp = rbp
	popq %rbp
	ret
