.section .data
.align 16
farr0:
.float 0.0, 0.0, 0.0, 0.0
.align 16
farr1:
.float -11.1, 12.4, 13.5, 14.9
.align 16
farr2:
.float 21.1, -22.4, 23.5, 24.9
.align 16
farr3:
.double 31.1, 32.9
.align 16
farr4:
.double 41.1, 42.9
.section .text
.globl _start
.type _start, @function
_start:
	vmovaps farr0, %xmm0 # xmm0 = 0
	vmovaps farr1, %xmm1
	vmovaps farr2, %xmm2
	# low part of farr1 to low part of xmm0, rest of xmm2
	vmovlps farr1, %xmm2, %xmm0
	vmovaps farr0, %xmm0 # xmm0 = 0
	# low part of farr1 to high part of xmm0, rest of xmm2
	vmovhps farr1, %xmm2, %xmm0
	vmovapd farr3, %xmm3
	vmovapd farr4, %xmm4
	vmovaps farr0, %xmm0 # xmm0 = 0
	# low part of farr3 to low part of xmm0, rest of xmm4
	vmovlpd farr3, %xmm4, %xmm0
	vmovaps farr0, %xmm0 # xmm0 = 0
	# low part of farr3 to high part of xmm0, rest of xmm4
	vmovhpd farr3, %xmm4, %xmm0
_end:
	movq $60, %rax
	xorq %rdi, %rdi
	syscall
