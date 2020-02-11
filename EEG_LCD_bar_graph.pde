// improved LCD display of MindFlex EEG data

// include the LCD and Brain libraries
#include <LiquidCrystal.h>
#include <Brain.h>

// activate and configure the LCD
LiquidCrystal lcd(12, 11, 10, 5, 4, 3, 2);
int backLight = 13;

// create the custom characters for the LCD bar-graphs
uint8_t custom_0[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f}; //1 bar
uint8_t custom_1[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f}; //2 bar
uint8_t custom_2[8] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x1f}; //3 bar
uint8_t custom_3[8] = { 0x00, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x1f, 0x1f}; //4 bar (half)
uint8_t custom_4[8] = { 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f}; //5 bar
uint8_t custom_5[8] = { 0x00, 0x00, 0x1f, 0x1F, 0x1F, 0x1F, 0x1F, 0x1f}; //6 bar
uint8_t custom_6[8] = { 0x00, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1f}; //7 bar
uint8_t custom_7[8] = { 0x1f, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1f}; //8 bar (full)

// activate the Brain serial port connection
Brain brain(Serial);

// configure variables for the EEG data
byte signalStrength = 0;
unsigned long deltaEnergy = 0;
unsigned long alphaEnergy = 0;
unsigned long betaEnergy = 0;
unsigned long thetaEnergy = 0;

// configure remainders for bar graph
int remSigStrength = 0;
int remDelta = 0;
int remAlpha = 0;
int remBeta = 0;
int remTheta = 0;

void setup(){
  // activate the LCD and set up the LCD backlight
  pinMode(backLight, OUTPUT);
  digitalWrite(backLight, HIGH);
  lcd.begin(16, 2);
  lcd.print("ready...");
  
  // define the custom characters for the LCD controlled
  lcd.createChar(0, custom_0); //send the custom characters to the LCD
  lcd.createChar(1, custom_1);
  lcd.createChar(2, custom_2);
  lcd.createChar(3, custom_3);
  lcd.createChar(4, custom_4);
  lcd.createChar(5, custom_5);
  lcd.createChar(6, custom_6);
  lcd.createChar(7, custom_7); 
  
  //active the serial connection stream
  Serial.begin(9600);
  Serial.println("connection established");
}

void loop(){
  if (brain.update()){
    // stream the output to the PC via the serial connection
    Serial.println(brain.readCSV());
    
    // draw the screen labels
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("S  D  A  B  T");
  
    // fill in the wavelength energies from the EEG reading
    lcd.setCursor(1,0);
    lcd.print(brain.readSignalQuality());
    lcd.setCursor(4,0);
    lcd.print(brain.readDelta()/75000);
    lcd.setCursor(7,0);
    lcd.print((brain.readHighAlpha()+brain.readLowAlpha())/10000);
    lcd.setCursor(10,0);
    lcd.print((brain.readHighBeta()+brain.readLowBeta())/10000);
    lcd.setCursor(13,0);
    lcd.print(brain.readTheta()/5000);
    
    // set the variables and correct for the bar graph
    byte signalStrength = (((brain.readSignalQuality())/10)/8);
    unsigned long deltaEnergy = (((brain.readDelta())/150000)/8);
    unsigned long alphaEnergy = (((brain.readHighAlpha()+brain.readLowAlpha())/15000)/8);
    unsigned long betaEnergy = (((brain.readHighBeta()+brain.readLowBeta())/15000)/8);
    unsigned long thetaEnergy = (((brain.readTheta())/10000)/8);
    int remSigStrength = (((brain.readSignalQuality())/10)%8);
    int remDelta = (((brain.readDelta())/150000)%8);
    int remAlpha = (((brain.readHighAlpha()+brain.readLowAlpha())/15000)%8);
    int remBeta = (((brain.readHighBeta()+brain.readLowBeta())/15000)%8);
    int remTheta = (((brain.readTheta())/10000)%8);
    
    // fill in the signal strength bar graph
    lcd.setCursor(0,1);
    for (int i=0; i<signalStrength;i++) {
      lcd.print(7,BYTE);}           //print the number of solid blocks
    lcd.print(remSigStrength,BYTE); //print the remainder which is meter segments within character
    
    // fill in the Delta band energy bar graph
    lcd.setCursor(3,1);
    for (int i=0; i<deltaEnergy;i++) {
      lcd.print(7,BYTE);}
    lcd.print(remDelta,BYTE); 
    
    // fill in the Alpha band energy bar graph
    lcd.setCursor(6,1);
    for (int i=0; i<alphaEnergy;i++) {
      lcd.print(7,BYTE);}
    lcd.print(remAlpha,BYTE); 
    
    // fill in the Alpha band energy bar graph
    lcd.setCursor(9,1);
    for (int i=0; i<betaEnergy;i++) {
      lcd.print(7,BYTE);}
    lcd.print(remBeta,BYTE); 
    
    // fill in the Theta band energy bar graph
    lcd.setCursor(12,1);
    for (int i=0; i<thetaEnergy;i++) {
      lcd.print(7,BYTE);}
    lcd.print(remTheta,BYTE); 
    


  }  
  
}
