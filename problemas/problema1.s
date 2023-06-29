.section .data
vetor: .quad 1,1,1,1,3,2
i: .quad 0
soma: .quad 0
.section .text
.globl _start
_start:

	movq $0, %rdi
	movq vetor(,%rdi,8), %rax
	movq %rax, soma	# soma = vetor[0]
	movq $1, i
_for:    			# for(i=1;i<10;i++))
	cmpq $6, i
	jge _end_for   
	movq i, %rdi
	movq vetor(,%rdi,8), %rax
	addq soma, %rax
    movq %rax, soma
	incq i
	jmp _for
_end_for:	
	movq soma, %rdi
	movq $60, %rax
	syscall