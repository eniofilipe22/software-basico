.section .data
a: .long 0
i: .long 0
s: .long 0
.section .text
.globl _start
_start:
	movl $0, s
	movl $1, i
	movl $1, a
_while:
	cmpl $10, i
	jg _end_while
		movl $2, %ebx
		movl a, %eax
		movl $0, %edx
		idivl %ebx
		cmpl $0, %edx
		jne _end_if
		movl s, %eax
		addl a, %eax
		movl %eax, s
_end_if:
	incl a
	incl i
	jmp _while
_end_while:
	movl s, %edi
	movq $60, %rax
	syscall
