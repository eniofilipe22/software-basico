.section .data
.section .text
.globl _start
_start:

    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq $2, -8(%rbp)
    movq $4, -16(%rbp)
    movq $6, -24(%rbp)

    movq -8(%rbp), %rax
    addq -16(%rbp), %rax
    addq -24(%rbp), %rax

    movq $3, %rbx
    idivq %rbx

    movq %rax, -32(%rbp)
    movq -32(%rbp), %rdi

    popq %rbp
    addq $32, %rsp

    movq $60, %rax
    syscall
