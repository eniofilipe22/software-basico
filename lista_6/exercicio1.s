.section .data
    str1: .string "Digite quatro numeros: "
    str2: .string "%ld%ld%ld%ld"
    str3: .string "Os numeros digitados foram %ld-%ld-%ld-%ld\n"
.section .text
.globl main

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

    movq -32(%rbp), %r8
    movq -24(%rbp), %rcx
    movq -16(%rbp), %rdx
    movq -8(%rbp), %rsi

    movq $str3, %rdi
    call printf

    addq $32, %rsp
    popq %rbp
    movq $60, %rax
    syscall
    
