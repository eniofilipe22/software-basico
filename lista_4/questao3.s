.section .data
a: .byte 0
b: .byte 0

.section .text
.globl _start
_start:

movb $3, a
cmpb $1, a
je caseum 
cmpb $2, a
je casedois
cmpb $3, a
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
movzbq b, %rdi
movq $60, %rax
syscall