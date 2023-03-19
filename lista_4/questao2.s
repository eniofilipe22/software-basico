.section .data
a: .quad 0
n: .quad 0

.section .text
.globl _start
_start:

movq $15, a
movq a, %rax
movq $2, %rbx
idivq %rbx
cmp $0, %rdx
jne else 
movq $0, n
je fimif
else:
movq $1, n
fimif:
movq n, %rdi
movq $60, %rax
syscall