.equ STDIN, 0 			# standard input
.equ STDOUT, 1 			# standard output

.equ SYS_read, 0 		# read
.equ SYS_write, 1 		# write
.equ SYS_open,2 		# file open
.equ SYS_close,3 		# file close
.equ SYS_creat,85 		# file open/create

.equ O_RDONLY,0			# read only
.equ O_WDONLY,1			# write only
.equ O_RDWR,2			# read and write

.equ O_CREAT, 0100		
.equ O_TRUNC, 01000
.equ O_APPEND, 02000

.equ S_IWUSR, 0200		#proprietário, permissão para escrita
.equ S_IRUSR, 0400		#proprietário, permissão para leitura
.equ S_IXUSR, 0100		#proprietário, permissão para execução
.equ S_MODE,  0700

.equ SYS_exit, 60 		# terminate

.equ STRLEN_LINE, 256
.equ STRLEN_OUPUT, 17

.section .data
	enterMsgString: .string "Enter a String: "
	input_file: 	.string "input.txt"
	output_file: 	.string "output.txt"
	quantidade_string: .string "123"
	quantidade: .quad 0
	negative: .byte 0
	test_string: .string "espaco"
	string_numero: .string "%ld"
	contador: .quad 0
	endereco_init_rbp: .quad 0
	// vetor: .space 2

.section .bss
.lcomm line, STRLEN_LINE
.lcomm string_aux, 160
.lcomm string_convert, 160
.lcomm caracter, 1
.lcomm vetor, 1

.section .text
.globl main

inicialiar_line:

	movq $0, %rax
	init_for_initialize_line:
	cmpq $255, %rax
	je end_for_initialize_line
	movb $0, line(%rax)
	incq %rax
	end_for_initialize_line:        
	ret

inicialiar_string_aux:
	movq $0, %rax
	init_for_string_aux:
	cmpq $7, %rax
	je end_for_string_aux
	movb $0, string_aux(%rax)
	incq %rax
	end_for_string_aux:                
	ret

inicialiar_string_convert:
	movq $0, %rax
	init_for_string_convert:
	cmpq $7, %rax
	je end_for_string_convert
	movb $0, string_convert(%rax)
	incq %rax
	end_for_string_convert:                
	ret

imprime_string_convert:
	movq $1, %rax        # Número do sistema de chamada para write
    movq $1, %rdi        # Descritor de arquivo para saída padrão (stdout)
    movq $string_convert, %rsi   # Endereço da string de formato
    movq $40, %rdx       # Tamanho da string de formato
    syscall
	ret

imprime_string_aux:
	movq $1, %rax        # Número do sistema de chamada para write
    movq $1, %rdi        # Descritor de arquivo para saída padrão (stdout)
    movq $string_aux, %rsi   # Endereço da string de formato
    movq $40, %rdx       # Tamanho da string de formato
    syscall
	ret

imprime_string_caracter:
	movq $1, %rax        # Número do sistema de chamada para write
    movq $1, %rdi        # Descritor de arquivo para saída padrão (stdout)
    movq $caracter, %rsi   # Endereço da string de formato
    movq $1, %rdx       # Tamanho da string de formato
    syscall
	ret


convert_num_to_string:
	pushq	%rbp
	movq	%rsp, %rbp
	subq $8, %rsp
	movq %rdi, -8(%rbp)

	call inicialiar_string_aux
	call inicialiar_string_convert

	movq -8(%rbp), %rax
	movq $0, %rcx #contador

	convert_to_string:
	cmpq $0, %rax
	je swap_string

	movq $10, %rbx
	movq $0, %rdx
	idivq %rbx

	addb $48, %dl
	movb %dl, string_aux(%rcx)

	incq %rcx
	jmp convert_to_string


	swap_string:

	call imprime_string_convert
	// movq $0, %rax #contador string final
	// movb $10, string_convert(%rcx)
	// swap_string_loop:
	// decq %rcx
	// cmpq $0, %rcx
	// jl exit_convert_string
	// movb string_aux(%rax), %dl
	// movb %dl, string_convert(%rcx)
	// incq %rax
	// jmp swap_string_loop
	
	// exit_convert_string:

	incq %rax
	addq $8, %rsp
	popq %rbp
	ret





f_abreArquivoInput:
	movq $SYS_open, %rax 			
	movq $output_file, %rdi
	// movq $O_CREAT, %rsi
	mov	$O_RDWR, %rsi				
	movq $S_MODE, %rdx
	syscall

	mov %rax, %r8

	ret

f_lerCaracter:
	mov $0, %rax
	mov %r8, %rdi
	mov $caracter, %rsi
	mov $1, %rdx
	syscall
	
	ret

f_lerCadeiaCaracteres:	

	// call inicialiar_line
	movq $0, %rbx
	
	leitura_caracteres:

	call f_lerCaracter
	cmpq $0, %rax
	je exit_lerCadeiaCaracteres
	mov $caracter, %rcx
	movb (%rcx), %al
	cmpq $0, %rbx
	jne case_not_zero
	movb %al, line
	jmp fim_case_zero
	case_not_zero:
	movb %al, line(%rbx)
	fim_case_zero:

	mov $caracter, %rcx	
	cmpb $10, (%rcx)	
	je exit_lerCadeiaCaracteres
	incq %rbx
	jmp leitura_caracteres

	exit_lerCadeiaCaracteres:
	ret


f_converterCadeiaCaracteresLongLong: 
	movq $0, %rax
	movq $0, %rdi

	cmpb $45, line 
    jne conversao

    movb $1, negative
    incq %rdi

    conversao:
        cmpb $10, line(%rdi)
        je fim_conversao

        movq line(%rdi), %rbx
        subq $48, %rbx
        movq $10, %rcx
        imulq %rcx
        addq %rbx, %rax        

        incq %rdi
        jmp conversao
    fim_conversao:

    cmpb $1, negative
    jne nao_nega
    negq %rax

    nao_nega:
	ret


main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq $64, %rsp
	

	movq %rbp, endereco_init_rbp
	subq $48, endereco_init_rbp

	// LEITURA DO ARQUIVO E LEITURA DOS NUMEROS
	call f_abreArquivoInput

	movq %rax, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdx, -32(%rbp)


	init_for_leitura:
	
	movq -8(%rbp), %rax
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rsi 
	movq -32(%rbp), %rdx

	call f_lerCadeiaCaracteres

	movq %rax, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdx, -32(%rbp)

	call f_converterCadeiaCaracteresLongLong

	movq %rax, %rsi

	



	// call convert_num_to_string
	// movq %rax, %rcx
    
    // call imprime_string_convert

	// movq $8, %rcx
	// imulq contador, %rcx
	// addq endereco_init_rbp, %rcx
	// movq %rax, (%rcx)

	incq contador
	cmpq $4, contador
	jl init_for_leitura

	// movq contador, %rdi

	// ESCRITA DOS NUMEROS

	// TRANSFORMAR CADA NUMERO DO VETOR EM CARATERE E IMPRIMIR	

	// movq $0, contador
	// imprime_numeros_na_tela:

	// movq $8, %rcx
	// imulq contador, %rcx
	// addq endereco_init_rbp, %rcx
	// mov (%rcx), %rdi

	// call convert_num_to_string
	// movq %rax, %rcx
    
    // call imprime_string_convert

	// incq contador
	// cmpq $4, contador
	// jl imprime_numeros_na_tela

	
	// call f_lerCadeiaCaracteres

	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output 		
	// movq $line, %rsi  # string address
	// movq $STRLEN_OUPUT, %rdx	# length value
	// syscall

	// movq %rsi, %rdi
	// addq $8, %rdi
	// movq (%rdi), %edi

	// call retorna_parametro
	// movq $quantidade_string, %rdi
	// call f_converterCadeiaCaracteresLongLong
	
	// movq %rax, %rbx

	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output 		
	// movq $quantidade_string, %rsi  # string address
	// movq $STRLEN_OUPUT, %rdx	# length value
	// syscall

	
	


	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output 		
	// movq $caracter, %rsi  # string address
	// movq $STRLEN_OUPUT, %rdx	# length value
	// syscall

	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8
	// inc %r8

	// call f_lerCadeiaCaracteres
	// mov $caracter, %rcx
	// movb (%rcx), %al
	// movq $1, %rcx
	// movb %al, line(%rcx)
	
	// call f_lerCadeiaCaracteres
	// mov $caracter, %rcx
	// mov $line, %rax
	// add $16, %rax
	// mov %rcx, (%rax)
	
	// call f_lerCadeiaCaracteres
	// mov $caracter, %rcx
	// mov $line, %rax
	// add $24, %rax
	// mov %rcx, (%rax)

	// call f_lerCadeiaCaracteres
	// mov $caracter, %rcx
	// mov $line, %rax
	// mov %rcx, 5(%rax)
	// call f_lerCadeiaCaracteres
	
	// call f_lerCadeiaCaracteres

	// call f_lerCadeiaCaracteres
	
	// call f_lerCadeiaCaracteres

	// mov $caracter, %rcx	
	// cmpb $10, (%rcx)	
	// je imprime_outro

	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output 		
	// movq $caracter, %rsi  # string address
	// movq $STRLEN_OUPUT, %rdx	# length value
	// syscall
	// jmp exit_main

	// imprime_outro:
	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output 		
	// movq $test_string, %rsi  # string address
	// movq $STRLEN_OUPUT, %rdx	# length value
	// syscall

	

	// movq $SYS_read, %rax		# system code for read()
	// movq $STDIN, %rdi			# standard input
	// movq $line, %rsi   			# string address
	// movq $STRLEN_LINE, %rdx		# length value
	// syscall
	
	// movq $SYS_write, %rax		# system code for write()
	// movq $STDOUT, %rdi			# standard output
	// movq $line, %rsi			# string address
	// movq $STRLEN_LINE, %rdx		# length value
	// syscall
	
	// movq 	$SYS_open, %rax 			# file open/create
	// movq 	$input_file, %rdi
	// movq 	$O_CREAT, %rsi
	// orq 	$O_WDONLY, %rsi				# write
	// movq	$S_MODE, %rdx
	// syscall # return file descriptor in %rax

	// movq  	%rax, %rdi			# file descriptor
	// movq 	$SYS_write, %rax	# system code for write()
	// movq 	$line, %rsi			# string address
	// movq 	$STRLEN_LINE, %rdx	# length value
	// syscall

	exit_main:

	movq $SYS_close, %rax
	movq %r8, %rdi
	syscall

	popq 	%rbp
	movq 	$SYS_exit, %rax
	syscall