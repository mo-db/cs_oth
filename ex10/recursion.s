.section .rodata
enter:
	.asciz ""
print_format:
	.asciz "%s\n"
p_format:
	.asciz "%c"

.section .text
.globl p_rev
.type p_rev, @function
p_rev:
	pushq %rbp
	movq %rsp, %rbp

	#get space and allign
	subq $24, %rsp

	cmpl $0, %esi
	je .end_p_rev

	movq %rdi, -8(%rbp)
	movslq %esi, %rax
	subq $1, %rax
	movl %eax, -12(%rbp)

	leaq p_format(%rip), %rdi
	movq -8(%rbp), %rdx 
	movb (%rdx, %rax), %sil
	movq $0, %rax
	call printf

	#load local vars in regs again
	movq -8(%rbp), %rdi
	movl -12(%rbp), %esi
	call p_rev

.end_p_rev:
	movq %rbp, %rsp
	popq %rbp
	ret

.globl main
.type main, @function
main:
	#push callers frame-pointer to stack
	pushq %rbp
	#copy value of rsp to rbp -> both point to top of stack-frame
	movq %rsp, %rbp
	#create space for local variables
	subq $16, %rsp
	#save length to stack
	movl $3, -4(%rbp)
	#save word to stack
	movb $'A', -8(%rbp)
	movb $'B', -7(%rbp)
	movb $'c', -6(%rbp)
	movb $'\0', -5(%rbp)

	leaq -8(%rbp), %rdi
	movl -4(%rbp), %esi

	call p_rev

	#printf
	# leaq print_format(%rip), %rdi
	# load address of sting into %rsi
	# leaq -8(%rbp), %rsi
	# movq $0, %rax
	# call printf
	#leave
	#make rsp point to old rbp value
	movq %rbp, %rsp
	popq %rbp
	ret
