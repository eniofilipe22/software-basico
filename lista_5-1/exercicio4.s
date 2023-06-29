.section .data
a: .long 5
b: .long 5
z: .long 5
x: .long 5
y: .long 5
w: .long 5
k: .long 5

.section .text
.globl _start

_quadrado:
	
	movl %edi, %eax
	imul %edi
	
	
	ret

_cubo:
	
	
	movl %edi, %eax
	imul %edi
	imul %edi

	
	ret

_expressao:
	
	
	movl %edi, %eax
	addl %esi, %eax
	addl %edx, %eax
	addl %ecx, %eax

	movl $4, %ebx
	movl $0, %edx
	idiv %ebx
	
	
	ret

_start:
	pushq %rbp
	movq %rsp, %rbp
	subq $4, %rsp

	movl a, %edi
	call _quadrado
	movl %eax, -4(%rbp)

	movl b, %edi
	call _cubo
	addl %eax, -4(%rbp)

	movl x, %edi
	movl y, %esi
	movl w, %edx
	movl k, %ecx
	call _expressao
	addl %eax, -4(%rbp)

	movl z, %eax
	movl $0, %edx
	idivl k
	addl %eax, -4(%rbp)

	movl -4(%rbp), %edi 
	
	addq $4, %rsp
	popq %rbp
	movq $60, %rax
	syscall
	