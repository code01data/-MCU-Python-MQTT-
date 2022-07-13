#include "delay.h"
#include "sys.h"
#include "usart.h"	 
#include "led.h"	
#include "key.h"	
#include "hc.h"	
#include "esp8266.h"
#include "onenet.h"
#include "mqttkit.h"
#include "beep.h"	
#include "AHT10.h"	

float aht_temp,aht_hum;//温湿度  
//测试主函数
int main(void)
 {	
	 //char PUB_BUF[256];//上传数据的buf
//	 const char *topics[] = {"mysmart/sub"};
	 unsigned short timeCount = 0;	//发送间隔变量
	 unsigned char *dataPtr = NULL;
//     float length;
	 delay_init();	    	 //延时函数初始化	 
     Beep_Init();	 
	 NVIC_Configuration(); 	 //设置NVIC中断分组2:2位抢占优先级，2位响应优先级
	 Hcsr04Init();//超声波初始化
	 AHT_I2C_UserConfig();//温湿度传感器初始化
	 Usart1_Init(115200);	 	//串口初始化为9600
	 Usart2_Init(115200);       //8266通讯串口
    
	 UsartPrintf(USART_DEBUG,"HardWare init\r\n");      
     UsartPrintf(USART_DEBUG,"温湿度传感器初始化!\n");
	 	 

	 ESP8266_Init();//8266初始化
	 while(OneNet_DevLink())//接入onenet
	 delay_ms(500);

	 Beep_Set(BEEP_ON);				//鸣叫接入成功
	 delay_ms(250);
	 Beep_Set(BEEP_OFF);
	 
	 //OneNet_Subscribe(topics, 1);
	  
   while(1) 
	  {	
	   
		if(++timeCount >= 40)									//发送间隔1s，也就是5s上传一次数据，1000/25=40
		{
			AHT10_Read_Humi_Temp(&aht_hum,&aht_temp);
			UsartPrintf(USART_DEBUG, "OneNet_SendData\r\n");
			OneNet_SendData();
			
			timeCount = 0;
			ESP8266_Clear();
		}
		
		  dataPtr = ESP8266_GetIPD(3);//完成需要15个毫秒，三次循环，一次5个毫秒
		  if(dataPtr != NULL)
	   	  OneNet_RevPro(dataPtr);
		  delay_ms(10);    
	}			
 }

