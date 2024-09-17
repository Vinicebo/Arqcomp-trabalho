/*
Prática 4 - Conhecendo o Arduíno 2560
Circuito utilizando a placa do Arduíno 2560 utilizando três chaves.
As chaves indicam entradas binárias: 000, 0001, 010, ..., 111. A saída de cada chave conecta em uma entrada do Arduíno (2, 3, 4).
Conforme a palavra do código de entrada, o programa realiza uma função específica.
Prof. Clayton J A Silva
Disciplina Arquitetura de Computadores
*/


/*
O sketch deve ler a palavra código de entrada.
Caso a palavra corresponda a um número par: o sistema deverá ler
via monitor serial um número inteiro; calcular a soma dos números
pares não negativos inferiores ao número lido; e escrever o resultado
no monitor serial.


O sketch deve ler a palavra código de entrada. O sistema deverá
apresentar uma contagem binária crescente cíclico no monitor serial
a partir do código lido até 111. O contador cíclico se repete.
Por exemplo, se for lido 011, o sistema deverá
gerar 011-100-101-110-111-011-100-101...
*/


#define I0 2 // define a macro relativa a entrada (pino) 2 - em cada pino um LED
#define I1 3
#define I2 4


int converteDecimal(int b0, int b1, int b2) {
  //  int decimal = 0;
  //  decimal = b0 + b1 * 2 + b2 * 4; // Conversão pela notação polinomial
   return b0 + b1 * 2 + b2 * 4; // Retorna o valor calculado para o codigo que chama a funcao
}


void setup(){
   pinMode(I0,INPUT);  // Configura os pinos I0, I1 e I2 como entrada
   pinMode(I1,INPUT);
   pinMode(I2,INPUT);
   Serial.begin(9600); // Abre a porta serial, define a taxa de dados de comunicação serial para 9600 bps
}


void loop(){
   int a, b, c, saida; // Declara as variáveis internas a funcao loop
   a = digitalRead(I0); // Le a entrada e atribui o valor lido a variavel
   b = digitalRead(I1);
   c = digitalRead(I2);
   saida = converteDecimal(a,b,c); // A variavel saida recebe o valor da funcao converteDecimal
   Serial.println(saida,DEC);  // Escreve o valor armazenado na variavel na saida serial
   delay(3000); // Pausa o programa em 3000 milissegundos
   if (saida % 2 == 0) {
    Serial.println("é par, digite um numero");
    while (Serial.available() == 0) {
     
    }
    int numero = Serial.parseInt();
    while (Serial.available() > 0) {
      Serial.read(); // Limpa o buffer para evitar caracteres residuais
    }
    Serial.print("A soma dos números inferiores é: ");
    int soma = 0;
    do {
      if (numero > 0) {
        numero = numero - 2;
        soma = numero + soma;
      }
    } while (numero > 0);
    Serial.print("A soma é "); Serial.println(soma);
   }
}

