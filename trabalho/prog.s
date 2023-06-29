
## Software Básico
## Ênio Filipe Miranda Souza
## Programa que lê uma lista de número de um arquivo de entrada, ordena e salva a lista
## ordenada em um arquivo de saída


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
	quantidade: .quad 0
	negative: .byte 0
	complemento: .quad 0	
	contador: .quad 0
	endereco_init_rbp: .quad 0
	num_aux: .quad 0
	cond_particionar: .quad 0
	tamanho: .quad 0

.section .bss
.lcomm line, STRLEN_LINE
.lcomm segundo_argumento, STRLEN_LINE
.lcomm terceiro_argumento, STRLEN_LINE
.lcomm string_aux, 256
.lcomm string_convert, 256
.lcomm caracter, 1

.section .text
.globl main

## 
## funções responsáveis por ler os argumentos da linha de comando
##
le_primeiro_argumento:
	## 
	## nessa função, a leitura já é feita convertendo a string pra número 
	##
	pushq %rax
	pushq %rsi
	pushq %rbx
	pushq %rcx
	pushq %r8

	movq %rsi, %rcx
	addq $8, %rcx
	movq (%rcx), %rcx

	movq $0, %rax

	while_primeiro_argumento:
	movb (%rcx), %bl
	cmpb $0, %bl
	je final_while_primeiro_argumento 
	movzbq %bl, %r8
	movq $10, %rdx
	imul %rdx
	subq $48, %r8
	addq %r8, %rax
	incq %rcx
	jmp while_primeiro_argumento
	final_while_primeiro_argumento:

	movq %rax, quantidade

	popq %r8
	popq %rcx
	popq %rbx
	popq %rsi
	popq %rax
ret

le_segundo_argumento:

	pushq %rax
	pushq %rsi
	pushq %rbx
	pushq %rcx

	movq %rsi, %rax
	addq $16, %rax
	movq (%rax), %rax
	
	movq $0, %rcx

	while_segundo_argumento:
	movb (%rax), %bl
	cmpb $0, %bl
	je final_while_segundo_argumento
	movb %bl, segundo_argumento(%rcx)
	incq %rcx
	incq %rax
	jmp while_segundo_argumento
	final_while_segundo_argumento:

	popq %rcx
	popq %rbx
	popq %rsi
	popq %rax
ret

le_terceiro_argumento:

	pushq %rax
	pushq %rsi
	pushq %rbx
	pushq %rcx

	movq %rsi, %rax
	addq $24, %rax
	movq (%rax), %rax
	
	movq $0, %rcx

	while_terceiro_argumento:
	movb (%rax), %bl
	cmpb $0, %bl
	je final_while_terceiro_argumento
	movb %bl, terceiro_argumento(%rcx)
	incq %rcx
	incq %rax
	jmp while_terceiro_argumento
	final_while_terceiro_argumento:

	popq %rcx
	popq %rbx
	popq %rsi
	popq %rax
ret

#------------------------- QUICK SORT V2 --------------------------
quicksort:
## void quicksort(int number[25],int first,int last){
	# %rdi number
	# %rsi first
	# %rdx/%r8 last

	pushq %rdi
	pushq %rsi
	pushq %rdx
	movq %rdx, %r8
	pushq %r8

##    int i, j, pivot, temp;

	# %r9 pivot
	# %rcx i
	# %rbx j

	pushq %rax
	pushq %rcx
	pushq %rbx

	pushq %r9
	pushq %r10
	pushq %r11
	pushq %r12

##    if(first<last){
	cmpq %rsi, %r8
	jle fim_if_quicksort
##       pivot=first;
		movq %rsi, %r9
##       i=first;
		movq %rsi, %rcx
##       j=last;
		movq %r8, %rbx
##       while(i<j){
		primeiro_while_quicksort:
		cmpq %rcx, %rbx
		jle fim_primeiro_while_quicksort

##          while(number[i]<=number[pivot]&&i<last)
			segundo_while_quicksort:
			cmpq %rcx, %r8
			jle fim_segundo_while_quicksort
			movq $8, %rax
			imulq %rcx
			addq %rdi, %rax
			movq (%rax), %r10
			movq $8, %rax
			imulq %r9
			addq %rdi, %rax
			movq (%rax), %rax
			cmpq %r10, %rax
			jl fim_segundo_while_quicksort
##          i++;
				incq %rcx
			jmp segundo_while_quicksort
			fim_segundo_while_quicksort:

##          while(number[j]>number[pivot])
			terceiro_while_quicksort:
			movq $8, %rax
			imulq %rbx
			addq %rdi, %rax
			movq (%rax), %r10
			movq $8, %rax
			imulq %r9
			addq %rdi, %rax
			movq (%rax), %rax
			cmpq %r10, %rax
			jge fim_terceiro_while_quicksort
##          j--;
				decq %rbx
			jmp terceiro_while_quicksort
			fim_terceiro_while_quicksort:
##          if(i<j){
			cmpq %rcx, %rbx
			jle fim_segundo_if_quicksort
##             temp=number[i];
				movq $8, %rax
				imulq %rcx
				addq %rdi, %rax
				movq (%rax), %r10

				movq %rax, %r11
##             number[i]=number[j];
				movq $8, %rax
				imulq %rbx
				addq %rdi, %rax
				movq (%rax), %r12
				movq %r12, (%r11)
##             number[j]=temp;
				movq %r10, (%rax)
##          }
			fim_segundo_if_quicksort:
##       }
		jmp primeiro_while_quicksort
		fim_primeiro_while_quicksort:
##       temp=number[pivot];
		movq $8, %rax
		imulq %r9
		addq %rdi, %rax
		movq %rax, %r10
		movq (%r10), %r11
##       number[pivot]=number[j];
		movq $8, %rax
		imulq %rbx
		addq %rdi, %rax
		movq (%rax), %r12
		movq %r12, (%r10)
##       number[j]=temp;
		movq %r11, (%rax)
##       quicksort(number,first,j-1);
		movq %rbx, %r10
		
		pushq %r10
		pushq %r8

		decq %rbx
		
		movq %rbx, %rdx
		
		call quicksort

		popq %r8
		popq %r10
		
##       quicksort(number,j+1,last);
		incq %r10		
		movq %r10, %rsi
		movq %r8, %rdx
		call quicksort
	fim_if_quicksort:
##    }
## }

	popq %r12
	popq %r11
	popq %r10
	popq %r9
	popq %rbx
	popq %rcx
	popq %rax

	popq %r8
	popq %rdx
	popq %rsi
	popq %rdi
	
ret

#------------------------------------------------------------------
## 
## funções responsáveis por inicializar buffers com 0 em todas as posições
##
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

## 
## função responsável por converter número pra string
##
convert_num_to_string:
	pushq	%rbp
	movq	%rsp, %rbp
	subq $8, %rsp
	movq %rdi, -8(%rbp)
	
	## 
	## inicializa string principal e auxiliar, com 0 em todas as posições, pra evitar sobreposições
	##
	call inicialiar_string_aux
	call inicialiar_string_convert

	movq -8(%rbp), %rax
	movq $0, %rcx #contador

	## 
	## pra cada iteração, dividimos o valor atual por 10, pegamos o resto, somamos 48 
	## e adicionamos na posição da respectiva iteração na string auxiliar
	## no final, teremos o número invertido
	## 1234-> /10 -> 4 
	##		123/10 -> 3 -> 43
	##		12/10 -> 2 -> 432
	##		1/10 -> 1 -> 4321
	##

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

	##	
	##	aqui fazemos a troca das posições, para enfim termos a string correspondente ao número inicial
	##	salva em string_convert
	##	4321 -> 1234
	##

	swap_string:
	
	movq $0, %rax #contador string final
	movb $10, string_convert(%rcx)
	swap_string_loop:
	decq %rcx
	cmpq $0, %rcx
	jl exit_convert_string
	movb string_aux(%rax), %dl
	movb %dl, string_convert(%rcx)
	incq %rax
	jmp swap_string_loop
	

	exit_convert_string:
	
	incq %rax
	addq $8, %rsp
	popq %rbp
	ret


## 
## função responsável por abrir o arquivo de entrada
##
f_abreArquivoInput:
	movq $SYS_open, %rax 			
	movq $segundo_argumento, %rdi
	mov	$O_RDWR, %rsi				
	movq $S_MODE, %rdx
	syscall

	mov %rax, %r8

	ret

## 
## função responsável por abrir o arquivo de saída
##
f_abreArquivoOutput:
	movq $SYS_open, %rax 			
	movq $terceiro_argumento, %rdi
	movq $O_RDWR, %rsi
	movq $S_MODE, %rdx
	syscall

	mov %rax, %r8

	ret

## 
## função responsável por imprimir uma linha no arquivo
##
f_imprimir_linha_arquivo:
	
	mov $SYS_write, %rax
	mov %r8, %rdi
	mov $string_convert, %rsi
	mov %rcx, %rdx
	syscall
	
	ret

## 
## função responsável por ler um caracter do arquivo
##
f_lerCaracter:
	mov $0, %rax
	mov %r8, %rdi
	mov $caracter, %rsi
	mov $1, %rdx
	syscall
	
	ret

## 
## função responsável por ler cada linha do arquivo e salvar no buffer line
##
f_lerCadeiaCaracteres:	

	## 
	## inicializa o buffer line com 0 em todas as posições para evitar sobreposição
	##
	call inicialiar_line
	movq $0, %rbx
	
	## 
	## fazemos a leitura caracter por caracter, inserimos na posição correspondente em line, até encontrar o \n
	##
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



## 
## função responsável por converter um string (line) em long int
##
f_converterCadeiaCaracteresLongLong: 
	movq $0, %rax
	movq $0, %rdi

	movq $line, %rbx

	movb (%rbx), %dl
	cmpb $45, %dl 
    jne conversao

    movb $1, negative
    incq %rbx
	## 
	## para cada caracter, se subtrai 48, achando o seu correspondente númerico
	## ex: 1 em ASCII é a quantidade 49 
	##     então pra encontrar 1, devemos subtrair 49 - 48 = 1
	##   
	##  para cada vez que iteramos, multiplicamos o resultado encontrado anterior por 10
	##	e somamos com o encontrado atualmente
	##  1234 -> 1 
	##			1 * 10 + 2
	##			12 * 10 + 3
	##			123 *10 + 4 = 1234
	##
    conversao:
		
		movb (%rbx), %dl
        cmpb $10, %dl
        je fim_conversao		
        movzbq %dl, %r9
        subq $48, %r9
        movq $10, %rcx
        imulq %rcx
        addq %r9, %rax        

		incq %rbx
        jmp conversao
    fim_conversao:

    cmpb $1, negative
    jne nao_nega
    negq %rax

    nao_nega:
	movq $0, negative
	ret



## 
## função responsável por ler cada número do array ordenado, transformar em string e salvar no arquivo
## 
imprime_tudo:
	pushq %rbp
	movq %rsp, %rbp

	call f_abreArquivoOutput

	#----------------------------------------
	movq $0, contador
	#
	# pra cada número, é chamada a função convert_num_to_string e f_imprimir_linha_arquivo
	#
	init_imprime_tudo_for:
	movq quantidade, %rax
	cmpq %rax,contador
	jg exit_imprime_tudo

	movq 16(%rbp), %rbx
	movq contador, %rcx
    movq (%rbx, %rcx, 8),%rax

	movq %rax, %rdi
	call convert_num_to_string

	movq %rax, %rcx
	call f_imprimir_linha_arquivo

	incq contador
	jmp init_imprime_tudo_for
	#----------------------------------------
	exit_imprime_tudo:
	popq %rbp
	ret


## 
## função responsável por ler cada número do arquivo, transformar em long int e salvar num array
## 
leitura_total:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp

	#--------------------------
	call f_abreArquivoInput

	movq %rax, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdx, -32(%rbp)

	movq $0, contador

	#
	# pra cada linha do arquivo, é chamada a função f_lerCadeiaCaracteres e f_converterCadeiaCaracteresLongLong
	#
	init_for_leitura:
	movq quantidade, %rax
	incq %rax
	cmpq %rax,contador
	jg exit_leitura
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
	movq 16(%rbp), %rbx
	movq contador, %rcx
    movq %rax, (%rbx, %rcx, 8)
	
	incq contador
	jmp init_for_leitura
	#-------------------------
	exit_leitura:

	addq $32, %rsp
	popq %rbp
	ret

main:
	pushq	%rbp
	movq	%rsp, %rbp

	## LEITURA DE ARGUMENTOS
	call le_primeiro_argumento

	call le_segundo_argumento

	call le_terceiro_argumento

	
	## ALOCA QUANTIDADE DE ESPAÇO RELATIVO AO TAMANHO PASSADO NO 1º ARGUMENTO, PARA ARRAY DE NùMEROS
	movq $8, %rax
	imulq quantidade
	movq %rax, tamanho
	subq tamanho, %rsp
	
	decq quantidade

	## LEITURA DO ARQUIVO DE ENTRADA, CONVERSÃO DE STRING EM NÚMERO E SALVAMENTO NO ARRAY
	subq quantidade, %rsp
	movq %rbp, %rax
	subq tamanho, %rax
	movq %rax, (%rsp)

	call leitura_total
	addq quantidade, %rsp

	
	## ORDENAMENTO DO ARRAY DE NÚMEROS
	movq quantidade, %rdx
	movq $0, %rsi
	movq %rbp, %rax
	subq tamanho, %rax
	movq %rax, %rdi
	
	call quicksort
	
	## CONVERSÃO DE CADA NÚMERO DO ARRAY EM STRING E ESCRITA NO ARQUIVO DE SAÍDA
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

	popq 	%rbp
	movq 	$SYS_exit, %rax
	syscall