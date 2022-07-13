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

float aht_temp,aht_hum;//��ʪ��  
//����������
int main(void)
 {	
	 //char PUB_BUF[256];//�ϴ����ݵ�buf
//	 const char *topics[] = {"mysmart/sub"};
	 unsigned short timeCount = 0;	//���ͼ������
	 unsigned char *dataPtr = NULL;
//     float length;
	 delay_init();	    	 //��ʱ������ʼ��	 
     Beep_Init();	 
	 NVIC_Configuration(); 	 //����NVIC�жϷ���2:2λ��ռ���ȼ���2λ��Ӧ���ȼ�
	 Hcsr04Init();//��������ʼ��
	 AHT_I2C_UserConfig();//��ʪ�ȴ�������ʼ��
	 Usart1_Init(115200);	 	//���ڳ�ʼ��Ϊ9600
	 Usart2_Init(115200);       //8266ͨѶ����
    
	 UsartPrintf(USART_DEBUG,"HardWare init\r\n");      
     UsartPrintf(USART_DEBUG,"��ʪ�ȴ�������ʼ��!\n");
	 	 

	 ESP8266_Init();//8266��ʼ��
	 while(OneNet_DevLink())//����onenet
	 delay_ms(500);

	 Beep_Set(BEEP_ON);				//���н���ɹ�
	 delay_ms(250);
	 Beep_Set(BEEP_OFF);
	 
	 //OneNet_Subscribe(topics, 1);
	  
   while(1) 
	  {	
	   
		if(++timeCount >= 40)									//���ͼ��1s��Ҳ����5s�ϴ�һ�����ݣ�1000/25=40
		{
			AHT10_Read_Humi_Temp(&aht_hum,&aht_temp);
			UsartPrintf(USART_DEBUG, "OneNet_SendData\r\n");
			OneNet_SendData();
			
			timeCount = 0;
			ESP8266_Clear();
		}
		
		  dataPtr = ESP8266_GetIPD(3);//�����Ҫ15�����룬����ѭ����һ��5������
		  if(dataPtr != NULL)
	   	  OneNet_RevPro(dataPtr);
		  delay_ms(10);    
	}			
 }

