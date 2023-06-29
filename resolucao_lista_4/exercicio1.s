.section .data
a: .long 0
n: .long 0

.section .text
.globl _start
_start:
	
	movl $16, a
	movl $2, %ebx
	movl a, %eax
	idiv %ebx
	cmpl $0, %edx
	jne end_if	
	movl $3, n
end_if:
	movslq n, %rdi
	movq $60, %rax
	syscall
