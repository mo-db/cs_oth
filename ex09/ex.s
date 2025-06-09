.section .data
	.align 16
	.globl S
	.type S, @object
	.size S, 24
S:
	.byte 'Z'		#char
	.zero 3			#padding
	.long 1,2		#int-ary
	.zero 4			#padding
	.quad 0			#pointer

.section .text
.globl _start
; .type main, @function
_start:
	pushq %rbp
	movq %rsp, %rbp
	leaq S(%rip), %rsi 
	leaq 4(%rsi), %rdi
	movq %rdi, 16(%rsi)

  movq $60, %rax          # syscall number for exit
  xor  %rdi, %rdi         # status = 0
  syscall
	; ret
