.section .data
vetor: .quad 17,4,6,2,9,10,13,3,5,80
i: .quad 0
maior: .quad 0

.section .text
.globl _start
_start:

	movq $0, %rdi
	movq vetor(,%rdi,8), %rax
	movq %rax, maior	# maior = vetor[0]
	movq $1, i
_for:    			# for(i=1;i<10;i++))
	cmpq $10, i
	jge _end_for    #if( maior < vetor[i])
	movq i, %rdi
	movq vetor(,%rdi,8), %rax
	cmpq maior, %rax
	jle _end_if
				# maior = vetor[i]	
	movq %rax, maior
_end_if:
	incq i
	jmp _for
_end_for:	
	movq maior, %rdi
	movq $60, %rax
	syscall
