.section .data
    format_str: .string "%d"    # Formato de string para leitura dos inteiros
    sum:        .quad 0        # Variável para armazenar a soma dos inteiros

.section .text
.globl main

main:
    # Inicializar registradores

    # Ler o primeiro inteiro
    movq 8(%rsp), %rdi    # Endereço do primeiro argumento
    movq (%rdi), %rax     # Ler o valor do primeiro inteiro
    addq %rax, sum        # Adicionar o valor à variável de soma

    # Ler o segundo inteiro
    movq 16(%rsp), %rdi   # Endereço do segundo argumento
    movq (%rdi), %rax     # Ler o valor do segundo inteiro
    addq %rax, sum        # Adicionar o valor à variável de soma

    # Ler o terceiro inteiro
    movq 24(%rsp), %rdi   # Endereço do terceiro argumento
    movq (%rdi), %rax     # Ler o valor do terceiro inteiro
    addq %rax, sum        # Adicionar o valor à variável de soma

    # Chamar a função de impressão
    call print_int

exit:
    # Encerrar o programa
    movl $60, %eax
    syscall

print_int:
    # Sub-rotina para impressão do inteiro

    # Salvando registradores

    # Configurar argumentos para a função 'printf'
    movq $format_str, %rdi
    movq %rax, %rsi

    call printf

    # Restaurar registradores
  

    # Retornar para a chamada
    ret


movq $9, quantidade
	movq $8, %rax
	imulq quantidade
	movq %rax, tamanho

	subq tamanho, %rsp
	
	subq quantidade, %rsp
	movq %rbp, %rax
	subq tamanho, %rax
	movq %rax, (%rsp)

	call leitura_total
	addq quantidade, %rsp

	
	movq quantidade, %rdx
	movq $0, %rsi
	movq %rbp, %rax
	subq tamanho, %rax
	movq %rax, %rdi
	
	call quicksortv2
	
	// call imprime_string_aqui

	subq quantidade, %rsp
	movq %rbp, %rax
	subq tamanho, %rax
	movq %rax, (%rsp)

	call imprime_tudo
	addq quantidade, %rsp

	exit_main:

	movq $SYS_close, %rax
	movq %r8, %rdi
	syscall
