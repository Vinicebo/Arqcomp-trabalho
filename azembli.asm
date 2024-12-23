
; Mateus de Macedo Coelho Sachinho - 202403184672 - TA
; Vinícius da luz - 202402159216 - TA
; Eduardo Barros Peruzzo - 202401000833 - TA
; Pedro dos Santos Carlos da Silva - 202401000493 - TA
; Gabriel Corrêa da Silveira - 202401639702 - TA


.def contador = r16
.def aux = r17
.def aux2 = r18
.def valor = r19
.def flag = r20
.def flag2 = r21
.def flag3 = r22
.def flag4 = r23
.def entrada = r24
.def flag5 = r25

clr r16									; R16 como 0 para configurar os pinos como entrada
out DDRA, r16							; Configura todos os pinos de PORTA como entrada

clr r16									; R16 como 0 para configurar os pinos como entrada
out DDRB, r16							; Configura todos os pinos de PORTB como entrada

ldi r16,0xFF							; R16 como FF para configurar os pinos como saída
out DDRC, r16							; Configura todos os pinos de PORTC como saída

; ================================== CRIANDO TABELA ASCII =========================================================================
inicio:
	ldi aux,0x1b						; Carrega o valor de ESC no registrador aux (r17)
	sts 0x200,aux						; Armazena o valor ESC (que está no registrador aux) no endereço de memória 
	ldi aux,0x20						; Carrega o valor do espaço em branco no registrador aux
	sts 0x201,aux						; Armazena o valor do espaço em branco (que está no registrador aux) no endereço de memória 
	ldi valor,0x41						; Armazena o valor 41 (A em hexadecimal na tabela ASCII) no registrador valor (r19)
	ldi flag,0x1a						; Armazena o valor 1a (26 em decimal, cobre todas as letras do alfabeto) no registrador flag (r18)

	ldi r27,0x02 
	ldi r26,0x02						; O ponteiro x começará a partir do endereço de memória 0x202

	loop_maiusculas: inc contador		; Incrementa o registrador contador (r16) em 1
		st x,valor						; Armazena o valor do registrador valor (r19) (41, A em hexadecimal na tabela ASCII) no endereço 0x202
		inc valor						; Incrementa o valor do registrador valor (r19) (42, B em hexadecimal na tabela ASCII) em 1
		inc r26							; Incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x203)
		cp contador,flag				; Compara o registrador contador (r16) (atualmente 1) com o registrador flag (r18) (26)
		brne loop_maiusculas			; Continua o loop se o registrador contador (r16) não ficou igual ao registrador flag (r18) (26)

	ldi contador,0						; O valor do registrador contador (r16) será 0
	ldi valor,0x61						; Armazena o valor 61 (a em hexadecimal na tabela ASCII) no registrador valor (r19)

	loop_minusculas: inc contador		; Incrementa o registrador contador (r16) em 1
		st x,valor						; Armazena o valor do registrador valor (r19) (61, a em hexadecimal na tabela ASCII) no endereço 0x21C
		inc valor						; Incrementa o valor do registrador valor (r19) (62, b em hexadecimal na tabela ASCII) em 1
		inc r26							; Incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x21D)
		cp contador,flag				; Compara o registrador contador (r16) (atualmente 1) com o registrador flag (r18) (26)
		brne loop_minusculas			; Continua o loop se o registrador contador (r16) não ficou igual ao registrador flag (r18) (26)

	ldi contador,0						; O valor do registrador contador (r16) será 0
	ldi valor,0x30						; Armazena o valor 30 (0 em hexadecimal na tabela ASCII) no registrador valor (r19)
	ldi flag,0xA						; Armazena o valor A (10 em decimal, cobre todos os números de 0 á 10) no registrador flag (r20)

	loop_digitos: inc contador			; Incrementa o registrador contador (r16) em 1
		st x,valor						; Armazena o valor do registrador valor (r19) (30, 0 em hexadecimal na tabela ASCII) no endereço 0x236
		inc valor						; Incrementa o valor do registrador valor (r19) (31, 1 em hexadecimal na tabela ASCII) em 1
		inc r26							; Incrementa o valor do registrador r26 em 1 (assim o endereço de memória do ponteiro x será 0x237)
		cp contador,flag				; Compara o registrador contador (r16) (atualmente 1) com o registrador flag (r20) (10)
		brne loop_digitos				; Continua o loop se o registrador contador (r16) não ficou igual ao registrador flag (r20) (10)

; ================================== CRIANDO TABELA ASCII =========================================================================


; ================================== LEITURA DO COMANDO PELA PORTA DE ENTRADA =====================================================
ldi flag,0x1c							; Carrega o valor 0x1C no registrador flag (r20), usado como comando para iniciar a escrita de dados
ldi flag2,0x1d							; Carrega o valor 0x1D no registrador flag2 (r21), usado como comando para calcular o total da tabela
ldi flag3,0x1e							; Carrega o valor 0x1E no registrador flag3 (r22), usado como comando para contar caracteres
ldi flag5,0x1f

ler_comando:
    in r0,porta							; Lê um valor da porta A e armazena em r0
    cp r0,flag							; Compara o registrador r0 com o registrador flag (r20) (0x1c)
    breq escrever_dado					; Se o registrador r0 for igual ao registrador flag (r20) (0x1c), salta para escrever_dado
    cp r0,flag2							; Compara o registrador r0 com o registrador flag2 (r21) (0x1d)
    breq total_tabela					; Se o registrador r0 for igual ao registrador flag2 (r21) (0x1d), salta para total_tabela
    cp r0,flag3							; Compara o registrador r0 com o registrador flag3 (r22) (0x1e)
    breq contar_char					; Se o registrador r0 for igual ao registrador flag3 (r22) (0x1e), salta para contar_char
	cp r0,flag5							; Compara o registrador r0 com o registrador flag5 (r25) (0x1f)
	breq fim1							; Se o registrador r0 for igual ao registrador flag5 (r25) (0x1f), salta para o fim do código
    rjmp ler_comando					; Se nenhum comando for reconhecido, salta para ler_comando

; ================================== LEITURA DO COMANDO PELA PORTA DE ENTRADA =====================================================


; ================================== CRIAÇÃO DA TABELA DE SEQUÊNCIA DE CARACTERES =====================================================
escrever_dado:
    ldi r29,0x03						
    ldi r28,0x00						; O ponteiro y começará a partir do endereço de memória 0x0300

    ldi aux,0x1b						; Carrega o valor ASCII para <ESC> no registrador aux (r17)
    ldi aux2,0xff						; Carrega o valor 0xFF no registrador aux2 (r18), usado para verificar o limite do espaço de memória

	leitura:
		in entrada,portb				; Lê um valor da porta B e armazena no registrador entrada (r23)
		cp entrada,aux					; Compara o registrador entrada (r23) com ao registrador aux (r17) (0x1b) (<ESC>)
		breq criaTabelaF1				; Se o registrador entrada (r23) for igual ao registrador aux (r17) (0x1b) (<ESC>), salta para ler_comando

		verificaChar:
			ldi r27, 0x02				; O ponteiro x começará a partir do endereço de memória 0x201
			ldi r26, 0x01

			loopVerificar:
				ld valor,x				; Carrega o valor do endereço atual de X para o registrador valor (r19)
				cpi valor,0x00			; Compara o valor carregado com 0x00 (fim da tabela)
				breq leitura			; Se for 0x00, volta para leitura
				cp valor,entrada		; Compara o valor lido com o valor atual da tabela
				breq valido				; Se o valor for válido, salta para a rotina valido
				inc r26					; Incrementa a parte baixa do ponteiro X
				rjmp loopVerificar		; Continua verificando o próximo valor na tabela

			valido:
				st y,entrada			; Armazena o valor lido no endereço apontado por Y
				out portc,entrada		; Apresenta operação na porta de saída
				cp r28,aux2				; Compara a parte baixa de Y com 0xFF para verificar o limite de memória
				breq criaTabelaF1		; Se o limite for atingido, retorna para ler_comando
				inc r28					; Incrementa a parte baixa do ponteiro Y
				rjmp leitura			; Continua lendo o próximo valor

; ================================== CRIAÇÃO DA TABELA DE SEQUÊNCIA DE CARACTERES =====================================================


; ================================== CONTAR TOTAL DE CARACTERES DA TABELA =============================================================
total_tabela:
	ldi r27, 0x03						
    ldi r26, 0x00						; O ponteiro x começará a partir do endereço de memória 0x300
	ldi contador,0x00					; Carrega o registrador contador (r16) com 0x00 (fim da tabela)

	loopContar:
		ld valor,x						; Carrega o valor do endereço atual de X para o registrador valor (r19)
		inc r26							; Incrementa o valor do registrador r26 em 1
		cpi valor,0x00					; Compara o valor do endereço x com 0x00 (fim da tabela), caso seja, termina a contagem
		breq resultado					; Se o valor do endereço x for igual a 0x00 (fim da tabela), salta para resultado
		cpi valor,0x20					; Compara o valor do endereço x com 0x20 (espaço em branco)
		breq loopContar					; Se o valor do endereço x for igual a 0x20 (espaço em branco), salta para loop contar
		inc contador					; Incrementa o registrador contador (20) em 1
		cpi r26,0xFF					; Checa se o ponteiro já está na última posição possível da tabela
		breq checarUltimo				; Se for o último endereço, salta para a checagem final
		rjmp loopContar					; Salta para LoopContar
			
	checarUltimo:						; Na checagem final, checa se o último valor é um caractere ou um espaço em branco, e o armazena se necessário
		ld valor,x
		cpi valor,0x00
		breq resultado
		cpi valor,0x20
		breq resultado
		inc contador
		rjmp resultado

	resultado:
		sts 0x401,contador				; Armazena o valor do registrador contador (r16) no endereço 0x401
		out portc,contador				; Escreve o valor do registrador contador (r16) na portc

		rjmp ler_comando				; Salta para ler_comando

; ================================== CONTAR TOTAL DE CARACTERES DA TABELA =============================================================

fim1:
	rjmp fim			; Atalho para o fim, pois o programa não consegue reconhecer o fim devido à distância

criaTabelaF1:
	rjmp criaTabelaF

; ================================== CONTAR QUANTOS DE UM CARACTERE TEM NA TABELA =====================================================
contar_char:
    in entrada,portb				; Lê um valor da porta B e armazena no registrador entrada (r23)

	verificaChar2:
		ldi r27, 0x02				; O ponteiro x começará a partir do endereço de memória 0x201
		ldi r26, 0x01				; O ponteiro x começará a partir do endereço de memória 0x201

		loopVerificar2:
			ld valor,x				; Carrega o valor do endereço atual de X para o registrador valor (r19)
			cpi valor,0x00			; Compara o registrador valor (r19) com o valor 0x00 (fim da tabela)
			breq contar_char		; Se o registrador valor (r19) for igual ao valor 0x00 (fim da tabela), salta para conta_chat
			cpi entrada,0x20		; Compara o valor do registrador entrada (r23) com 0x20 (espaço em branco)
			breq contar_char		; Se o valor do registrador entrada (r23) for igual a 0x20 (espaço em branco), salta para conta_char
			cp valor,entrada		; Compara o valor do endereço x com o registrador entrada (r23)
			breq valido2			; Se o valor do endereço x for igual o registrador entrada (r23), salta para valido2
			inc r26					; Incrementa a parte baixa do ponteiro X em 1
			rjmp loopVerificar2		; Salta para loopVerificar2

		valido2:
			ldi r27,0x03
			ldi r26,0x00				; O ponteiro x começará a partir do endereço de memória 0x300
			ldi contador,0x00			; Carrega o contador (r16) com 0x00 (fim da tabela)

			verificarTabela:
				ld valor,x				; Carrega o valor do endereço atual de X para o registrador valor (r19)
				inc r26					; Incrementa o valor (r19) em 1
				cp valor,entrada		; Compara o endereço atual de X com o valor do registrador entrada (r23)
				breq igual				; Se o valor do endereço x for igual o registrador entrada (r23), salta para igual
				cpi valor,0x00			; Compara o endereço atual de X com 0x00 (fim da tabela)
				breq resultado2			; Se o endereço atual de X for igal a 0x00 (fim da tabela), salta para resultado2
				rjmp verificarTabela	; salta para verificarTabela

			igual:
				inc contador			; Incrementa o registrador (r20) em 1
				rjmp verificarTabela	; Sallta para verificarTabela

			resultado2:
				sts 0x402,contador
				out portc,contador		; Apresenta operação na porta de saída

				rjmp ler_comando		; Salta para ler_comando

; ================================== CONTAR QUANTOS DE UM CARACTERE TEM NA TABELA =====================================================

; ================================== CRIAÇÃO DA TABELA DE CARACTERES FREQUENTES =======================================================
criaTabelaF:
    ldi r26, 0x00                  ; Ponteiro X para 0x300 (parte baixa)
    ldi r27, 0x03                  ; Ponteiro X para 0x300 (parte alta)

    ldi r28, 0x03                  ; Ponteiro Y para tabela de frequências (parte baixa)
    ldi r29, 0x04                  ; Ponteiro Y para tabela de frequências (parte alta)

    clr contador                   ; Contador geral para frequências (zerado)
    clr aux                        ; Auxiliar para comparações

	contarFrequencias:
		ld valor, x                    ; Lê o caractere do endereço atual de X
		cpi valor, 0x00                ; Fim da tabela de sequência?
		breq ordenarFrequencias        ; Se sim, vá para a ordenação

		; Verifica se é um espaço em branco
		cpi valor, 0x20
		breq proximoCaractere

		; Procura o caractere na tabela de frequências
		ldi r30, 0x03                  ; Ponteiro Z para tabela de frequências (parte baixa)
		ldi r31, 0x04                  ; Ponteiro Z para tabela de frequências (parte alta)

	procurarTabela:
		ld aux, z                      ; Lê o caractere atual da tabela de frequências
		cpi aux, 0x00                  ; Tabela vazia ou fim dela?
		breq adicionarNovo             ; Adicione o caractere à tabela

		cp aux, valor                  ; Compara com o caractere atual
		breq incrementarFrequencia     ; Se igual, incremente a frequência
		adiw r30, 0x02                 ; Avança para o próximo caractere na tabela
		rjmp procurarTabela

	incrementarFrequencia:
		ldd aux, z+1                   ; Carrega a frequência
		inc aux                        ; Incrementa
		std z+1, aux                   ; Salva a nova frequência
		rjmp proximoCaractere

	adicionarNovo:
		st z, valor                    ; Armazena o novo caractere
		ldi aux, 0x01                  ; Primeira ocorrência
		std z+1, aux                   ; Armazena a frequência inicial
		rjmp proximoCaractere

	proximoCaractere:
		adiw r26, 0x01                 ; Incrementa o ponteiro X
		rjmp contarFrequencias


	ordenarFrequencias:
		ldi flag4, 0x0A                ; Número de elementos (10)
		clr aux                        ; Flag para monitorar trocas

		bubbleSort:						   ; Bubble Sort é um método de organização de lista que coloca o maior valor no começo por meio de sucessivas trocas
			clr aux                        ; Reseta flag de troca
			ldi r30, 0x03                  ; Parte baixa do ponteiro Z
			ldi r31, 0x04                  ; Parte alta do ponteiro Z

		loopOrdenacao:
			ldd valor, z+1                 ; Frequência atual
			ldd aux2, z+3                  ; Próxima frequência
			cp valor, aux2                 ; Compara frequências
			breq checagem					; Se forem iguais, checa o caso
			brlo troca                     ; Se necessário, troque

			continuar:
			adiw r30, 0x02                 ; Avança para o próximo par
			cp valor, aux2
			brne loopOrdenacao             ; Continua o loop

			cpi valor,0x00
			brne loopOrdenacao

			; Se nenhuma troca foi feita, terminamos
			cpi aux,0x00                   ; Verifica se houve troca
			breq fimOrdenacao              ; Se não houve troca, fim do sort
			rjmp bubbleSort                ; Caso contrário, repita o sort

		troca:
			ld aux, z                     ; Salva caractere atual
			ldd aux2, z+2                  ; Salva próximo caractere
			st z, aux2                    ; Troca caracteres
			std z+2, aux                   ; Troca caracteres

			ldd aux, z+1                   ; Salva frequência atual
			ldd aux2, z+3                  ; Salva próxima frequência
			std z+1, aux2                  ; Troca frequências
			std z+3, aux                   ; Troca frequências

			ldi aux, 0x01                  ; Marca que houve troca
			adiw r30, 0x02                 ; Avança para o próximo par
			rjmp loopOrdenacao

		checagem:
			cpi aux2,0x00					; Caso sejam iguais a 0x00, faz o check principal
			breq check1
		
			rjmp continuar					; Se não forem iguais a 0x00, continua a ordenação

			check1:
				cpi aux,0x00				; Caso não tenham havido trocas nessa iteração, termina a ordenação, caso haja, volta para o começo
				breq fimOrdenacao
				rjmp bubbleSort
			

	fimOrdenacao:
		ldi r30, 0x03                  ; Parte baixa do ponteiro Z
		ldi r31, 0x04                  ; Parte alta do ponteiro Z
		ldi aux, 0x00				   ; Preparando registrador auxiliar para armazenar 0x00

		limpa:
			; Iniciar processo de limpa, limpar todos os valores após o décimo caractere da tabela
			cpi flag4, 0x00
			breq excluir
			rjmp proxValor

			excluir:
				ld valor,z
				cpi valor,0x00
				breq terminar
				st z,aux
				std z+1,aux
				adiw r30, 0x02         ; Avança para o próximo par
				rjmp limpa

			proxValor:
				dec flag4
				ld valor,z
				cpi valor,0x00
				breq terminar
				adiw r30, 0x02         ; Avança para o próximo par
				rjmp limpa
		
		terminar:
			; Limpeza terminada, agora o programa deve exibir cada caractere da tabela na porta de saída
			ldi r31,0x04
			ldi r30,0x03

			loopExibir:
				ld valor,z
				cpi valor,0x00
				breq parar
				out portc,valor			; Apresenta o valor na porta de saída
				ldd valor,z+1
				out portc,valor			; Apresenta o valor na porta de saída
				adiw r30, 0x02         ; Avança para o próximo par
				rjmp loopExibir

			parar:
				rjmp ler_comando               ; Volta ao fluxo principal

; ================================== CRIAÇÃO DA TABELA DE CARACTERES FREQUENTES =======================================================

fim:
break          

