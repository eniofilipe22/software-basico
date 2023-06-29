.section .data
palavra: .string "casasssa"
quantidade: .quad 0
caracter: .byte 'c'
i: .quad 0

.section .text
.globl _start
_start:
	movq i, %rdi
	movb palavra(,%rdi,1), %al
	cmpb $0, %al
    je _fim
    
        cmpb caracter, %al
        jne _fim_if
            incq quantidade
        _fim_if:

    incq i
    jmp _start
_fim:
    movq quantidade, %rdi
	movq $60, %rax
	syscall