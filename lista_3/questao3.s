.section .data
a: .word 0
b: .word 0
c: .word 0

.section .text
.globl _start
_start:

movw $7, a
movw $10, b
movw $15, c
movw a, %cx
movw b, %bx
movw c, %ax
div %bx
imulw %dx, %cx
movswq %cx, %rdi
movq $60, %rax
syscall