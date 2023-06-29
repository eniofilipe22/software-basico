.section .data
    str1: .string "Digite quatro numeros: "
    str2: .string "%ld%ld%ld%ld"
    str3: .string "resultado %ld\n"
.section .text
.globl main

media_inteira:

    movq %rcx, %rax
    addq %rdx, %rax
    addq %rsi, %rax
    addq %rdi, %rax

    movq $4, %rbx
    movq $0, %rdx
    idivq %rbx
    ret

main: 
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq $str1, %rdi
    call printf
    
    movq %rbp, %rax
    subq $32, %rax
    movq %rax, %r8

    movq %rbp, %rax
    subq $24, %rax
    movq %rax, %rcx
    
    movq %rbp, %rax
    subq $16, %rax
    movq %rax, %rdx
    
    movq %rbp, %rax
    subq $8, %rax
    movq %rax, %rsi
    
    movq $str2, %rdi
    call scanf

    movq -32(%rbp), %rcx
    movq -24(%rbp), %rdx
    movq -16(%rbp), %rsi
    movq -8(%rbp), %rdi

    call media_inteira

    movq %rax, %rsi

    movq $str3, %rdi
    call printf

    addq $32, %rsp
    popq %rbp
    movq $60, %rax
    syscall
    
