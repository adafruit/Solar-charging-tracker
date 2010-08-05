/* Sensor test sketch
  for more information see http://www.ladyada.net/make/logshield/lighttemp.html
  */

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(2, 3, 4, 5, 6, 7 );

#define aref_voltage 3.3         // we tie 3.3V to ARef and measure it with a multimeter!

int lipoPin = 3;      // the battery 
float lipoMult = 1.666;  // how much to multiply to get the original voltage

int PVPin = 2;      // the cell
float PVMult = 2;  // how much to multiply to get the original voltage

int currentPin = 1;
float currentMult = 208; // how much to multiply to get the original current draw
    
void setup(void) {
  // We'll send debugging information via the Serial monitor
  Serial.begin(9600);   
  
  // set up the LCD's number of rows and columns: 
  lcd.begin(16, 2);
  lcd.clear();
  // Print a message to the LCD.
  lcd.print("Solar logger");
  delay(2000);
  lcd.clear();
  // If you want to set the aref to something other than 5v
  analogReference(EXTERNAL);
}


void loop(void) {
  int adcreading;
 
  adcreading = analogRead(lipoPin);  
  Serial.println(adcreading);
  
  float lipoV = adcreading;
  lipoV *= aref_voltage;
  lipoV /= 1024;
  lipoV *= lipoMult;

  lcd.clear();
  Serial.print("LiPo voltage = ");
  Serial.println(lipoV);     // the raw analog reading
  
  lcd.setCursor(0, 0);
  lcd.print("LiPo = ");
  lcd.print(lipoV);
     
  adcreading = analogRead(PVPin);  
  float PVV = adcreading;
  PVV *= aref_voltage;
  PVV /= 1024;
  PVV *= PVMult;
  Serial.print("PV voltage = ");
  Serial.println(PVV);     // the raw analog reading

  lcd.setCursor(0, 1);
  lcd.print("PV=");
  lcd.print(PVV);
  
  adcreading = analogRead(currentPin);  
  float currentI = adcreading;
  currentI *= aref_voltage;
  currentI /= 1024;
  currentI *= currentMult;
  Serial.print("Current (mA) = ");
  Serial.println(currentI);     // the raw analog reading

  lcd.print(" I=");
  lcd.print(currentI);
  
  delay(1000);
}

