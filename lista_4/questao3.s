.section .data
a: .byte 0
b: .byte 0

.section .text
.globl _start
_start:

movb $3, a
movb a, %al
cmp $1, %al
je caseum 
cmp $2, %al
je casedois
cmp $3, %al
jne fimswitch

casetres:
movb $30, b
jmp fimswitch

caseum:
movb $10, b
jmp fimswitch

casedois:
movb $20, b

fimswitch:
movsbq b, %rdi
movq $60, %rax
syscall