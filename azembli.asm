; Mateus de Macedo Coelho Sachinho - 202403184672 - TA
; Vinícius da luz - 202402159216 - TA
; Eduardo Barros Peruzzo - 202401000833 - TA
; Pedro dos Santos Carlos da Silva - 202401000493 - TA
; Gabriel Corrêa da Silveira - 202401639702 - TA


.def entrada = r10
.def flag = r16
.def aux = r17
.def flag2 = r18
.def valor = r19
.def contador = r20
.def aux2 = r21
.def flag3 = r22

clr r16          ; R16 como 0 para configurar os pinos como entrada
out DDRA, r16    ; Configura todos os pinos de PORTA como entrada

clr r16          ; R16 como 0 para configurar os pinos como entrada
out DDRB, r16    ; Configura todos os pinos de PORTB como entrada

ldi r18,0xFF     ; R16 como FF para configurar os pinos como saída
out DDRC, r18    ; Configura todos os pinos de PORTC como saída

inicio:
	ldi aux,0x1b					;carrega o valor de ESC no registrador aux (r17)
	sts 0x200,aux					;armazena o valor ESC (que está no registrador aux) no endereço de memória 
	ldi aux,0x20					;carrega o valor do espaço em branco no registrador aux
	sts 0x201,aux					;armazena o valor do espaço em branco (que está no registrador aux) no endereço de memória 
	ldi valor,0x41					;armazena o valor 41 (A em hexadecimal na tabela ASCII) no registrador valor (r19)
	ldi flag,0x1a					;armazena o valor 1a (26 em decimal, cobre todas as letras do alfabeto) no registrador flag (r18)

	ldi r27,0x02 
	ldi r26,0x02					;o ponteiro x começará a partir do endereço de memória 0x202

	loop_maiusculas: inc contador	;incrementa o registrador contador (r20) em 1
		st x,valor						;armazena o valor do registrador valor (r19) (41, A em hexadecimal na tabela ASCII) no endereço 0x202
		inc valor						;incrementa o valor do registrador valor (r19) (42, B em hexadecimal na tabela ASCII) em 1
		inc r26							;incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x203)
		cp contador,flag				;compara o registrador contador (r20) (atualmente 1) com o registrador flag (r18) (26)
		brne loop_maiusculas			;continua o loop se o registrador contador (r20) não ficou igual ao registrador flag (r18) (26)

	ldi contador,0					;o valor do registrador contador (r20) será 0
	ldi valor,0x61					;armazena o valor 61 (a em hexadecimal na tabela ASCII) no registrador valor (r19)

	loop_minusculas: inc contador	;incrementa o registrador contador (r20) em 1
		st x,valor						;armazena o valor do registrador valor (r19) (61, a em hexadecimal na tabela ASCII) no endereço 0x21C
		inc valor						;incrementa o valor do registrador valor (r19) (62, b em hexadecimal na tabela ASCII) em 1
		inc r26							;incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x21D)
		cp contador,flag				;compara o registrador contador (r20) (atualmente 1) com o registrador flag (r18) (26)
		brne loop_minusculas			;continua o loop se o registrador contador (r20) não ficou igual ao registrador flag (r18) (26)

	ldi contador,0					;o valor do registrador contador (r20) será 0
	ldi valor,0x30					;armazena o valor 30 (0 em hexadecimal na tabela ASCII) no registrador valor (r19)
	ldi flag,0xA					; armazena o valor A (10 em decimal, cobre todos os números de 0 á 10) no registrador flag (r16)

	loop_digitos: inc contador		;incrementa o registrador contador (r20) em 1
		st x,valor						;armazena o valor do registrador valor (r19) (30, 0 em hexadecimal na tabela ASCII) no endereço 0x236
		inc valor						;incrementa o valor do registrador valor (r19) (31, 1 em hexadecimal na tabela ASCII) em 1
		inc r26							;incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x237)
		cp contador,flag				;compara o registrador contador (r20) (atualmente 1) com o registrador flag (r16) (10)
		brne loop_digitos				;continua o loop se o registrador contador (r20) não ficou igual ao registrador flag (r16) (10)

ldi flag,0x1c
ldi flag2,0x1d
ldi flag3, 0x1e

ler_comando:
	in r0,porta
	cp r0,flag
	breq escrever_dado
	cp r0,flag2
	breq total_tabela
	cp r0,flag3
	breq contar_char
	rjmp ler_comando

escrever_dado: 
	ldi r29,0x03					; inicializando ponteiro Y em 0x300
	ldi r28,0x00

	ldi aux,0x1b
	ldi aux2,0xff

	leitura:
		in entrada,portb
		cp entrada,aux
		breq ler_comando

		verificaChar:
			ldi r26, 0x01              ; Inicializa o ponteiro X para o endereço 0x201
			ldi r27, 0x02

			loopVerificar:
				ld valor,x
				cpi valor,0x00
				breq leitura
				cp valor,entrada
				breq valido
				inc r26
				rjmp loopVerificar

			valido:
				st y,entrada
				cp r28,aux2
				breq ler_comando
				inc r28
				rjmp leitura

total_tabela:


contar_char:

fim:
break
