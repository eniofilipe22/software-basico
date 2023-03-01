.section .data
a: .byte 0
b: .byte 0
r: .quad 0

.section .text
.globl _start
_start:

movb $7, a
movb $10, b
movb a, %al
movb b, %cl
negb %al
shlb $1, %cl
subb %cl, %al
movsbq %al, %rdi
movq $60, %rax
syscall