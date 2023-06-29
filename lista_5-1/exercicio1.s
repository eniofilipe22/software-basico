.section .data
.section .text
.globl _start

_quantidade_pares: 
	pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

	movl $0, -4(%rbp)
	movl $0, -8(%rbp)

	loop:
	movl -4(%rbp), %edi
	cmp 24(%rbp), %edi
	je fim_loop
	movq 16(%rbp), %rbx
	movl (%rbx, %rdi, 4), %eax
	movl $2, %ebx
	movl $0, %edx
	idivl %ebx
	cmp $0, %edx
	jne fim_if
	incl -8(%rbp)
	fim_if:
	incl -4(%rbp)
	jmp loop
	fim_loop:
	movl -8(%rbp), %eax
	addq $8, %rsp
	popq %rbp
	ret

_start: 
    pushq %rbp
    movq %rsp, %rbp
    subq $44, %rsp

    movl $-8, -40(%rbp)
	movl $1, -36(%rbp)
	movl $4, -32(%rbp)
	movl $23, -28(%rbp)
	movl $12, -24(%rbp)
	movl $67, -20(%rbp)
	movl $98, -16(%rbp)
	movl $2, -12(%rbp)
	movl $5, -8(%rbp)
	movl $9, -4(%rbp)

	subq $4, %rsp
	movl $10, (%rsp)
	subq $8, %rsp
	movq %rbp, %rax
	subq $40, %rax
	movq %rax, (%rsp)

	call _quantidade_pares
	addq $12, %rsp
	movl %eax, -44(%rbp)
	movl -44(%rbp), %edi
	addq $44, %rsp
	popq %rbp
	movq $60, %rax
	syscall