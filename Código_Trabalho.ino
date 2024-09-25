// Buzzer não precisa de resistor
//Led RGB

const int azul = 11;
const int verde = 12;
const int vermelho = 13;

int PinTrigger = 28; // Pino usado para disparar os pulsos do sensor
int PinEcho = 30; // pino usado para ler a saida do sensor
float TempoEcho = 0;
const float VelocidadeSom_mpors = 340; // em metros por segundo
const float VelocidadeSom_mporus = 0.000340; // em metros por microsegundo


//Led vermelho "A"
#define ledA 6

//Led amarelo "B"
#define ledB 7

// Led azul "C"
#define ledC 8

//Buzzer
#define buz 9

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
#define C_modo 24


void desligarLed(int led) {
  digitalWrite(led, LOW);
}

void ligarLed(int led) {
  digitalWrite(led, HIGH);
}


void ligarVermelhoRGB() {
  digitalWrite(azul, HIGH);
  digitalWrite(verde, HIGH);
  digitalWrite(vermelho, LOW);
}

void ligarAzulRGB() {
  digitalWrite(azul, LOW);
  digitalWrite(verde, HIGH);
  digitalWrite(vermelho, HIGH);
}

void ligarVerdeRGB() {
  digitalWrite(azul, HIGH);
  digitalWrite(verde, LOW);
  digitalWrite(vermelho, HIGH);
}

void ligarBuzzer() {
  tone(buz, 50);
}

void desligarBuzzer() {
  tone(buz, 0);
}

void lerTemperatura() {

}

void lerDistancia() {
  // Para fazer o HC-SR04 enviar um pulso ultrassonico, nos temos
  // que enviar para o pino de trigger um sinal de nivel alto
  // com pelo menos 10us de duraçao
  digitalWrite(PinTrigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(PinTrigger, LOW);

  float TempEcho = pulseIn(PinEcho, HIGH);

  float distancia = ((TempEcho*VelocidadeSom_mporus)/2)*100;

  Serial.println("A distância em centímetros é:");
  Serial.println(distancia);
}

void lerLuz(){

}

void setup() {
  Serial.begin(9600);
  pinMode(azul, OUTPUT);
  pinMode(verde, OUTPUT);
  pinMode(vermelho, OUTPUT);
  pinMode(ledA, OUTPUT);
  pinMode(ledB, OUTPUT);
  pinMode(ledC, OUTPUT);
  pinMode(buz, OUTPUT);

  // Configura pino de Trigger como saída e inicializa com nível baixo
  pinMode(PinTrigger, OUTPUT);
  digitalWrite(PinTrigger, LOW);
  pinMode(PinEcho, INPUT); // configura pino ECHO como entrada
}

void loop() {
  // put your main code here, to run repeatedly:
  int BIT1, BIT2, BIT3, BIT4;
  BIT1 = digitalRead(C1);
  BIT2 = digitalRead(C2);
  BIT3 = digitalRead(C3);
  BIT4 = digitalRead(C4);

  int modo = digitalRead(C_modo);

  if (modo == 0) {
    if ((BIT1 == 0) && (BIT2 == 0) && (BIT3 == 0) && (BIT4 == 0)) {
      ligarLed(ledA);
    }

    if ((BIT1 == 0) && (BIT2 == 0) && (BIT3 == 0) && (BIT4 == 1)) {
      desligarLed(ledA);
    }

    if ((BIT1 == 0) && (BIT2 == 0) && (BIT3 == 1) && (BIT4 == 0)) {
      ligarLed(ledB);
    }

    if ((BIT1 == 0) && (BIT2 == 0) && (BIT3 == 1) && (BIT4 == 1)) {
      desligarLed(ledB);
    }

    if ((BIT1 == 0) && (BIT2 == 1) && (BIT3 == 0) && (BIT4 == 0)) {
      ligarBuzzer();
    }

    if ((BIT1 == 0) && (BIT2 == 1) && (BIT3 == 0) && (BIT4 == 1)) {
      desligarBuzzer();
    }

    if ((BIT1 == 0) && (BIT2 == 1) && (BIT3 == 1) && (BIT4 == 0)) {
      lerTemperatura();
    }

    if ((BIT1 == 0) && (BIT2 == 1) && (BIT3 == 1) && (BIT4 == 1)) {
      lerDistancia();
    }

    if ((BIT1 == 1) && (BIT2 == 0) && (BIT3 == 0) && (BIT4 == 0)) {
      lerLuz();
    }

    if ((BIT1 == 1) && (BIT2 == 0) && (BIT3 == 0) && (BIT4 == 1)) {
      ligarVermelhoRGB();
    }

    if ((BIT1 == 1) && (BIT2 == 0) && (BIT3 == 1) && (BIT4 == 0)) {
      ligarVerdeRGB();
    }

    if ((BIT1 == 1) && (BIT2 == 0) && (BIT3 == 1) && (BIT4 == 1)) {
      ligarAzulRGB();
    }

    if ((BIT1 == 1) && (BIT2 == 1) && (BIT3 == 0) && (BIT4 == 0)) {
      ;
    }

    if ((BIT1 == 1) && (BIT2 == 1) && (BIT3 == 0) && (BIT4 == 1)) {
      ;
    }

    if ((BIT1 == 1) && (BIT2 == 1) && (BIT3 == 1) && (BIT4 == 0)) {
      ligarLed(ledC);
    }

    if ((BIT1 == 1) && (BIT2 == 1) && (BIT3 == 1) && (BIT4 == 1)) {
      desligarLed(ledC);
    }
  }

  if (modo == 1) {
    String comando;

    while (Serial.available() == 0) {

    }

    comando = Serial.readString();
    comando.trim();

    if (comando == "INICIO_PROG") {
      while (comndo != "FIM_PROG") {
        while (Serial.available() == 0) {

        }

        comando = Serial.readString();
        comando.trim();
        Serial.println(comando);


        if (comando == "LED_ON A") {
          ligarLed(ledA);
        }

        if (comando == "LED_OFF A") {
          desligarLed(ledA);
        }
        
        if (comando == "LED_ON B") {
          ligarLed(ledB);
        }
        
        if (comando == "LED_OFF B") {
          desligarLed(ledB);
        }
        
        if (comando == "BUZZ_ON") {
          ligarBuzzer();
        }
        
        if (comando == "BUZZ_OFF") {
          desligarBuzzer();
        }
        
        if (comando == "TEMP_READ A") {
          lerTemperatura();
        }
        
        if (comando == "DIST_CHECK A") {
          lerDistancia();
        }
        
        if (comando == "PRES_READ A") {
          lerLuz();
        }
        
        if (comando == "RGB_SET_COLOR A RED") {
          ligarVermelhoRGB();
        }
        
        if (comando == "RGB_SET_COLOR A GREEN") {
          ligarVerdeRGB();
        }
        
        if (comando == "RGB_SET_COLOR A BLUE") {
          ligarAzulRGB();
        }
        
        if (comando == "FIM_PROG") {
          break;
        }
        
        if (comando == "LED_ON C") {
          ligarLed(ledC);
        }
        
        if (comando == "LED_ON C") {
          ligarLed(ledC);
        }


        else {
        Serial.println("Comando inválido.");
        }
      }
    }
  }
  delay(1000);
}
