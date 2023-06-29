.section .data
.section .text
.globl _start

_soma_intervalo:

    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

    movl $0, -8(%rbp)
    movl 16(%rbp), %eax
    movl %eax, -4(%rbp)

    loop:
        movl -4(%rbp), %eax
        cmp 20(%rbp), %eax
        jg fim_loop
        addl %eax, -8(%rbp)
        incl -4(%rbp)
        jmp loop
    
    fim_loop:
    
    movl -8(%rbp), %eax
    addq $8, %rsp
    popq %rbp
    ret

_start:

    pushq %rbp
    movq %rsp, %rbp
    subq $4, %rsp

    subq $4, %rsp
    movl $10, (%rsp)
    subq $4, %rsp
    movl $-5, (%rsp)

    call _soma_intervalo
    addq $8, %rsp
    movl %eax, -4(%rbp)
    movl %eax, %edi
    addq $4, %rsp
    popq %rbp
    movq $60, %rax
    syscall