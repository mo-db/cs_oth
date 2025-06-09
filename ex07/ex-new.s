# macro
.equ COUNT, 5

# bss
.section .bss
 .lcomm choice, 1
 .lcomm again, 1
.section .data
pattern: .byte 'o'

# rodata
.section .rodata
putsChoose: .asciz "Choose an option:"
puts1: .asciz "1 - Count up using for loop"
puts2: .asciz "2 - Print triangle pattern with '|'"
puts3: .asciz "3 - Print triangle pattern with 'o'"
printfChoice: .asciz "Your choice: "
putsReturn: .asciz ""
printfD: .asciz "%d "
printfC: .asciz "%c"
printfPlus: .asciz "+"
putsInvalid: .asciz "Invalid selection."
printfQuestion: .asciz "Do you want to try again? (y/n): "
scanfC: .asciz " %c"

.align 8
.jTable:
 .quad .case1
 .quad .case2
 .quad .case3
 .quad .default

# text
.section .text
.globl main
.type main, @function
main:
 pushq %rbp
 movq %rsp, %rbp
.do_while:
# print infos
leaq putsChoose, %rdi
call puts
leaq puts1, %rdi
call puts
leaq puts2, %rdi
call puts
leaq puts3, %rdi
call puts
leaq printfChoice, %rdi
movq $0, %rax
call printf

# read choice
leaq scanfC(%rip), %rdi
leaq choice(%rip), %rsi
movq $0, %rax
call scanf


################

# NOTE: Gap 1
movzbl choice(%rip), %edi # use edi because of long zero extend
subq $'1', %rdi # convert char to digit-1
cmp $3, %rdi
ja .default
jmp *.jTable(,%rdi,8)

################

.case1:
 movl $1, %r12d
 jmp .for_test
.for:
 leaq printfD, %rdi
 movl %r12d, %esi
 movq $0, %rax
 call printf
 incl %r12d
.for_test:
 cmpl $COUNT, %r12d
 jle .for
 leaq putsReturn, %rdi
 call puts
 jmp .test_do_while
.case2:
 movb $'|', pattern
 jmp .case3

###########

# 2. Lücke

.case3:
		movzbl choice(%rip), %esi
    cmp $'3', %rsi
    jne .for2
    movb $'o', pattern

    .for2:
        movl $1, %r13d #coll

    .while:
        movl $2, %eax
        # movlq %r13d, %r13
        divl %r13d
        cmp $0, %rdx
        jne .loc2

        leaq printfC, %rdi
        jmp .loc3

    .loc2: 
        leaq pattern, %rsi
        leaq printfPlus, %rdi
    
    .loc3:
        movq $0, %rax
        call printf

        addl $1, %r13d

        leaq putsReturn, %rdi
        call puts

    .while_test:
        cmp %r12d, %r13d
        jle .while
    
    .for_test2:
        cmpl $COUNT, %r12d # row
        jle .for2


############

.default:
 leaq putsInvalid, %rdi
 call puts
.test_do_while:
 leaq printfQuestion, %rdi
 movq $0, %rax
 call printf
 # read again
 leaq scanfC, %rdi
 leaq again, %rsi
 movq $0, %rax
 call scanf
 movb again, %r12b
 cmpb $'Y', %r12b
 jz .do_while
 cmpb $'y', %r12b
 jz .do_while

 # end
 movq $0, %rax
 popq %rbp
 ret
