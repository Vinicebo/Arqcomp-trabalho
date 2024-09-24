// Para facilitar o seu trabalho já existe uma bilioteca que pode ser baixada neste link. Após o download descompacte o arquivo .zip e mova-o para a pasta arduinosketchfolder/libraries/ e reinicie a IDE do Arduino. Não retire o arquivo dht.cpp.  e não esqueça de renomear a pasta para “DHT”. Talvez será necessário criar uma sub-pasta da biblioteca caso não exista.

// Agora acesse Examples->DHT->DHTtester em sua IDE Arduino

// https://www.makerhero.com/blog/monitorando-temperatura-e-umidade-com-o-sensor-dht11/
// https://github.com/adafruit/DHT-sensor-library

#include "DHT.h"
 
#define DHTPIN A1 // pino que estamos conectado
#define DHTTYPE DHT11 // DHT 11
 
// Conecte pino 1 do sensor (esquerda) ao +5V
// Conecte pino 2 do sensor ao pino de dados definido em seu Arduino
// Conecte pino 4 do sensor ao GND
// Conecte o resistor de 10K entre pin 2 (dados) 
// e ao pino 1 (VCC) do sensor
DHT dht(DHTPIN, DHTTYPE);
 
void setup() 
{
  Serial.begin(9600);
  Serial.println("DHTxx test!");
  dht.begin();
}
 
void loop() 
{
  // A leitura da temperatura e umidade pode levar 250ms!
  // O atraso do sensor pode chegar a 2 segundos.
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  // testa se retorno é valido, caso contrário algo está errado.
  if (isnan(t) || isnan(h)) 
  {
    Serial.println("Failed to read from DHT");
  } 
  else
  {
    Serial.print("Umidade: ");
    Serial.print(h);
    Serial.print(" %t");
    Serial.print("Temperatura: ");
    Serial.print(t);
    Serial.println(" *C");
  }
}




// Código do sensor preto (LM35, já testamos na faculdade e funcionou)


//Sensor de temperatura usando o LM35
 
const int LM35 = A0; // Define o pino que lera a saída do LM35
#define LM35 A0
float temperatura; // Variável que armazenará a temperatura medida
 
//Função que será executada uma vez quando ligar ou resetar o Arduino
void setup() {
  Serial.begin(9600); // inicializa a comunicação serial
}
 
//Função que será executada continuamente
void loop() {
  temperatura = (float(analogRead(LM35))*5/(1023))/0.01;
  Serial.print("Temperatura: ");
  Serial.println(temperatura);
  delay(2000);
}
