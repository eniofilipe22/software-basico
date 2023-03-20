.section .data
a: .long 0
i: .long 0
s: .long 0

.section .text
.globl _start
_start:

movl $1, a
movl $1, i
movl i, %eax
movl $10, %ebx
movl s, %ecx
movl a, %edx
loop:
cmp %ebx, %eax
jg fimloop
add $1, %eax
add %edx, %ecx
add $1, %edx
jmp loop
fimloop: 

movlq %ecx, %rdi
movq $60, %rax
syscall