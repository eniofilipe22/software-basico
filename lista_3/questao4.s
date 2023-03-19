.section .data
a: .byte 255
b: .word 7
c: .word 10
d: .long 0
r: .quad 0

.section .text
.globl _start
_start:

movb a, %al
movzbl %al, %eax
movl %eax, d
movl $20, %ebx
idivl %ebx 
movw b, %ax
addw c, %ax
movswl %ax, %eax
subl %edx, %eax

movl %eax, %edi
movq $60, %rax
syscall