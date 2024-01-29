#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <DHT.h>

#define FIREBASE_HOST "fourthyearproject-2468e-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "CSqOUwaSQ4xekncvmS09WdBKasXU9ANiZtvA6s6G"
#define WIFI_SSID "Epaulette"
#define WIFI_PASSWORD "Eppaulette"
#define DHTPIN D4
#define DHTTYPE DHT11

#define GREEN_LED_PIN D1
#define RED_LED_PIN D2

DHT dht(DHTPIN, DHTTYPE);

void setup()
{
  Serial.begin(9600);
  dht.begin();

  pinMode(GREEN_LED_PIN, OUTPUT);
  pinMode(RED_LED_PIN, OUTPUT);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }

  Serial.println();
  Serial.print("Connected");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop()
{
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t))
  {
    Serial.println(F("Failed to read from DHT sensor!"));

    // Blink the red LED to indicate failure
    blinkLED(RED_LED_PIN);
    return;
  }

  Serial.print("Humidity:");
  Serial.print(h);
  String fireHumid = String(h);

  Serial.print("%  Temperature:");
  Serial.print(t);
  Serial.println("°C ");
  String fireTemp = String(t);

  Firebase.setString("/DHT11/Humidity", fireHumid);
  Firebase.setString("/DHT11/Temperature", fireTemp);

  if (Firebase.failed())
  {
    Serial.print("Pushing /logs failed:");
    Serial.println(Firebase.error());

    // Blink the red LED to indicate failure
    blinkLED(RED_LED_PIN);
    return;
  }

  // Blink the green LED to indicate success
  blinkLED(GREEN_LED_PIN);

  // Delay before the next iteration
  delay(5000);
}

void blinkLED(int pin)
{
  for (int i = 0; i < 3; i++)
  {
    digitalWrite(pin, HIGH);
    delay(500);
    digitalWrite(pin, LOW);
    delay(500);
  }
}
