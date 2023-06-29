.section .data
a: .long 0
n: .long 0
.section .text
.globl _start
_start:
	
	movl $16, a
	movl a, %eax
	movl $2, %ebx
	idiv %ebx
	cmpl $0, %edx
	jne _else
	movl $2, n
	jmp _end_if
_else:
	movl $3, n
_end_if:

	movslq n, %rdi
	movq $60, %rax
	syscall
