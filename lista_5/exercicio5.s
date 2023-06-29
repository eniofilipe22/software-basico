.section .data
.section .text
.globl _start

_soma_vetor:
    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

    movl $0, -4(%rbp) # i
    movl $0, -8(%rbp) # s

    loop:
    movl -4(%rbp), %edi
    cmp 24(%rbp), %edi # compara i com tam
    je fim_loop
    movl -8(%rbp), %eax
    movq 16(%rbp), %rbx
    addl (%rbx, %rdi, 4), %eax
    movl %eax, -8(%rbp)
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
    subq $44, %rsp

    movl $1, -40(%rbp)
    movl $2, -36(%rbp)
    movl $3, -32(%rbp)
    movl $4, -28(%rbp)
    movl $5, -24(%rbp)
    movl $6, -20(%rbp)
    movl $7, -16(%rbp)
    movl $8, -12(%rbp)
    movl $9, -8(%rbp)
    movl $10, -4(%rbp)

    subq $4, %rsp
    movl $10, (%rsp)
    subq $8, %rsp
    movq %rbp, %rax
    subq $40, %rax
    movq %rax, (%rsp)

    call _soma_vetor

    addq $12, %rsp
    movl %eax, -44(%rbp)
    movl -44(%rbp), %edi
    
    addq $44, %rsp
    popq %rbp

    movq $60, %rax
    syscall
