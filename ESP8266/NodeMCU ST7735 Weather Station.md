---
categories:  #分类
    - C
    - 嵌入式 
tags:   #标签
    - NodeMCU
    - 物联网
    - WeatherStation
---

# 毕业设计-----基于STM32的物联网环境检测系统

## 系统框架

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/Snipaste_2022-01-04_11-37-42.png)

## 制作流程

### 项目Demo1 NodeMCU ST7735 Weather Station 制作流程

### ![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/%E5%A4%A9%E6%B0%94%E6%97%B6%E9%92%9F.png)

####  注册申请OpenWeatherAPI

1. https://openweathermap.org/   注册账号
2. 申请APIkey 复制粘贴到代码中
3. 下载城市代码Json文件

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/open1.png)

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/open2.png)

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/open3.png)

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/open4.png)

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/openw1.png)

```c
//--------------------------------------------------------------------------------------------------
//  TTF显示驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |     
//--------------------------------------------------------------------------------------------------
#include <Adafruit_GFX.h>      // include Adafruit graphics library
#include <Adafruit_ST7735.h>   // include Adafruit ST7735 TFT library
//--------------------------------------------------------------------------------------------------
//  ESP8266WiFi驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |     
//--------------------------------------------------------------------------------------------------
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
//--------------------------------------------------------------------------------------------------
//  数据解析JSON驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |     
//--------------------------------------------------------------------------------------------------
#include <Arduino_JSON.h>
//--------------------------------------------------------------------------------------------------
//  硬件端口定义    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
// ST7735 TFT module connections
#define TFT_RST   0     // TFT RST pin is connected to NodeMCU pin  D3
#define TFT_CS    15    // TFT CS  pin is connected to NodeMCU pin  D8
#define TFT_DC    2     // TFT DC  pin is connected to NodeMCU pin  D4

Adafruit_ST7735 tft = Adafruit_ST7735(TFT_CS, TFT_DC, TFT_RST);
//==================================================================================================
//  代码说明: 初始化配置
//  1.填写 WIFI ssid password
//  2.注册账号 申请openWeatherMapApiKey openWeather网站：https://openweathermap.org/
//  3.填写 countrycode and city
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
const char* ssid = "WIFI ssid ";
const char* password = "WIFI password";

// Your Domain name with URL path or IP address with path
String openWeatherMapApiKey = "a6b294e4393444a050ca038eb616a927";

// Replace with your country code and city
String city = "Anqing";
String countryCode = "CN";

// THE DEFAULT TIMER IS SET TO 10 SECONDS FOR TESTING PURPOSES
// For a final application, check the API call limits per hour/minute to avoid getting blocked/banned
//--------------------------------------------------------------------------------------------------
//  定义引用变量    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
unsigned long lastTime = 0;
unsigned long timerDelay = 10000;

String jsonBuffer;

//==================================================================================================
//  实现功能: 初始化配置
//  函数说明: setup
//  函数备注: TFT显示与连接WIFI
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 10 seconds (timerDelay variable), it will take 10 seconds before publishing the first reading.");

  tft.initR(INITR_BLACKTAB);   // initialize a ST7735S chip, black tab
  tft.setRotation(1);
  uint16_t time = millis();
  tft.fillScreen(ST7735_BLACK);
  time = millis() - time;

  delay(500);

  tft.fillScreen(ST7735_BLACK);
  //layout
  tft.drawFastHLine(0, 0, tft.width(), ST7735_WHITE);
  tft.drawFastHLine(1, 127, tft.width(), ST7735_WHITE);
  tft.drawFastVLine(0, 0, tft.height(), ST7735_WHITE);
  tft.drawFastVLine(159, 0, tft.height(), ST7735_WHITE);
  tft.drawFastVLine(80, 50, 40, ST7735_WHITE);
  tft.drawFastHLine(1, 50, tft.width(), ST7735_WHITE);
  tft.drawFastHLine(1, 90, tft.width(), ST7735_WHITE);
  tft.setTextColor(ST7735_WHITE);
  tft.setCursor(10, 10);
  tft.setTextSize(2);
  tft.print(city);
  tft.setTextSize(1);
  tft.setCursor(10, 35);
  tft.print(countryCode);
  tft.setTextSize(1);

  tft.setTextColor(ST7735_RED);
  tft.setCursor(15, 60);
  tft.print("Pressure");
  tft.setCursor(90, 60);
  tft.print("Humidity");
  tft.setCursor(10, 105);
  tft.print("Wind Speed");
  tft.setTextColor(ST7735_GREEN);
  tft.setCursor(140, 10);
  tft.print(" C");
  tft.setTextColor(ST7735_YELLOW);
  tft.setCursor(42, 75);
  tft.print(" Hpa");
  tft.setCursor(115, 75);
  tft.print("%");
  tft.setCursor(115, 105);
  tft.print("m/s");
  delay(1000);

}
//--------------------------------------------------------------------------------------------------
//  定义引用变量    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
int temp;
int pres;
int hum;
String wind;
//==================================================================================================
//  实现功能: 主函数(循环)配置
//  函数说明: loop
//  1. Send an HTTP GET request 发送请求
//  2. JSON 数据解析 串口打印数据
//  3. TFT显示数据
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void loop() {
  //
  // Send an HTTP GET request
  if ((millis() - lastTime) > timerDelay) {
    // Check WiFi connection status
    if(WiFi.status()== WL_CONNECTED){
      String serverPath = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "," + countryCode + "&APPID=" + openWeatherMapApiKey;
      
      jsonBuffer = httpGETRequest(serverPath.c_str());
      Serial.println(jsonBuffer);
      JSONVar myObject = JSON.parse(jsonBuffer);
  
      // JSON.typeof(jsonVar) can be used to get the type of the var
      if (JSON.typeof(myObject) == "undefined") {
        Serial.println("Parsing input failed!");
        return;
      }

      String jsonString = JSON.stringify(myObject["main"]["temp"]);
      temp = jsonString.toInt();
      temp = (temp - 273);
      jsonString = JSON.stringify(myObject["main"]["pressure"]);
      pres = jsonString.toInt();
      jsonString = JSON.stringify(myObject["main"]["humidity"]);
      hum = jsonString.toInt();
      jsonString = JSON.stringify(myObject["wind"]["speed"]);
      wind = jsonString;
      
      Serial.println();
      Serial.print("JSON object = ");
      Serial.println(myObject);
      Serial.print("Temperature: ");
      Serial.println(temp);
      Serial.print("Pressure: ");
      Serial.println(pres);
      Serial.print("Humidity: ");
      Serial.println(hum);
      Serial.print("Wind Speed: ");
      Serial.println(wind);
    
      tft.fillRect(105, 8 , 38, 30, ST7735_BLACK);
      tft.fillRect(12, 70 , 32, 15, ST7735_BLACK);
      tft.fillRect(97, 70 , 16, 15, ST7735_BLACK);
      tft.fillRect(87, 103 , 25, 15, ST7735_BLACK);
      tft.setTextColor(ST7735_GREEN);
      tft.setTextSize(3);
      tft.setCursor(108, 10);
      tft.print(temp);
      tft.setTextColor(ST7735_YELLOW);
      tft.setTextSize(1);
      tft.setCursor(15, 75);
      tft.print(pres);
      tft.setCursor(100, 75);
      tft.print(hum);
      tft.setCursor(90, 105);
      tft.print(wind);
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
}
//==================================================================================================
//  实现功能: HTTP请求
//  函数说明: httpGETRequest
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
String httpGETRequest(const char* serverName) {
  WiFiClient client;
  HTTPClient http;
    
  // Your IP address with path or Domain name with URL path 
  http.begin(client, serverName);
  
  // Send HTTP POST request
  int httpResponseCode = http.GET();
  
  String payload = "{}"; 
  
  if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  // Free resources
  http.end();

  return payload;
}

```
#### 项目Demo2 NodeMCU ST7735 Time Weather Station 制作流程
```c
//--------------------------------------------------------------------------------------------------
//  TTF显示驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |     
//--------------------------------------------------------------------------------------------------
#include <Adafruit_GFX.h>      // include Adafruit graphics library
#include <Adafruit_ST7735.h>   // include Adafruit ST7735 TFT library
//--------------------------------------------------------------------------------------------------
//  ESP8266WiFi驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |     
//--------------------------------------------------------------------------------------------------
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <WiFiUdp.h>
//--------------------------------------------------------------------------------------------------
// Arduino_JSON NTPClient驱动头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7      
//--------------------------------------------------------------------------------------------------
#include <Arduino_JSON.h>
#include <NTPClient.h>

#include <Fonts/FreeMonoBold12pt7b.h>
#include <Fonts/FreeMono12pt7b.h>
#include <Fonts/FreeSans9pt7b.h>
//--------------------------------------------------------------------------------------------------
//  硬件端口定义    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
// ST7735 TFT module connections
#define TFT_RST   0     // TFT RST pin is connected to NodeMCU pin D4 (GPIO2)
#define TFT_CS    15     // TFT CS  pin is connected to NodeMCU pin D4 (GPIO0)
#define TFT_DC    2     // TFT DC  pin is connected to NodeMCU pin D4 (GPIO4)

Adafruit_ST7735 tft = Adafruit_ST7735(TFT_CS, TFT_DC, TFT_RST);
//==================================================================================================
//  代码说明: 初始化配置
//  1.填写 WIFI ssid password
//  2.注册账号 申请openWeatherMapApiKey openWeather网站：https://openweathermap.org/
//  3.填写 countrycode and city
//  4.https://api.openweathermap.org/data/2.5/weather?q=Anqing&appid=a6b294e4393444a050ca038eb616a927
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
const char* ssid = "dele";
const char* password = "11111111";
String openWeatherMapApiKey = "a6b294e4393444a050ca038eb616a927";
String city = "Anqing";
String countryCode = "CN";

unsigned long lastTime = 0;
unsigned long timerDelay = 10000;
String jsonBuffer;

//const long utcOffsetInSeconds = 19800;
char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
WiFiUDP ntpUDP;
int timeZone = 8; //东八区的时间
NTPClient timeClient(ntpUDP, "ntp1.aliyun.com", timeZone*3600, 60000);


const unsigned char cloud[] PROGMEM = {
  B00000000,B00000000,B00000000,B00000000,B00000000,B00000000,
  B00000000,B00000011,B00000000,B00000000,B00000000,B00000000,
  B00000000,B00000011,B00000000,B00000000,B00000000,B00000000,
  B00000000,B11000011,B00000110,B00000000,B00000000,B00000000,
  B00000000,B11000011,B00001110,B00000000,B00000000,B00000000,
  B00000000,B01100011,B00001100,B00000000,B00000000,B00000000,
  B00000000,B01100011,B00011000,B00000000,B00000000,B00000000,
  B00010000,B00111111,B11111000,B00000000,B00000000,B00000000,
  B00111100,B00111111,B11110000,B01110000,B00000000,B00000000,
  B00001110,B01111111,B11111101,B11100000,B00000000,B00000000,
  B00000111,B11111000,B00111111,B10000000,B00000000,B00000000,
  B00000001,B11110000,B00011110,B00000000,B00000000,B00000000,
  B00000001,B11100000,B00001000,B01111111,B10000000,B00000000,
  B00000001,B11000000,B00000001,B11111111,B11100000,B00000000,
  B01111111,B11000000,B00000011,B11111111,B11110000,B00000000,
  B01111111,B11000000,B00000111,B11000000,B11111000,B00000000,
  B00000001,B11000000,B00001111,B00000000,B01111100,B00000000,
  B00000001,B11100001,B11111111,B00000000,B00111100,B00000000,
  B00000001,B11100111,B11111110,B00000000,B00011110,B00000000,
  B00000111,B10001111,B11111100,B00000000,B00011110,B00000000,
  B00001110,B00001111,B00000100,B00000000,B00001110,B00000000,
  B00111000,B00011110,B00000000,B00000000,B00001111,B10000000,
  B00000000,B00011100,B00000000,B00000000,B00001111,B11000000,
  B00000000,B01111100,B00000000,B00000000,B00000111,B11100000,
  B00000011,B11111100,B00000000,B00000000,B00000001,B11100000,
  B00000111,B11111100,B00000000,B00000000,B00000000,B11110000,
  B00001111,B11111100,B00000000,B00000000,B00000000,B01110000,
  B00001111,B00000000,B00000000,B00000000,B00000000,B01110000,
  B00001110,B00000000,B00000000,B00000000,B00000000,B01110000,
  B00011110,B00000000,B00000000,B00000000,B00000000,B01110000,
  B00011110,B00000000,B00000000,B00000000,B00000000,B11110000,
  B00001110,B00000000,B00000000,B00000000,B00000000,B11110000,
  B00001111,B00000000,B00000000,B00000000,B00000011,B11100000,
  B00001111,B11111111,B11111111,B11111111,B11111111,B11000000,
  B00000111,B11111111,B11111111,B11111111,B11111111,B10000000,
  B00000001,B11111111,B11111111,B11111111,B11111111,B00000000,
  B00000000,B00000000,B00000000,B00000000,B00000000,B00000000,
  B00000000,B00000000,B00000000,B00000000,B00000000,B00000000
};
const unsigned char CLOCK[] PROGMEM = {
  B00000000,B00000000,B00000000,B00000000,
  B00000000,B00111100,B01110000,B00000000,
  B00000000,B11000000,B00000100,B00000000,
  B00000001,B00000001,B00000011,B00000000,
  B00000010,B01000000,B00001000,B10000000,
  B00000100,B00000000,B00000000,B01000000,
  B00001000,B00000000,B00000000,B00100000,
  B00010000,B00000000,B00000000,B00100000,
  B00010100,B00000001,B00000000,B10010000,
  B00000000,B00000001,B00000000,B00010000,
  B00100000,B00000001,B00000000,B00001000,
  B00100000,B00000001,B00000000,B00001000,
  B00100000,B00000001,B00000000,B00001000,
  B00101000,B00000001,B11100000,B00101000,
  B00101000,B00000000,B00000000,B00101000,
  B00100000,B00000000,B00000000,B00001000,
  B00100000,B00000000,B00000000,B00001000,
  B00100000,B00000000,B00000000,B00000000,
  B00010000,B00000000,B00000000,B00010000,
  B00010000,B00000000,B00000000,B10010000,
  B00001000,B00000000,B00000000,B00100000,
  B00001000,B00000000,B00000000,B01100000,
  B00000100,B00000000,B00000000,B01000000,
  B00000010,B00000000,B00000000,B10000000,
  B00000001,B10000001,B00000011,B00000000,
  B00000000,B01100000,B00001100,B00000000,
  B00000000,B00011110,B11110000,B00000000,
  B00000000,B00000000,B00000000,B00000000
};
const unsigned char humid[] PROGMEM = {
  B00000000,B00100000,B00000000,
  B00000000,B00110000,B00000000,
  B00000000,B01111000,B00000000,
  B00000000,B11111100,B00000000,
  B00000001,B11111110,B00000000,
  B00000011,B11111110,B00000000,
  B00000011,B11111111,B00000000,
  B00000111,B11111111,B10000000,
  B00001111,B11111111,B10000000,
  B00001111,B11111111,B11000000,
  B00011111,B11111111,B11000000,
  B00011111,B11111111,B11100000,
  B00111111,B11111111,B11100000,
  B00111111,B11111111,B11110000,
  B01111111,B11111111,B11110000,
  B01111110,B01110111,B11111000,
  B01111110,B00110111,B11111000,
  B01111100,B10101111,B11111000,
  B01111110,B01101111,B11111000,
  B01111111,B11011011,B11111000,
  B01111111,B11010001,B11111000,
  B01111111,B10110101,B11111000,
  B01111111,B10110001,B11111000,
  B01111111,B01111011,B11111000,
  B00111111,B11111111,B11110000,
  B00111111,B11111111,B11110000,
  B00011111,B11111111,B11100000,
  B00001111,B11111111,B11000000,
  B00000011,B11111111,B00000000,
  B00000000,B01110000,B00000000
};
const unsigned char pressure[] PROGMEM = {
  B00000000,B00000000,B00000000,B00000000,
  B00000000,B00001111,B11000000,B00000000,
  B00000000,B00111100,B11110000,B00000000,
  B00000000,B11000000,B00011100,B00000000,
  B00000001,B10000000,B00000110,B00000000,
  B00000011,B00000000,B00000010,B00000000,
  B00000010,B00000000,B00000001,B00000000,
  B00000100,B00000000,B00010001,B10000000,
  B00000100,B00000000,B01100000,B10000000,
  B00001100,B00000000,B11000000,B10000000,
  B00001000,B00000011,B10000000,B11000000,
  B00001000,B00000111,B10000000,B11000000,
  B00001000,B00000111,B10000000,B11000000,
  B00001100,B00000011,B00000000,B11000000,
  B00001100,B00000000,B00000000,B10000000,
  B00000100,B00000000,B00000000,B10000000,
  B00000110,B00000000,B00000001,B10000000,
  B00000010,B00000000,B00000001,B00000000,
  B00000011,B00000000,B00000010,B00000000,
  B00000001,B10000000,B00000100,B00000000,
  B00000000,B01100000,B00011000,B00000000,
  B00000000,B00111111,B11110000,B00000000,
  B00000000,B00000111,B10000000,B00000000,
  B00000000,B00000101,B10000000,B00000000,
  B00000000,B00000101,B10000000,B00000000,
  B00111111,B11111101,B11111111,B11110000,
  B00000000,B00000000,B00000000,B00000000,
  B00000000,B00000000,B00000000,B00000000,
  B00000000,B00000000,B00000000,B00000000,
  B00111111,B11111111,B11111111,B11110000
};
const unsigned char windS[] PROGMEM = {
  B00000000,B00000000,B00001111,B00000000,B11110000,
  B00000000,B00000000,B00011101,B11000011,B10011100,
  B00000000,B00000000,B00110000,B11000110,B00000110,
  B00000000,B00000000,B00100000,B01100100,B00000010,
  B00000000,B00000000,B00000000,B01101100,B00000011,
  B00000000,B00000000,B00000000,B01101100,B00000001,
  B00000000,B00000000,B00000000,B11000000,B00000011,
  B00000111,B11111111,B11111111,B10000000,B00000011,
  B00001111,B11111111,B11111111,B00000000,B00000010,
  B00000000,B00000000,B00000000,B00000000,B00000110,
  B11111111,B11111111,B11111111,B11111111,B11111100,
  B11111111,B11111111,B11111111,B11111111,B11110000,
  B00000000,B00000000,B00000000,B00000000,B00000000,
  B00000000,B01111111,B11111111,B11111110,B00000000,
  B00000000,B01111111,B11111111,B11111111,B00000000,
  B00000000,B00000000,B00000000,B00000001,B10000000,
  B00000000,B00000000,B00000000,B00010001,B10000000,
  B00000000,B00000000,B00000000,B00011011,B00000000,
  B00000000,B00000000,B00000000,B00001110,B00000000
};

void setup(void) 
{  

    Serial.begin(115200);
    WiFi.begin(ssid, password);
    Serial.println("Connecting");
    while(WiFi.status() != WL_CONNECTED) 
    {
      delay(500);
      Serial.print(".");
    }

    Serial.println("");
    Serial.print("Connected to WiFi network with IP Address: ");
    Serial.println(WiFi.localIP());
   
    Serial.println("Timer set to 10 seconds (timerDelay variable), it will take 10 seconds before publishing the first reading.");
    timeClient.begin();
    
    tft.initR(INITR_BLACKTAB);   // initialize a ST7735S chip, black tab
    //tft.setRotation(1);
    uint16_t time = millis();
    tft.fillScreen(ST7735_BLACK);
    time = millis() - time;
    
    delay(500);
 
    tft.fillScreen(ST7735_BLACK);
    //layout
    tft.drawFastHLine(0, 0, tft.width(), ST7735_WHITE);
    tft.drawFastHLine(1, 159, tft.width(), ST7735_WHITE);
    tft.drawFastVLine(0, 0, tft.height(), ST7735_WHITE);
    tft.drawFastVLine(127, 0, tft.height(), ST7735_WHITE);

    tft.drawBitmap(6, 5, cloud, 45, 38,ST7735_YELLOW);
    //delay(2000);
    tft.drawBitmap(90, 47, CLOCK, 30, 28,ST7735_WHITE);
    //delay(2000);
    tft.drawBitmap(6, 75, humid, 22, 30,0x07FF);
    tft.drawBitmap(95, 100, pressure, 30, 30,ST7735_RED);
    tft.drawBitmap(6, 131, windS, 40, 19,0xAFE5);
    tft.setFont(&FreeSans9pt7b);
    
    tft.setTextColor(ST7735_YELLOW);
    tft.setCursor(50,20);
    tft.setTextSize(1);
    tft.print(city);
    //tft.setFont(&FreeMono9pt7b);
    tft.setFont();
    tft.setTextSize(1);
    tft.setCursor(55,31);
    tft.print(countryCode);
    
    tft.setCursor(100,29);
    tft.print(" C");
    tft.setTextColor(0x07FF);
    tft.setFont(&FreeSans9pt7b);
    tft.setTextSize(1);
    tft.setCursor(74,95);
    tft.print("%");
    tft.setFont();
    tft.setTextColor(0x07FF);
    tft.setCursor(95,85);
    tft.setTextSize(1);
    tft.print("Hum");
    tft.setTextColor(0xAFE5);
    tft.setTextSize(1);
    tft.setCursor(107,135);
    tft.print("m/s");
    tft.setTextColor(ST7735_RED);
    tft.setCursor(72,108);
    tft.print(" Hpa");
    delay(1000);
    
}

int temp;
int pres;
int hum;
String wind;

void loop() 
{

  timeClient.update();
  int hours = timeClient.getHours();
  int minu =  timeClient.getMinutes();
      
   // Send an HTTP GET request
  if ((millis() - lastTime) > timerDelay) {
    // Check WiFi connection status
    if(WiFi.status()== WL_CONNECTED){
      String serverPath = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "," + countryCode + "&APPID=" + openWeatherMapApiKey;
      
      jsonBuffer = httpGETRequest(serverPath.c_str());
      Serial.println(jsonBuffer);
      JSONVar myObject = JSON.parse(jsonBuffer);
  
      // JSON.typeof(jsonVar) can be used to get the type of the var
      if (JSON.typeof(myObject) == "undefined") {
        Serial.println("Parsing input failed!");
        return;
      }

      String jsonString = JSON.stringify(myObject["main"]["temp"]);
      temp = jsonString.toInt();
      temp = (temp - 273);
      jsonString = JSON.stringify(myObject["main"]["pressure"]);
      pres = jsonString.toInt();
      jsonString = JSON.stringify(myObject["main"]["humidity"]);
      hum = jsonString.toInt();
      jsonString = JSON.stringify(myObject["wind"]["speed"]);
      wind = jsonString;

      
      //Serial.println(timeClient.getFormattedTime());
      Serial.printf("hour:%d minu:%d \n", hours,minu);
      
      Serial.println();
      Serial.print("JSON object = ");
      Serial.println(myObject);
      Serial.print("Temperature: ");
      Serial.println(temp);
      Serial.print("Pressure: ");
      Serial.println(pres);
      Serial.print("Humidity: ");
      Serial.println(hum);
      Serial.print("Wind Speed: ");
      Serial.println(wind);
    
      
      tft.fillRect(14, 45 , 68, 28, ST7735_BLACK);
      tft.fillRect(24, 70 , 55, 10, ST7735_BLACK);
      tft.fillRect(73, 24 , 25, 21, ST7735_BLACK);
      tft.fillRect(40, 80 , 26, 21, ST7735_BLACK);
      tft.fillRect(20, 105 , 55, 18, ST7735_BLACK);
      tft.fillRect(50, 130 , 45, 19, ST7735_BLACK);
      
      tft.setTextColor(ST7735_YELLOW);
      tft.setFont(&FreeMonoBold12pt7b);
      tft.setTextSize(1);
      tft.setCursor(72,42);
      tft.print(temp);
      //tft.setFont();
      
      tft.setTextColor(ST7735_WHITE);
      tft.setCursor(13,62);
      tft.print(hours);//显示小时
      tft.print(":");
      tft.print(minu+1);//显示分钟
      tft.setFont();
      tft.setTextSize(1);
      tft.setCursor(26,70);
      tft.print(daysOfTheWeek[timeClient.getDay()]);
      tft.setTextColor(0x07FF);
      tft.setFont(&FreeMono12pt7b);
      
      tft.setTextSize(1);
      tft.setCursor(40,97);
      tft.print(hum);
      tft.setTextColor(ST7735_RED);
      tft.setCursor(18,121);
      tft.print(pres);
      
      tft.setTextColor(0xAFE5);
      tft.setCursor(48,148);
      tft.print(wind);
    
    
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
    
    
  
}

String httpGETRequest(const char* serverName) {
  WiFiClient client;
  HTTPClient http;
    
  // Your IP address with path or Domain name with URL path 
  http.begin(client, serverName);
  
  
  int httpResponseCode = http.GET();
  
  String payload = "{}"; 
  
  if (httpResponseCode>0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
    payload = http.getString();
  }
  else {
    Serial.print("Error code: ");
    Serial.println(httpResponseCode);
  }
  http.end();

  return payload;
}

```
### 效果

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/Snipaste_2022-01-04_12-43-06.png)

![](https://gitee.com/lemonhubchat/blog-image/raw/master/img/Snipaste_2022-01-05_15-11-24.png)