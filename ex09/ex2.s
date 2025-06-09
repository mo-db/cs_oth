.section .rodata
formatPrintf:
.asciz "res1 = %ld, res2 = %d, res3 = %ld\n"

.section .text
.globl main
.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp
	# get memory from stack
	subq $32, %rsp
	# res1 with garbage value is now in 24(%rsp)
	# res2 with garbage value is now in 16(%rsp)
	# set paramteters
	# put params 8 on stack
	movq $1000, 8(%rsp)
	# put params 7 on stack
	leaq 16(%rsp), %rax # address &res2
	movq %rax, (%rsp) # address 16(%rsp) in 8(%rsp)
	# put paramteters 6 to 1 in registers
	movq $0x1A, %r9
	leaq 24(%rsp), %r8
	movb $'A', %cl
	movw $3, %dx
	movl $012, %esi
	movq $1, %rdi
	call calc
	# print results
	leaq formatPrintf, %rdi
	movq 24(%rsp), %rsi
	movl 16(%rsp), %edx
	movq %rax, %rcx
	movq $0, %rax
	call printf
	# clean up stack
	addq $32, %rsp
	# exit main
	movq $0, %rax
	popq %rbp
	ret

.globl calc
.type calc, @function
calc:
	addq %rdi, %rsi # n + l1
	movzwq %dx, %r10 # h in r10
	addq %r10, %rsi # h + rax
	movzbq %cl, %r11 # c in r11
	addq %r11, %rsi # c + rax
	movq %rsi, (%r8) # put sum into *pL

	movq 16(%rsp), %r10
	subq %r9 ,%r10 # l3 - l2 saved in r10
	leaq 8(%rsp), %r11 # addresse von res2 in r11
	movq %r10, (%r11) # add sum into where address points to

	movq (%r11), %rax
	movq (%r8), %r10
	divq %r10, %rax
	movq %rdx, %rax
	ret
