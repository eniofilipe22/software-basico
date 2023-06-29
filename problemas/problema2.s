.section .data
palavra: .string "casasssas"
tamanho: .quad 0

.section .text
.globl _start
_start:
	movq tamanho, %rdi
	movsbq palavra(,%rdi,1), %rax
	cmpq $0, %rax
    je _fim
    incq tamanho
    jmp _start
_fim:
    movq tamanho, %rdi
	movq $60, %rax
	syscall