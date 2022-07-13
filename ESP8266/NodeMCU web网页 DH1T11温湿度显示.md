---
categories:  #分类
    - 单片机
    - 电子模块
    - Web
tags:   #标签
    - NodeMCU
    - OLED
    - DHT11
    - Web
---
# Nodemcu-0.96oled-dht11-web网页显示
<!-- more -->
## 简介
1.软件部分
 Arduino IDE
2.硬件部分
NodeMCU   OLED  DHT11
3.知识点
Web开发  Arduino IDE开发ESP8266 
## 软件部分
### 软件代码
#### 代码分析（以后再写）
```cpp

// Import required libraries
#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <Hash.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>

// Replace with your network credentials
const char* ssid = "MERCURY_3DE2";//路由器或者热点名称
const char* password = "88888888";//路由器或者热点密码

#define DHTPIN 5     
// Digital pin connected to the DHT sensor
//引脚定义初始化


#define DHTTYPE    DHT11     // DHT 11

DHT dht(DHTPIN, DHTTYPE);

// current temperature & humidity, updated in loop()
float t = 0.0;
float h = 0.0;

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

// Generally, you should use "unsigned long" for variables that hold time
// The value will quickly become too large for an int to store
unsigned long previousMillis = 0;    
// will store last time DHT was updated

// Updates DHT readings every 10 seconds
const long interval = 10000;  
/*网页端代码编写*/
const char index_html[] PROGMEM = R"rawliteral(
<!DOCTYPE HTML><html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <style>
    html {
     font-family: Arial;
     display: inline-block;
     margin: 0px auto;
     text-align: center;
    }
    h2 { font-size: 3.0rem; }
    p { font-size: 3.0rem; }
    .units { font-size: 1.2rem; }
    .dht-labels{
      font-size: 1.5rem;
      vertical-align:middle;
      padding-bottom: 15px;
    }
  </style>
</head>
<body>
  <h2>ESP8266 DHT Server</h2>
  <p>
    <i class="fas fa-thermometer-half" style="color:#059e8a;"></i> 
    <span class="dht-labels">Temperature</span> 
    <span id="temperature">%TEMPERATURE%</span>
    <sup class="units">&deg;C</sup>
  </p>
  <p>
    <i class="fas fa-tint" style="color:#00add6;"></i> 
    <span class="dht-labels">Humidity</span>
    <span id="humidity">%HUMIDITY%</span>
    <sup class="units">%</sup>
  </p>
</body>
<script>
setInterval(function ( ) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("temperature").innerHTML = this.responseText;
    }
  };
  xhttp.open("GET", "/temperature", true);
  xhttp.send();
}, 10000 ) ;

setInterval(function ( ) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("humidity").innerHTML = this.responseText;
    }
  };
  xhttp.open("GET", "/humidity", true);
  xhttp.send();
}, 10000 ) ;
</script>
</html>)rawliteral";

// Replaces placeholder with DHT values
String processor(const String& var)
{
  //Serial.println(var);
  if(var == "TEMPERATURE"){
    return String(t);
  }
  else if(var == "HUMIDITY"){
    return String(h);
  }
  return String();
}

void setup()
{
  // Serial port for debugging purposes
  Serial.begin(115200);//串口波特率
  dht.begin();
  
  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println(".");
  }

  // Print ESP8266 Local IP Address
  Serial.println(WiFi.localIP());

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/html", index_html, processor);
  });
  server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", String(t).c_str());
  });
  server.on("/humidity", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", String(h).c_str());
  });

  // Start server
  server.begin();
}
 
void loop(){  
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    // save the last time you updated the DHT values
    previousMillis = currentMillis;
    // Read temperature as Celsius (the default)
    float newT = dht.readTemperature();
    // Read temperature as Fahrenheit (isFahrenheit = true)
    //float newT = dht.readTemperature(true);
    // if temperature read failed, don't change t value
    if (isnan(newT)) {
      Serial.println("Failed to read from DHT sensor!");
    }
    else {
      t = newT;
      Serial.println(t);
    }
    // Read Humidity
    float newH = dht.readHumidity();
    // if humidity read failed, don't change h value 
    if (isnan(newH)) {
      Serial.println("Failed to read from DHT sensor!");
    }
    else {
      h = newH;
      Serial.println(h);
    }
  }
}
```

### Arduino IDE软件 使用
#### Arduino软件(IDE)
Arduino集成开发环境（或是Arduino IDE）包含了一个用于写代码的文本编辑器、一个消息区、一个文本控制台以及一个带有常用功能按钮和文本菜单的工具栏。软件连接Arduino和Genuino之后，能给所连接的控制板上传程序，还能与控制板相互通信。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200330203800120.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

#### 写项目
使用Arduino软件（IDE）编写的代码被称为项目（sketches），这些项目写在文本编辑器中，以.ino的文件形式保存，软件中的文本编辑器有剪切/粘贴和搜索/替换功能。当保存、输出以及出现错误时消息区会显示反馈信息。控制台会文字形式显示Arduino软件（IDE）的输出信息，包括完整的错误信息以及其他消息。整个窗口的右下角会显示当前选定的控制板和串口信息。工具栏按钮包含验证、下载程序、新建、打开、保存以及串口监视器的功能。

注意：Arduino软件（IDE）1.0之前的版本中项目的保存格式为.pde，你能够用1.0版本的软件打开这些文件，软件会提示你将这些项目保存为.ino的形式。
#### 验证
检查代码编译时的错误
#### 上传
编译你的代码并且上传到选定的控制板中，细节请查看后面的 上传 内容
注意：如果你使用的是专门的编程器，你需要在点击按钮时按住电脑的“shift”键，显示的文字会变成“使用编程器上传”。
#### 新建
创建一个新的项目。
#### 打开
弹出一个包含你在项目文件夹中所有项目的菜单，选择其中一个会打开相应的代码，新的项目会覆盖当前的项目。
注意：因为Java中的一个问题，所以这个菜单不会滚动，如果你需要打开的项目在列表的最后，那么需要通过菜单中的文件|项目文件夹来选择。
#### 保存
保存你的项目。
#### 。。。。。。。。东西太多了
#### 语言支持
从版本1.0.1开始，Arduino软件(IDE)已被翻译成30多种语言，默认的情况下，IDE会根据系统的语言选择相应的语言（注意：在Windows中以及可以在Linux中，这是由系统的日期和时间格式来确定的，而不是由操作系统显示的语言来确定的。）
如果你想手动更改语言，那就打开Arduino软件，然后在首选项的对话框中选择编辑器语言，在弹出的下来菜单中选择相应的语言，然后重启软件使所选择的语言生效，如果你的操作系统不支持你所选择的语言，那么IDE会默认采用英文。
你能够返回Arduino的默认设置，让IDE根据系统的语言选择相应的语言，只需要在语言选择的下拉菜单中选择系统默认。当你重启软件时这个设置会生效。同样的，改变你的系统设置后，你需要重新启动Arduino软件才能变为新的默认语言。
### 简单配置（以后再写）
## 硬件部分
### NodeMCU 
NodeMCU是一个开源的物联网平台。它使用Lua脚本语言编程。该平台基于eLua 开源项目,底层使用中国乐鑫公司的ESP8266 sdk 0.9.5版本。NodeMCU包含了可以运行在 esp8266 Wi-Fi SoC芯片之上的固件,以及基于ESP-12模组的硬件。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200330203343829.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### nodemcu GPIO 端口映射

```c
static const uint8_t SDA = PIN_WIRE_SDA;
static const uint8_t SCL = PIN_WIRE_SCL;

static const uint8_t LED_BUILTIN = 16;
static const uint8_t BUILTIN_LED = 16;
static const uint8_t D0   = 16;
static const uint8_t D1   = 5;
static const uint8_t D2   = 4;
static const uint8_t D3   = 0;
static const uint8_t D4   = 2;
static const uint8_t D5   = 14;
static const uint8_t D6   = 12;
static const uint8_t D7   = 13;
static const uint8_t D8   = 15;
static const uint8_t D9   = 3;
static const uint8_t D10  = 1;
```

### OLED 
OLED(Organic Light-Emitting Diode)，即有机发光二极管,其实物图如下所示. OLED由于同时具备自发光，不需背光源，对比度高，厚度薄，视角广，反应速度快，可用于挠曲性面板，使用温度范围广，构造及制程简单等优异特性，被认为是下一代的平面显示器新兴应用技术。具有轻，薄，省电等特性，工作电压宽度高，从2.2V到5.5V。发光原理：有机发光显示技术由非常薄的有机材料涂层和玻璃基板构成。当有电荷通过时这些有机材料就会发光。OLED发光的颜色取决于有机发光层的材料，故厂商可由改变发光层的材料而得到所需之颜色。有源阵列有机发光显示屏具有内置的电子电路系统因此每个像素都由一个对应的电路独立驱动。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200330203711396.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### DHT11 
DHT11数字温湿度传感器是一款含有已校准数字信号输出的温湿度复合传感器，它应用专用的数字模块采集技术和温湿度传感技术，确保产品具有极高的可靠性和卓越的长期稳定性。传感器包括一个电阻式感湿元件和一个NTC测温元件，并与一个高性能8位单片机相连接。因此该产品具有品质卓越、超快响应、抗干扰能力强、性价比极高等优点。每个DHT11传感器都在极为精确的湿度校验室中进行校准。校准系数以程序的形式存在OTP内存中，传感器内部在检测信号的处理过程中要调用这些校准系数。单线制串行接口，使系统集成变得简易快捷。超小的体积、极低的功耗，使其成为该类应用中，在苛刻应用场合的最佳选择。产品为4针单排引脚封装，连接方便。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200330203725264.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## Web开发
1. web网站简单定义  
　　web（World Wide Web）即全球广域网，也称为万维网，它是一种基于超文本和HTTP的、全球性的、动态交互的、跨平台的分布式图形信息系统。是建立在Internet上的一种网络服务，为浏览者在Internet上查找和浏览信息提供了图形化的、易于访问的直观界面，其中的文档及超级链接将Internet上的信息节点组织成一个互为关联的网状结构。
　　1989年CERN（欧洲粒子物理研究所）中由Tim Berners-Lee领导的小组提交了一个针对Internet的新协议和一个使用该协议的文档系统，该小组将这个新系统命名为Word Wide Web，它的目的在于使全球的科学家能够利用Internet交流自己的工作文档。
这个新系统被设计为允许Internet上任意一个用户都可以从许多文档服务计算机的数据库中搜索和获取文档。1990年末，这个新系统的基本框架已经在CERN中的一台计算机中开发出来并实现了,1991年该系统移植到了其他计算机平台，并正式发布。
2. web网站通常采用的是客户机-服务器架构(client – server model) ,而客户机通常情况下用户都是在浏览器里面进行操作，所以说当用户在浏览器里面输入网站地址的时候，交互就已经进行。
3. 网站内容 
我们在进行一个项目开发的时候，这个项目里面最少会包含下面的内容，并且对于不同的内容都会存储在不同的目录(文件夹)里面。这样对于团队项目开发能够起到很好的帮助。所以说一个程序员在进入公司得一段时间里，就需要去了解这家公司制定的一些项目规则以便能够适应公司得开发。
4.而我们常说的web网站就是指直接以浏览器为载体，通过web网络协议访问的站点，即是web网站。例如下面我们常见的这几个网站。
下面我们看到的这些网站，我们都可以说是web站点，简单一点说，无论你看到的网站是什么类型，只要是通过浏览器访问的，那么都可以说是web站点。而我们所熟知的一些语言，例如python、例如php、例如.net等等这些语言，当我们把这些语言用来开发网站的时候，那么我们的定位就是web开发人员。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020033020422634.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020033020411116.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200330204124283.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 核心技术
#### HTML语言
掌握HTML是网页的核心，是一种制作万维网页面的标准语言，是万维网浏览器使用的一种语言，它消除了不同计算机之间信息交流的障碍。因此，它是网络上应用最为广泛的语言，也是构成网页文档的主要语言，学好HTML是成为Web开发人员的基本条件。
HTML是一种标记语言，能够实现Web页面并在浏览器中显示。HTML5作为HTML的最新版本，引入了多项新技术，大大增强了对于应用的支持能力，使得Web技术不再局限于呈现网页内容。
随着CSS、JavaScript、Flash等技术的发展，Web对于应用的处理能力逐渐增强，用户浏览网页的体验已经有了较大的改善。不过HTML5中的几项新技术实现了质的突破，使得Web技术首次被认为能够接近于本地原生应用技术，开发Web应用真正成为开发者的一个选择。
HTML5可以使开发者的工作大大简化，理论上单次开发就可以在不同平台借助浏览器运行，降低开发的成本，这也是产业界普遍认为HTML5技术的主要优点之一。AppMobi、摩托罗拉、Sencha、Appcelerator等公司均已推出了较为成熟的开发工具，支持HTML5应用的发展。 [3] 
### CSS
学好CSS是网页外观的重要一点，CSS可以帮助把网页外观做得更加美观。
#### JavaScript
学习JavaScript的基本语法，以及如何使用JavaScript编程将会提高开发人员的个人技能。
#### 操作系统
了解Unix和Linux的基本知识，对于开发人员有益无害。
#### 网络服务器
了解Web服务器，包括对Apache的基本配置，htaccess配置技巧的掌握等。
(太多了)


## 参考资料
1.web网站开发基础博客 <https://www.cnblogs.com/liujunhang/articles/9197151.html>
2. 单片机菜鸟博哥 arduino esp8266 
<https://blog.csdn.net/dpjcn1990/category_9291479.html>



