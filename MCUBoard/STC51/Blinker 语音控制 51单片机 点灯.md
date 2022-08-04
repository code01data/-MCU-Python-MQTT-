---
categories:  #分类
    - 单片机
    - Blinker
    - 嵌入式
tags:   #标签
    - 51单片机
    - 嵌入式 
    - 物联网
---
# Blinker 语音控制 51单片机 点灯
<!-- more -->
## Blinker
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144027393.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
blinker是一套跨硬件、跨平台的物联网解决方案，提供APP端、设备端、服务器端支持，使用公有云服务进行数据传输存储。可用于智能家居、数据监测等领域，可以帮助用户更好更快地搭建物联网项目。
### blinker特性
●其由服务器端、app端、设备端组成，可以部署到几乎所有物联网平台
●ap端支持ios、android
●设备端可以使用蓝牙、WiFi、MQTT等方式接入，支持Arduino、freeRTOS、mbed OS、Linux等开发平台
●服务器端可以部署到阿里云、腾讯云、OneNET、百度云、AWS、google cloud等平台
●通过界面布局器，DIY用户可自己拖拽布局设备控制界面，自由打造你的物联网设备●通过专属SDK，认证用户可以使用Blinker开发自己的产品，并用于商业用途blinker
### 应用场景
●快速开发物联网/智能家居/无线遥控项目
●手机/语音助手控制设备
●蓝牙ble/局域网WiFi/远程MQTT接入设备
## Arduino
Arduino是一款便捷灵活、方便上手的开源电子原型平台。包含硬件（各种型号的Arduino板）和软件（ArduinoIDE)。由一个欧洲开发团队于2005年冬季开发。其成员包括Massimo Banzi、David Cuartielles、Tom Igoe、Gianluca Martino、David Mellis和Nicholas Zambetti等。
它构建于开放原始码simple I/O介面版，并且具有使用类似Java、C语言的Processing/Wiring开发环境。主要包含两个的部分：硬件部分是可以用来做电路连接的Arduino电路板；另外一个则是Arduino IDE，你的计算机中的程序开发环境。你只要在IDE中编写程序代码，将程序上传到Arduino电路板后，程序便会告诉Arduino电路板要做些什么了。
Arduino能通过各种各样的传感器来感知环境，通过控制灯光、马达和其他的装置来反馈、影响环境。板子上的微控制器可以通过Arduino的编程语言来编写程序，编译成二进制文件，烧录进微控制器。对Arduino的编程是通过 Arduino编程语言 (基于 Wiring)和Arduino开发环境(基于 Processing)来实现的。基于Arduino的项目，可以只包含Arduino，也可以包含Arduino和其他一些在PC上运行的软件，他们之间进行通信 (比如 Flash, Processing, MaxMSP)来实现。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144045354.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 学习过程
### 步骤
1. 注册点灯科技账号，注册米家账号
2. 米家绑定其他设备平台点灯科技blinker
3. 点灯科技blinker平台创建一个设备选择为Arduino,获取密钥
4. 使用arduino ide 使用nodemcu(esp8266模块) 下载代码（串口发送数据）
5. 51单片机进行进行串口操作，串口接收数据，进行操作。
6. ArduinoIDE 开发esp8266 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144140736.jpg#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020032914415436.jpg)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144207782.jpg#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144222562.jpg)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144234209.jpg#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020032914424444.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144253869.jpg#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144309256.jpg)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329144332336.jpg#pic_center)
### 软件部分
#### Arduino 代码
```c
* *****************************************************************
 * 
 * Blinker 库下载地址:
 * https://github.com/blinker-iot/blinker-library/archive/master.zip
 * 
 * Blinker 是一套跨硬件、跨平台的物联网解决方案，提供APP端、设备端、
 * 服务器端支持，使用公有云服务进行数据传输存储。可用于智能家居、
 * 数据监测等领域，可以帮助用户更好更快地搭建物联网项目。
 * 
 * 如果使用 ESP8266 接入 Blinker,
 * 请确保安装了 2.5.0 或更新的 ESP8266/Arduino 支持包。
 * https://github.com/esp8266/Arduino/releases
 * 
 * 如果使用 ESP32 接入 Blinker,
 * 请确保安装了 1.0.2 或更新的 ESP32/Arduino 支持包。
 * https://github.com/espressif/arduino-esp32/releases
 * 
 * 文档: https://doc.blinker.app/
 *       https://github.com/blinker-iot/blinker-doc/wiki
 * 
 * ****************************************************************
```

```c
#define BLINKER_WIFI
#define BLINKER_MIOT_LIGHT

#include <Blinker.h>

char auth[] = "ff07996779a7";//设备密钥//很重要的
char ssid[] = "MERCURY_3DE2";//你的wifi或者热点名称
char pswd[] = "88888888";//你的wifi或者热点密码


#define LED            D1


void miotPowerState(const String & state)
{
  BLINKER_LOG("need set power state: ", state);

  if (state == BLINKER_CMD_ON) 
  {
    digitalWrite(LED, LOW);
    Serial.print(1);

    BlinkerMIOT.powerState("on");
    BlinkerMIOT.print();
  }
  else if (state == BLINKER_CMD_OFF)
  {
    digitalWrite(LED, HIGH);

    BlinkerMIOT.powerState("off");
    BlinkerMIOT.print();
    Serial.print(0);
  }
}

void setup()
{
    Serial.begin(9600);   

    pinMode(LED, OUTPUT);
    digitalWrite(LED, LOW);

    Blinker.begin(auth, ssid, pswd);
    
    BlinkerMIOT.attachPowerState(miotPowerState);
}

void loop()
{
    Blinker.run();
}
```
#### STC89C51代码
```c
#include <reg52.h>

sbit LED =P2^0;

unsigned char a;

void ConfigUART(unsigned int baud)  //串口配置函数，baud为波特率
{
    SCON = 0x50;   //配置串口为模式1
	
    TMOD= 0x21;  //配置T1为模式2
		
    TH1 = 256 - (11095200/12/32) / baud;  //计算T1重载值
    TL1 = TH1;     //初值等于重载值
	
    ET1 = 0;       //禁止T1中断
 
    ES = 1;   //打开串口中断
	
    EA = 1;   //打开总中断
	
	  TR1 = 1;       //启动T1
}

void main ()
{
    ConfigUART(9600);  //配置波特率为9600

    while(1);
}


void InterruptUART() interrupt 4
{
	if (RI)  //接收到字节
	{
		RI = 0;  //手动清零接收中断标志
				
		a=SBUF;
				
		if(a =='1')
		    P2=0x00;//全部亮
		else 
		    P2=0xff;//全部灭
				
		SBUF=a;
   }
	
    if (TI)  //字节发送完毕
    {
      TI = 0;  //手动清零发送中断标志位
    }  
}
```
### 硬件部分
1. STC89C5x系列单片机
2. nodemcu esp8266 WIFI模块
3. 串口连接部分
   nodemcu ---- STC89C5x单片机
    RX      -->       TX
    TX      -->       RX
## 参考资料
1. Arduino ESP8266 学习 单片机菜鸟的博客
<https://blog.csdn.net/dpjcn1990?t=1>
2. 哔哩哔哩-UP主--雅痞1900
<https://space.bilibili.com/397351217?spm_id_from=333.788.b_765f7570696e666f.2>
（这个东西不不是我搞的，我只是把这个东西写成了一个笔记，毕竟一个渣渣，只能靠白嫖维持）
3. 视频学习（主要还是哔哩哔哩UP主提供的资料--哔哩哔哩）
<iframe src="//player.bilibili.com/player.html?aid=667534606&bvid=BV1Ka4y1t7wc&cid=170092797&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

