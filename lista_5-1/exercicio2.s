.section .data
.section .text
.globl _start

_maior_elemento:
    pushq %rbp
    movq %rsp, %rbp
    subq $12, %rsp

    movl $1, -4(%rbp) # i
    movq 16(%rbp), %rax
    movq $0, %rbx
    movq (%rax,%rbx,8), %rax
    movq %rax, -12(%rbp) # maior

    loop:
        movl -4(%rbp), %edi
        cmp 24(%rbp), %edi
        je fim_loop
        movq 16(%rbp), %rax
        movq (%rax,%rdi,8), %rax
        cmp -12(%rbp), %rax
        jle fim_if
        movq %rax, -12(%rbp)
        
        fim_if:

        incl -4(%rbp)
        jmp loop

        fim_loop:

        movq -12(%rbp), %rax
        addq $12, %rsp
        popq %rbp
        ret

_start: 
    pushq %rbp
    movq %rsp, %rbp
    subq $88, %rsp

    movq $-8, -80(%rbp)
	movq $1, -72(%rbp)
	movq $4, -64(%rbp)
	movq $23, -56(%rbp)
	movq $12, -48(%rbp)
	movq $67, -40(%rbp)
	movq $98, -32(%rbp)
	movq $2, -24(%rbp)
	movq $5, -16(%rbp)
	movq $9, -8(%rbp)

	subq $4, %rsp
	movl $10, (%rsp)
	subq $8, %rsp
	movq %rbp, %rax
	subq $80, %rax
	movq %rax, (%rsp)

	call _maior_elemento
	addq $12, %rsp
	movq %rax, -88(%rbp)
	movq -88(%rbp), %rdi
	addq $88, %rsp
	popq %rbp
	movq $60, %rax
	syscall