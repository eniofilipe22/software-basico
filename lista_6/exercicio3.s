.equ STDOUT, 1
.equ SYS_WRITE, 1
.equ SYS_EXIT, 60
.section .data
total: .quad 0
a: .quad 5
b: .quad 5
z: .quad 5
x: .quad 5
y: .quad 5
w: .quad 5
k: .quad 5
str: .string "Ola mundo!\n"
strLen: .quad 11
.section .bss
.section .text
.globl main

_quadrado:
	
	movq %rdi, %rax
	imul %rdi

	ret

_cubo:

	
	movq %rdi, %rax
	imul %rdi
	imul %rdi

	
	ret

_expressao:
	
	movq %rdi, %rax
	addq %rsi, %rax
	addq %rdx, %rax
	addq %rcx, %rax

	movq $4, %rbx
	movq $0, %rdx
	idiv %rbx
	
	
	ret

main:
	pushq %rbp
	movq %rsp, %rbp
	

    // movq (%rsi), %rax
    // // movq %rax, a
    
    // // movq %rsi, %rax
    // // addq $8, %rax
    // // movq (%rax), %rax

    movq $SYS_WRITE, %rax
    movq $STDOUT, %rdi
    movq $str, %rsi
    movq strLen, %rdx

    syscall
    // movq (%rsi), %rax

    // movq (%rax), %rdi
    // movq (%rsi), %rax
    // movq %rax, b
    // movq a, %rdi
    // addq $8, %rsi
    // movq (%rsi), %rax
    // movq %rax, z
    // addq $8, %rsi
    // movq (%rsi),%rax
    // movq %rax, x
    // addq $8, %rsi
    // movq (%rsi),%rax
    // movq %rax,  y
    // addq $8, %rsi
    // movq (%rsi), %rax
    // movq %rax, w
    // addq $8, %rsi
    // movq (%rsi), %rax
    // movq %rax, k

	// movq a, %rdi
	// call _quadrado
	// movq %rax, total

	// movq b, %rdi
	// call _cubo
	// addq %rax, total

	// movq x, %rdi
	// movq y, %rsi
	// movq w, %rdx
	// movq k, %rcx
	// call _expressao
	// addq %rax, total

	// movq z, %rax
	// movq $0, %rdx
	// idivq k
	// addq %rax, total

	// movq total, %rdi 
	
	
	popq %rbp
	movq $60, %rax
	syscall
	