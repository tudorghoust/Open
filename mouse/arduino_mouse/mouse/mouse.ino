#include <Wire.h>
#include <LSM6.h>
#include <LIS3MDL.h>

LIS3MDL mag;
LIS3MDL::vector<int16_t> running_min = {32767, 32767, 32767}, running_max = { -32768, -32768, -32768};
LSM6 imu;
int buton = 0,apasare=0;
int x, y;
char report[80];

void setup()
{
  Serial.begin(9600);
  Wire.begin();

  if (!mag.init())
  {
    Serial.println("Failed to detect and initialize magnetometer!");
    while (1);
  }

  mag.enableDefault();

  Serial.begin(9600);
  Wire.begin();

  if (!imu.init())
  {
    Serial.println("Failed to detect and initialize IMU!");
    while (1);
  }
  imu.enableDefault();
  calibrare();

}
void calibrare()
{
  for (int i = 0; i < 20; i++) {
    mag.read();

    running_min.x = min(running_min.x, mag.m.x);
    running_min.y = min(running_min.y, mag.m.y);
    running_min.z = min(running_min.z, mag.m.z);

    running_max.x = max(running_max.x, mag.m.x);
    running_max.y = max(running_max.y, mag.m.y);
    running_max.z = max(running_max.z, mag.m.z);

    snprintf(report, sizeof(report), "min: {%+6d, %+6d, %+6d}   max: {%+6d, %+6d, %+6d}",
             running_min.x, running_min.y, running_min.z,
             running_max.x, running_max.y, running_max.z);

    delay(100);
  }
}

void loop()
{
  imu.read();
  x = imu.a.x;
  y = imu.a.y;
  if (x > 10000) Serial.println(1);//fata
  if (x < -10000) Serial.println(2);//spate
  if (y > 10000) Serial.println(3);//stanga
  if (y < -10000) Serial.println(4);//dreapta
  if ( x > 9000 && y > 7000) Serial.println(5);
  if ( x > 9000 && y < -7000) Serial.println(6);
  if ( x < -9000 && y > 7000) Serial.println(7);
  if ( x < -9000 && y < -7000) Serial.println(8);
    while (digitalRead(2) && apasare !=300)
  {
    apasare +=  100;
            delay(200);
  }
      if(apasare == 100) 
  {Serial.println('l');
  digitalWrite(8,HIGH);
  delay(200);
    digitalWrite(8,LOW);
  apasare=0;
  }
  if(apasare ==200) 
  {
  Serial.println('r');
    digitalWrite(8,HIGH);
  delay(200);
    digitalWrite(8,LOW);
  apasare=0;
  }
    if(apasare ==300) 
  {
  Serial.println('d');
    digitalWrite(8,HIGH);
  delay(200);
    digitalWrite(8,LOW);
  apasare=0;
  }


     Serial.println(-1);
}
