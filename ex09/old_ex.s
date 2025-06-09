.section .bss
.lcomm new_ary, 32 # 8 * 4

.section .data
ary:
	.int 0, 10, 20, 30, 40, 50, 60, 70

.section .rodata
printInt:
	.asciz "%4d, "
putsNL:
	.asciz ""

.section .text
.globl main
.type main, @function
main:
	pushq %rbp
	movq %rsp, %rbp

	movq $0, %r12 #odd
	movq $1, %r13 #even
.for:
	# write elements of ary into new_ary, switching even and odd elements
	leaq ary(%rip), %rax
	movl (%rax, %r12, 4), %r14d # mov ary[odd] to r14d, movl does 0 extend
	movl (%rax, %r13, 4), %r15d # mov ary[even] to r15d, movl does 0 extend

	leaq new_ary(%rip), %rax
	movl %r14d, (%rax, %r13, 4)
	movl %r15d, (%rax, %r12, 4)

	# increment odd, even loop vars
	addq $2, %r12
	addq $2, %r13

.for_test:
	cmpq $7, %r12
	jle .for

	# print resulting new_ary with nested for loops
	movq $0, %r12 # row
.outer_for:
	movq $0, %r13 # collum

.inner_for:
	# print new_ary[row][collum]
	leaq printInt(%rip), %rdi
	movq $4, %rax # row offset -> n collums make var for this
	mulq %r12 # multiply by row
	addq %r13, %rax # add colum index
	leaq new_ary(%rip), %rdx
	# leaq new_ary(%rip, %rax, 4), %rsi
	leaq (%rdx, %rax, 4), %rdx
	movl (%rdx), %esi #zero extends esi
	movq $0, %rax
	call printf

	# increment collum
	addq $1, %r13

.inner_for_test:
	# test collum < 4
	cmpq $3, %r13
	jle .inner_for

	# increment row
	addq $1, %r12
	# print new line
	leaq putsNL(%rip), %rdi
	call puts

.outer_for_test:
	# test row < 2
	cmpq $1, %r12
	jle .outer_for

	movq $0, %rax
	popq %rbp
	ret
