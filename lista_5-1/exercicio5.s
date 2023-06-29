.section .data
str1: .string "20" 
negative: .byte 0
.section .text
.globl _start


_start: 
    movq $str1, %rdi
    movq $0, %rax

    cmpb $45, (%rdi) 
    jne conversao

    movb $1, negative
    incq %rdi

    conversao:
        cmpb $0, (%rdi)
        je fim_conversao

        movq (%rdi), %rbx
        subq $48, %rbx
        movq $10, %rcx
        imulq %rcx
        addq %rbx, %rax        

        incq %rdi
        jmp conversao
    fim_conversao:

    cmpb $1, negative
    jne nao_nega
    negq %rax

    nao_nega:
     
    movq %rax, %rdi
    movq $60, %rax
    syscall
