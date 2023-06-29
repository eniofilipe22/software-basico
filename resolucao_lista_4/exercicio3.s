.section  .data
a: .byte 0
b: .byte 0
.section .text
.globl _start
_start:

	movb $1, a


#case 1:
	cmpb $1, a
	jne _case2
	movb $10, b
	jmp _end_switch
_case2:
	cmpb $2, a
	jne _case3
	movb $20, b
	jmp _end_switch
_case3:
	cmpb $3, a
	jne _end_switch
	movb $30, b
_end_switch:

	movzbq b, %rdi	
	movq $60, %rax
	syscall
