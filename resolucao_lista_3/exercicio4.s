.section .data
a: .byte 255
b: .word 7
c: .word 10
d: .long 0 
r: .quad 0
.section .text
.globl _start
_start:
	movb a, %al        # al = 255
	movzbl %al, %eax   # eax = 255
	movl %eax, d       # d = 255
	movl $20, %ebx     # ebx = 20
	idivl %ebx         # edx = eax(255) % ebx(20) = 15
	movw b, %ax
	addw c, %ax       #ax = ax(b) + c
	movswl %ax, %eax
	subl %edx, %eax   # eax = eax(b+x) - edx(d%20)

	movl %eax, %edi
	movq $60, %rax
	syscall
