.section .data
.section .text
.globl main

main:
	pushq %rbp
	movq %rsp, %rbp

	#quantidade de parametros
	#movq %rdi, %rax # exibir no terminal
		

	#argv[0]
	#movq %rsi, %rax
	#movq (%rax), %rax
	#addq $3, %rax
	#movq (%rax), %rax

	#argv[1]         #testado com ./exe ABC DE      A(65)B(66)C(67)
	movq %rsi, %rax
	addq $8, %rax	
	movq (%rax),%rax
	addq $0, %rax    #testado com ./exe ABC DE      A(65)B(66)C(67)0 %rdi = 65
	#addq $1, %rax    #testado com ./exe ABC DE       A(65)B(66)C(67)0 %rdi = 66
	#addq $2, %rax    #testado com ./exe ABC DE       A(65)B(66)C(67)0 %rdi = 67
	#addq $3, %rax    #testado com ./exe ABC DE       A(65)B(66)C(67)0 %rdi = 0
	movb (%rax), %al

	#argv[2]         #testado com ./exe ABC DE      A(65)B(66)C(67)
        #movq %rsi, %rax
        #addq $16, %rax
        #movq (%rax),%rax
        #addq $0, %rax    #testado com ./exe ABC DE       D(68)E(69)0 %rdi = 68
       	#addq $1, %rax    #testado com ./exe ABC DE       D(68)E(69)0 %rdi = 69
        #addq $2, %rax    #testado com ./exe ABC DE       D(68)E(69)0 %rdi = 0
        #movb (%rax), %al

	

	popq %rbp
	movq %rax, %rdi
	movq $60, %rax
	syscall