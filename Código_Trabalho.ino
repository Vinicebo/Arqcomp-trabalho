// Buzzer não precisa de resistor
//Led RGB

const int azul = 11;
const int verde = 12;
const int vermelho = 13;

//Led vermelho "A"
#define ledR 9

//Led amarelo "B"
#define ledY 10

//Buzzer
#define buz 8

// Sensor de temperatura
#define temp A0

//Chaves Binárias

#define C1 2

#define C2 3

#define C3 4

#define C4 5

// Chave de "Enter"
#define enter 22

// Chave de seleção
#define selec 24

void desligarLedRED(led){

  digitalWrite(led,LOW)
}


void ligarLed(led){

  digitalWrite(led,HIGH)
}



void vermelhoFuncaoRGB(){
  digitalWrite(azul, LOW);
  digitalWrite(verde, LOW);
  digitalWrite(vermelho, HIGH);
}

void azulFuncaoRGB(){
  digitalWrite(azul, HIGH);
  digitalWrite(verde, LOW);
  digitalWrite(vermelho, LOW);
}

void verdeFuncaoRGB(){
  digitalWrite(azul, LOW);
  digitalWrite(verde, HIGH);
  digitalWrite(vermelho, LOW);
}

void setup() {
    Serial.begin(9600);
    pinMode(azul, OUTPUT);
    pinMode(verde, OUTPUT);
    pinMode(vermelho, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

}
