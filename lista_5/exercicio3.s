.section .data
.section .text
.globl _start

_media:

    pushq %rbp
    movq %rsp, %rbp
    subq $2, %rsp

    movw 16(%rbp), %ax
    addw 18(%rbp), %ax
    addw 20(%rbp), %ax

    movw $3, %bx

    idivw %bx

    movw %ax, -2(%rbp)

    addq $2, %rsp
    popq %rbp
    ret

_start:

    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

    movw $2, -2(%rbp)
    movw $4, -4(%rbp)
    movw $6, -6(%rbp)

    pushw -6(%rbp)
    pushw -4(%rbp)
    pushw -2(%rbp)

    call _media

    addq $6, %rsp
    
    movw %ax, -8(%rbp)
    movswq -8(%rbp), %rdi

    addq $8, %rsp
    popq %rbp
    movq $60, %rax
    syscall