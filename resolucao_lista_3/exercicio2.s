.section .data
a: .byte -7
b: .byte 10
r: .long 0
.section .text
.globl _start
_start:
	movb $2, %al    # al = 2
	imulb b         # ax = b * 2
	movsbw a, %bx	# bx = -7
	subw %ax, %bx   # ax = ax - bx
	movswq %bx, %rdi 
	movq $60, %rax
	syscall
