.section .data
a: .long 0
i: .long 0
s: .long 0
.section .text
.globl _start
_start:
	movl $0, s
	movl $1, a
#for
	movl $1, i
_for:
	cmpl $10, i
	jg _end_for
	movl s, %eax
	addl a, %eax
	movl %eax, s
	incl a
	incl i
	jmp _for
_end_for:
	movl a, %edi
	movq $60, %rax
	syscall
