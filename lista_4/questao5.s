.section .data
a: .long 0
i: .long 0
s: .long 0

.section .text
.globl _start
_start:

movl $1, a
movl $1, i
movl s, %ecx
loop:
movl i, %ebx
cmp $10, %ebx
jg fimloop

movl a, %eax
movl $2, %ebx
movl $0, %edx
idivl %ebx
cmp $0, %edx
jne fimif

add a, %ecx

fimif:
movl i, %ebx
add $1, %ebx
movl %ebx, i
movl a, %eax
add $1, %eax
movl %eax, a

jmp loop

fimloop: 

movslq %ecx, %rdi
movq $60, %rax
syscall