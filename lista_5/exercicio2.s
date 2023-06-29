.section .data
.section .text
.globl _start

_media:
    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

    movq 16(%rbp), %rax
    addq 24(%rbp), %rax
    addq 32(%rbp), %rax

    movq $3, %rbx
    idivq %rbx

    movq %rax, -8(%rbp)
    addq $8, %rsp
    popq %rbp
    ret

_start:

    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq $2, -8(%rbp)
    movq $4, -16(%rbp)
    movq $6, -24(%rbp)

    pushq -24(%rbp)
    pushq -16(%rbp)
    pushq -8(%rbp)

    call _media

    addq $24, %rsp
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rdi

    popq %rbp
    addq $32, %rsp

    movq $60, %rax
    syscall