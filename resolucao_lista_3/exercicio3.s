.section .data
a: .word 7
b: .word 10
c: .word 15
r: .long 0
.section .text
.globl _start
_start:
	movw c, %ax    # ax = 15
	idivw b        # rx = 15%10 = 5
	movw %dx, %ax  # ax = dx = 5
	imulw a        # ax = ax * a
	movswq %ax, %rdi
	movq $60, %rax
	syscall
