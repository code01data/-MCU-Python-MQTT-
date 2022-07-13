---
categories:  #分类
    - C
    - 嵌入式 STM32
    - 串口通信
tags:   #标签
    - C
    - 软件开发
    - USART 串口通信
---
# STM32F1案例 串口USART使用
## 硬件平台
1. 野火STM32F103ZET6 霸道V2开发板
2. 正点原子F1系列开发板
3. STM32F103ZET6核心板
4. ST7735 TFT液晶显示屏 
![STM32产品](https://img-blog.csdnimg.cn/20201002210908329.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20201105223425237.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

## 软件平台
1. Keil MDK 5.31
2. 串口调试助手

## STM32F103ZET6 串口
### 结构
![USART 功能框图](https://img-blog.csdnimg.cn/2020111115592397.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

### 串口引脚分布与解释
1. TX：发送数据输出引脚。
2. RX：接收数据输入引脚。
3. SW_RX：数据接收引脚，只用于单线和智能卡模式，属于内部引脚，没有具体外部引脚。
4. nRTS：请求以发送(Request To Send)，n 表示低电平有效。如果使能 RTS 流控制，当USART 接收器准备好接收新数据时就会将 nRTS 变成低电平；当接收寄存器已满时，nRTS将被设置为高电平。该引脚只适用于硬件流控制。
5. nCTS：清除以发送(Clear To Send)，n 表示低电平有效。如果使能 CTS 流控制，发送器在发送下一帧数据之前会检测 nCTS 引脚，如果为低电平，表示可以发送数据，如果为高电平则在发送完当前数据帧之后停止发送。该引脚只适用于硬件流控制。
6. SCLK：发送器时钟输出引脚。这个引脚仅适用于同步模式。
![STM32F103VET6 芯片的 USART 引脚](https://img-blog.csdnimg.cn/20201111155054300.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

###  串口配置步骤
1. 使能RX和TX引脚GPIO时钟和USART时钟；
2. 初始化 GPIO，并将GPIO复用到USART.上；
3. 配置 USART参数；
4. 配置中断控制器并使能USART接收中断；
5. 使 能USART；
6. 在USART接收中断服务函数实现数据接收和发送。

### MAIN.C
```c
//--------------------------------------------------------------------------------------------------
//  包含的系统外设头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
#include "sys.h"
#include "delay.h"
#include "USART.H"
#include "timer.h"
#include "led.h"
#include "LCD.H"
#include "QDTFT_demo.h"
#include "Picture.h"
#include "key.h"
#include "oled.h"
#include "beep.h"

//--------------------------------------------------------------------------------------------------
//  定义引用变量    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
//unsigned char num;
unsigned int time1 =0;
unsigned int timeCount1=0;
unsigned int timeflag1 =0; 

unsigned int time2 =0;
unsigned int timeCount2=0;
unsigned int timeflag2 =0; 

unsigned int time3 =0;
unsigned int timeCount3=0;
unsigned int timeflag3 =0; 

unsigned int time4 =0;
unsigned int timeCount4=0;
unsigned int timeflag4 =0;

unsigned int Basictime =0;
unsigned int BasictimeCount=0;
unsigned int Basictimeflag =0; 
//--------------------------------------------------------------------------------------------------
//  硬件端口定义    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
//  引用函数声明    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
void LED_TEST(void);
void Hareware_Iint(void);
void TFT_ShowTEST(void);
void Usart_Test(void);
void oled_test(void);
void Timer_Configure(void);
void GeneralTimer_Test(void);
void Basic_Timer_Test(void);
void Basic_GeneralTimer_Test(void);
void USart_Configure(void);
//==================================================================================================
//  实现功能: 硬件初始化配置
//  函数说明: Hareware_Iint
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void Hareware_Iint(void)
{
    delay_init();		  
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);  //中断优先级分组 分2组
    Timer_Configure();//定时器配置
    USart_Configure();
    LED_Init();	//板载LED配置
    KEY_Init(); //板载独立按键测试
    OLED_Init(); // IIC 0.96 oled
    Lcd_Init();  //ST7735 LCD配置
    LCD_LED_SET; //设置背光
    Lcd_Clear(WHITE); //清屏 
    BEEP_Init(); //蜂鸣器配置
     
}

//==================================================================================================
//  实现功能: LED测试函数
//  函数说明: PB5 LED0  PE5 LED1
//  函数备注: 板载LED 正常 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void LED_TEST(void)
{
      LED0=0;
      delay_ms(500);
      LED0=1;
      delay_ms(500);
      LED1=0;
      delay_ms(500);
      LED1=1;
      delay_ms(500);
}
//==================================================================================================
//  实现功能: TFT_ShowTEST测试函数
//  函数说明: 
//  函数备注: ST7735 TFTLCD 测试正常
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void  TFT_ShowTEST(void)
{
      Redraw_Mainmenu();
      Num_Test();
      Font_Test();
      Color_Test();
      TFT_ShowImage(gImage_qq);
    
      Lcd_Clear(WHITE); //清屏 
      TFT_ShowASCII_08x16(0,8,'&',Red,White);
      delay_ms(1000);
      TFT_ShowString_16x16(16,16,"By delehub",Red,White);
      delay_ms(1000);
      TFT_ShowNumber_SignedInteger_16x16(16,32,1234,5,Red,White);
      delay_ms(1000);
      TFT_ShowNumber_Float_16x16(0,48,123.56,4,3,Red,White);
      delay_ms(1000);
      TFT_ShowString_16x16(16,60,"By 2020-11-5",Red,White);
      delay_ms(1000);
      TFT_ShowString_16x16(0,90,"stm32 tft test ",Red,White);
      delay_ms(1000);
      
}
//==================================================================================================
//  实现功能: 串口配置配置
//  函数说明: TIM2,3,4,5
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void USart_Configure(void)
{
    UART4_Configuration(9600);//串口4配置
    USART1_Configuration(9600);//串口1配置
}
//==================================================================================================
//  实现功能: Usart_Test测试函数
//  函数说明: 串口配置测试函数  STM32F103ZET6 5个串口
//  函数备注: USART1  USART2 USART3 UART4 UART5 
//   TX端口   PA9     PA2    PB10   PC10  PC12
//   RX端口   PA10    PA3    PB11   PC11  PD2
//  串口1~5 测试正常 打印效果正常
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void Usart_Test(void)
{
  
   
  #if 0
  UART_SendString(USART1,"usart1 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,0,"usart1 test",Red,White);
  #endif
  
  #if 0
  UART_SendString(USART2,"usart2 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,16,"usart2 test",Red,White);
  #endif
  
  #if 0
  UART_SendString(USART3,"usart3 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,32,"usart3 test",Red,White);
  #endif
  
  #if 0
  UART_SendString(UART4,"uart4 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,48,"uart4 test",Red,White);
  #endif
  
  #if 0 
  UART_SendString(UART5,"uart5 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,54,"uart5 test",Red,White);
  #endif
  
  #if 1
  UART_SendNumber_SignedInteger(USART1,123,4);
  UART_SendLine(USART1);
  delay_ms(500);
  UART_SendNumber_UnsignedInteger(USART1,123,4);
  UART_SendLine(USART1);
  delay_ms(500);
  UART_SendNumber_Float(USART1,123.56,4,3);
  UART_SendLine(USART1);
  delay_ms(500);
  UART_SendNumber_Binary(USART1,9,4);
  UART_SendLine(USART1);
  delay_ms(500);
  
  #endif
  
}

//==================================================================================================
//  实现功能: oled_test测试函数
//  函数说明: 采用软件IIC 进行配置   SDA PB9  SCL PB10 
//  函数备注:  测试正常
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void oled_test(void)
{
  OLED_ShowChar_08x16(0,0,'@');
  OLED_ShowChar_08x16(16,0,'&');
  OLED_ShowNumber_SignedInteger_06x08(0,2,1234,5);
  OLED_ShowNumber_UnsignedInteger_06x08(48,2,1234,5);
  OLED_ShowNumber_Float_06x08(0,4,123.46,3,3);
  OLED_ShowString_06x08(32,0,"oled");
  OLED_ShowCHinese(0,6,0);
  OLED_ShowCHinese(16,6,1);
  OLED_ShowCHinese(32,6,2);
  OLED_ShowCHinese(48,6,3);
  OLED_ShowCHinese(64,6,4);
//  OLED_Clear();
}
//==================================================================================================
//  实现功能: Key_Test 按键测试函数
//  函数说明: KEY0 PE4 KEY1 PE3 KEY_WK_UP PA0
//  函数备注: KEY0_PRES 1  KEY1_PRES 1  WKUP_PRES 3 
//----------------------------------------- ---------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void Key_Test(void)
{
      unsigned char key_value=0;
      TFT_ShowString_16x16(0,0,"KEY:",Red,White);
      key_value=KEY_Scan(0);
  
      if(key_value==3)
      {
        TFT_ShowNumber_SignedInteger_16x16(60,0,key_value,2,Red,White);
        //USART_SendString(USART1,"key_value:3 \r\n");
      }
      if(key_value==2)
      {
        TFT_ShowNumber_SignedInteger_16x16(60,0,key_value,2,Red,White);
        //USART_SendString(USART1,"key_value:2 \r\n");
      }
      if(key_value==1)
      {
        TFT_ShowNumber_SignedInteger_16x16(60,0,key_value,2,Red,White);
        //USART_SendString(USART1,"key_value:1 \r\n");
      }
}
//==================================================================================================
//  实现功能: 定时器配置
//  函数说明: TIM2,3,4,5
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void Timer_Configure(void)
{
    /*定时器配置*/
    BASIC_TIM_Init();
    TIM5_Init(9999,7199);
    TIM3_Int_Init(9999,7199);
    TIM2_Int_Init(9999,7199);
    TIM4_Int_Init(9999,7199);
    
}
//==================================================================================================
//  实现功能: 通用定时器定时器测试
//  函数说明: TIM2,3,4,5
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void GeneralTimer_Test(void)
{
  if ( timeflag1 == 1 )  // TIM5
    {
      timeflag1 = 0;
      timeCount1++;     
			LED1=!LED1; 
      
      if (timeCount1 == 60)
      {
        timeCount1=0;
      }
      TFT_ShowNumber_SignedInteger_16x16(90,32,timeCount1,2,Blue1,White);
    }  

    
    if ( timeflag2 == 1 )  //TIM3     
    {
      timeflag2 = 0;
      timeCount2++;    

      if (timeCount2 == 60)
      {
        timeCount2=0;
      }
      TFT_ShowNumber_SignedInteger_16x16(90,60,timeCount2,2,Blue1,White);
    } 

     if ( timeflag3 == 1 )   //TIM2  
    {
      timeflag3 = 0;
      timeCount3++;    

      if (timeCount3 == 60)
      {
        timeCount3=0;
      }
      TFT_ShowNumber_SignedInteger_16x16(90,90,timeCount3,2,Green,White);
    }  
    
    if ( timeflag4 == 1 )  //TIM4   
    {
      timeflag4 = 0;
      timeCount4++;    

      if (timeCount4 == 60)
      {
        timeCount4=0;
      }
      TFT_ShowNumber_SignedInteger_16x16(90,120,timeCount4,2,Green,White);
    }  
    
    
   
}
//==================================================================================================
//  实现功能: 基本定时器定时器测试
//  函数说明: TIM6,7
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void Basic_Timer_Test(void)
{
   if ( Basictime == 1000 ) /* 1000 * 1 ms = 1s 时间到 */      
    {
      Basictime = 0;
      BasictimeCount++;    

      if (BasictimeCount == 60)
      {
        BasictimeCount=0;
      }
      TFT_ShowNumber_SignedInteger_16x16(90,140,BasictimeCount,2,Black,White);
    } 
}

//==================================================================================================
//  实现功能: 定时器定时 1s 测试
//  函数说明:  
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void Basic_GeneralTimer_Test(void)
{
  GeneralTimer_Test();//通用定时器定时器测试
  Basic_Timer_Test();//基本定时器定时器测试
}

#if 0

    TFT_ShowString_16x16(0,0,"stm32 timertest",Magenta,White);
    TFT_ShowString_16x16(0,32,"timeCount1 ",Blue1,White);
    TFT_ShowString_16x16(0,60,"timeCount2 ",Red,White);
    TFT_ShowString_16x16(0,90,"timeCount3 ",Red,White);
    TFT_ShowString_16x16(0,120,"timeCount4",Red,White);
    TFT_ShowString_16x16(0,140,"Basictime",Magenta,White);

#endif

//==================================================================================================
//  实现功能: 主函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
int main(void)          
{	
    Hareware_Iint();//硬件初始化配置
  
    while(1)
    { 
       Usart_Test();
    }
}
```

### USART.C

```c
#include "USART.H"
//==================================================================================================
//  实现功能: USART1_Configuration串口配置配置
//  函数说明: USART1初始化函数
//  函数备注: bound:波特率
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
//#if EN_USART1_RX   //如果使能了接收  
// 使用串口中断时 解除注释 #if EN_USART1_RX 
//注意,读取USARTx->SR能避免莫名其妙的错误   	
u8 USART_RX_BUF[USART_REC_LEN];     //接收缓冲,最大USART_REC_LEN个字节.
//接收状态
//bit15，	接收完成标志
//bit14，	接收到0x0d
//bit13~0，	接收到的有效字节数目
u16 USART_RX_STA=0;       //接收状态标记	  
  

void USART1_Configuration(u32 bound)
{
	//GPIO端口设置
	GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1|RCC_APB2Periph_GPIOA, ENABLE);	//使能USART1，GPIOA时钟

	//USART1_TX   GPIOA.9
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9; //PA.9
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;	//复用推挽输出
	GPIO_Init(GPIOA, &GPIO_InitStructure);//初始化GPIOA.9

	//USART1_RX	  GPIOA.10初始化
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;//PA10
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;//浮空输入
	GPIO_Init(GPIOA, &GPIO_InitStructure);//初始化GPIOA.10  

	//Usart1 NVIC 配置
	NVIC_InitStructure.NVIC_IRQChannel = USART1_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority=2 ;//抢占优先级3
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;		//子优先级3
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;			//IRQ通道使能
	NVIC_Init(&NVIC_InitStructure);	//根据指定的参数初始化VIC寄存器

	//USART 初始化设置

	USART_InitStructure.USART_BaudRate = bound;//串口波特率
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;//字长为8位数据格式
	USART_InitStructure.USART_StopBits = USART_StopBits_1;//一个停止位
	USART_InitStructure.USART_Parity = USART_Parity_No;//无奇偶校验位
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;//无硬件数据流控制
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;	//收发模式

    USART_Init(USART1, &USART_InitStructure); //初始化串口1
    USART_ITConfig(USART1, USART_IT_RXNE, ENABLE);//开启串口接受中断
    USART_Cmd(USART1, ENABLE);                    //使能串口1 

}
//==================================================================================================
//  实现功能: USART1_IRQHandler串口中断服务函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void USART1_IRQHandler(void)                	//串口1中断服务程序
{
	u8 r;
	if(USART_GetITStatus(USART1, USART_IT_RXNE) != RESET)  //接收中断
	{
		r =USART_ReceiveData(USART1);//(USART1->DR);	//读取接收到的数据
		USART_SendData(USART1,r);
		while(USART_GetFlagStatus(USART1,USART_FLAG_TC) != SET);
	} 
	USART_ClearFlag(USART1,USART_FLAG_TC);
} 	



//#endif

//==================================================================================================
//  实现功能: USART2_Configuration串口配置配置
//  函数说明: USART2初始化函数
//  函数备注: bound:波特率
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

//#if EN_USART2_RX   //如果使能了接收

void USART2_Configuration(u32 bound)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef NVIC_InitStructure;        

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE );
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2, ENABLE );

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2; //USART2 TX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; //复用推挽输出；
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOA, &GPIO_InitStructure); //端口A；

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3; //USART2 RX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; //浮空输入；
    GPIO_Init(GPIOA, &GPIO_InitStructure); //端口A；

    USART_InitStructure.USART_BaudRate = bound; //波特率；
    USART_InitStructure.USART_WordLength = USART_WordLength_8b; //数据位8位；
    USART_InitStructure.USART_StopBits = USART_StopBits_1; //停止位1位；
    USART_InitStructure.USART_Parity = USART_Parity_No ; //无校验位；
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    //无硬件流控；
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    //收发模式；
    USART_Init(USART2, &USART_InitStructure);//配置串口参数；

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2); //设置中断组，4位抢占优先级，4位响应优先级；

    NVIC_InitStructure.NVIC_IRQChannel = USART2_IRQn; //中断号；
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2; //抢占优先级；
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3; //响应优先级；
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);

    USART_ITConfig(USART2, USART_IT_RXNE, ENABLE);
    USART_Cmd(USART2, ENABLE); //使能串口；
}


//==================================================================================================
//  实现功能: USART2_IRQHandler串口中断服务函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void USART2_IRQHandler(void) //中断处理函数；
{ 
  u8 r;
  if(USART_GetITStatus(USART2, USART_IT_RXNE) != RESET)  //接收中断
  {
    r =USART_ReceiveData(USART2);//(USART1->DR);	//读取接收到的数据
    USART_SendData(USART2,r);
    while(USART_GetFlagStatus(USART2,USART_FLAG_TC) != SET);
  } 
  USART_ClearFlag(USART2,USART_FLAG_TC);
} 

//#endif

//==================================================================================================
//  实现功能: USART3_Configuration串口配置配置
//  函数说明: USART3初始化函数
//  函数备注: bound:波特率
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

//#if EN_USART3_RX   //如果使能了接收

void USART3_Configuration(u32 bound)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef NVIC_InitStructure;        

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE );
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3, ENABLE );

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10; //USART3 TX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; //复用推挽输出；
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOB, &GPIO_InitStructure); //端口B；

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11; //USART3 RX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; //浮空输入；
    GPIO_Init(GPIOB, &GPIO_InitStructure); //端口B；

    USART_InitStructure.USART_BaudRate = bound; //波特率；
    USART_InitStructure.USART_WordLength = USART_WordLength_8b; //数据位8位；
    USART_InitStructure.USART_StopBits = USART_StopBits_1; //停止位1位；
    USART_InitStructure.USART_Parity = USART_Parity_No ; //无校验位；
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    //无硬件流控；
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    //收发模式；
    USART_Init(USART3, &USART_InitStructure);//配置串口参数；

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2); //设置中断组，4位抢占优先级，4位响应优先级；

    NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn; //中断号；
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2; //抢占优先级；
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3; //响应优先级；
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);

    USART_ITConfig(USART3, USART_IT_RXNE, ENABLE);
    USART_Cmd(USART3, ENABLE); //使能串口；
}


//==================================================================================================
//  实现功能: USART3_IRQHandler串口中断服务函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void USART3_IRQHandler(void) //中断处理函数；
{
  u8 r;
  if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)  //接收中断
  {
    r =USART_ReceiveData(USART3);//(USART1->DR);	//读取接收到的数据
    USART_SendData(USART3,r);
    while(USART_GetFlagStatus(USART3,USART_FLAG_TC) != SET);
  } 
  USART_ClearFlag(USART3,USART_FLAG_TC);
} 

//#endif

//==================================================================================================
//  实现功能: UART4_Configuration串口配置配置
//  函数说明: UART4初始化函数
//  函数备注: bound:波特率
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

//#if EN_USART4_RX

void UART4_Configuration(u32 bound)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef NVIC_InitStructure;        

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE );
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART4, ENABLE );

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10; //UART4 TX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; //复用推挽输出；
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOC, &GPIO_InitStructure); //端口C；

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11; //UART4 RX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; //浮空输入；
    GPIO_Init(GPIOC, &GPIO_InitStructure); //端口C；

    USART_InitStructure.USART_BaudRate = bound; //波特率；
    USART_InitStructure.USART_WordLength = USART_WordLength_8b; //数据位8位；
    USART_InitStructure.USART_StopBits = USART_StopBits_1; //停止位1位；
    USART_InitStructure.USART_Parity = USART_Parity_No ; //无校验位；
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    //无硬件流控；
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    //收发模式；
    USART_Init(UART4, &USART_InitStructure);//配置串口参数；

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2); //设置中断组，4位抢占优先级，4位响应优先级；

    NVIC_InitStructure.NVIC_IRQChannel = UART4_IRQn; //中断号；
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2; //抢占优先级；
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0; //响应优先级；
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);

    USART_ITConfig(UART4, USART_IT_RXNE, ENABLE);
    USART_Cmd(UART4, ENABLE); //使能串口；
}


//==================================================================================================
//  实现功能: UART4_IRQHandler串口中断服务函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void UART4_IRQHandler(void) //中断处理函数；
{
  u8 r;
  if(USART_GetITStatus(UART4, USART_IT_RXNE) != RESET)  //接收中断
  {
    r =USART_ReceiveData(UART4);//(USART1->DR);	//读取接收到的数据
    USART_SendData(UART4,r);
    while(USART_GetFlagStatus(UART4,USART_FLAG_TC) != SET);
  } 
  USART_ClearFlag(UART4,USART_FLAG_TC);
} 

//#endif

//==================================================================================================
//  实现功能: UART5_Configuration串口配置配置
//  函数说明: UART5初始化函数
//  函数备注: bound:波特率
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

//#if EN_USART5_RX

void UART5_Configuration(u32 bound)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    NVIC_InitTypeDef NVIC_InitStructure;        

    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC|RCC_APB2Periph_GPIOD, ENABLE );
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART5, ENABLE );

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_12; //UART5 TX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP; //复用推挽输出；
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOC, &GPIO_InitStructure); //端口C；

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2; //UART5 RX；
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; //浮空输入；
    GPIO_Init(GPIOD, &GPIO_InitStructure); //端口D；

    USART_InitStructure.USART_BaudRate = bound; //波特率；
    USART_InitStructure.USART_WordLength = USART_WordLength_8b; //数据位8位；
    USART_InitStructure.USART_StopBits = USART_StopBits_1; //停止位1位；
    USART_InitStructure.USART_Parity = USART_Parity_No ; //无校验位；
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    //无硬件流控；
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    //收发模式；
    USART_Init(UART5, &USART_InitStructure);//配置串口参数；

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2); //设置中断组，4位抢占优先级，4位响应优先级；

    NVIC_InitStructure.NVIC_IRQChannel = UART5_IRQn; //中断号；
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2; //抢占优先级；
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3; //响应优先级；
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);

    USART_ITConfig(UART5, USART_IT_RXNE, ENABLE);
    USART_Cmd(UART5, ENABLE); //使能串口；
}

//==================================================================================================
//  实现功能: UART5_IRQHandler串口中断服务函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void UART5_IRQHandler(void) //中断处理函数；
{
  u8 r;
  if(USART_GetITStatus(UART5, USART_IT_RXNE) != RESET)  //接收中断
  {
    r =USART_ReceiveData(UART5);//(USART1->DR);	//读取接收到的数据
    USART_SendData(UART5,r);
    while(USART_GetFlagStatus(UART5,USART_FLAG_TC) != SET);
  } 
  USART_ClearFlag(UART5,USART_FLAG_TC);
} 

//#endif


//==================================================================================================
//  函数功能: USART 发送字节
//  函数标记: 内设驱动函数
//  函数说明: 本函数没有考虑发送9位数据可能性
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Byte - 字节  取值范文 - ASCII字符
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendChar(USART_TypeDef* USARTx,unsigned char Char)
{
   while((USARTx -> SR & 0x40) == 0);              // 等待上次发送完成   
    USARTx -> DR = Char;                            // 装载本次发送数据  
}

//==================================================================================================
//  函数功能: USART 接收字符
//  函数标记: 内设驱动函数
//  函数说明: 
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//  输出参量: Char - 待接收字节  取值范围 - ASCII字符
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
unsigned char UART_ReceiveChar(USART_TypeDef* USARTx)
{
    return USARTx->DR;
}

//==================================================================================================
//  函数功能: USART 发送字符串
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            String - 待发送字符串指针  取值范文 - ASCII字符串
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendString(USART_TypeDef* USARTx,unsigned char *String)
{
  while(*String != '\0')                          // \0 表示字符串结束标志，通过检测是否字符串末尾
    {
        UART_SendChar(USARTx, *String);
        String++;
    }
}


//  函数功能: USART 发送数组
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Array - 待发送数组的指针  取值范围 - 指针类型
//            Count - 待发送数组的数量  取值范围 - 0~255
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendArray(USART_TypeDef* USARTx, unsigned char *Array, unsigned char Count)
{
    unsigned char i = 0;                            // 定义局部变量 用于函数循环
    for(i=0; i<Count; i++)
    {
        UART_SendChar(USARTx, Array[i]);    
    }
}

//==================================================================================================
//  函数功能: USART 发送回车换行
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendLine(USART_TypeDef* USARTx)
{
    UART_SendChar(USARTx, 0x0D);                   // 换行
    UART_SendChar(USARTx, 0x0A);                   // 回车
}

//==================================================================================================
//  函数功能: USART 发送有符号整型数字
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Number - 待发送整数  取值范围 - 整型类型 -99999~+99999
//            Count - 显示的位数  取值范围 - 1~5
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendNumber_SignedInteger(USART_TypeDef* USARTx, signed short int Number, unsigned char Count)
{
    unsigned char NumberArray[5] = {0};             // 定义局部数组，用于数据存储
    
    // 判断 整型数字正负
    if(Number<0)
    {
        Number = 0 - Number;                        // 负数转整数
        UART_SendChar(USARTx,'-');
    }
    else
    {
        UART_SendChar(USARTx,'+');
    }
        
    // 计算各位数值的字符
    if(Count>4) NumberArray[0]=(Number/10000) % 10 + 0x30; 
    if(Count>3) NumberArray[1]=(Number/1000 ) % 10 + 0x30; 
    if(Count>2) NumberArray[2]=(Number/100  ) % 10 + 0x30; 
    if(Count>1) NumberArray[3]=(Number/10   ) % 10 + 0x30; 
    if(Count>0) NumberArray[4]=(Number/1    ) % 10 + 0x30; 
   
    // 发送串口数据
    UART_SendArray(USARTx,&NumberArray[5-Count],Count);
}

//==================================================================================================
//  函数功能: USART 发送无符号整型数字
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Number - 待发送整数  取值范围 - 整型类型 0~99999
//            Count - 显示的位数  取值范围 - 1~5
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendNumber_UnsignedInteger(USART_TypeDef* USARTx, unsigned short int Number, unsigned char Count)
{
    unsigned char NumberArray[5] = {0};             // 定义局部数组，用于数据存储
    
    // 断言检查参数
    
    
    // 执行相关操作
    // 计算各位数值的字符
    if(Count>4) NumberArray[0]=(Number/10000) % 10 + 0x30;
    if(Count>3) NumberArray[1]=(Number/1000 ) % 10 + 0x30;
    if(Count>2) NumberArray[2]=(Number/100  ) % 10 + 0x30;
    if(Count>1) NumberArray[3]=(Number/10   ) % 10 + 0x30;
    if(Count>0) NumberArray[4]=(Number/1    ) % 10 + 0x30;
    
    // 发送串口数据
    UART_SendArray(USARTx,&NumberArray[5-Count],Count);
}

//==================================================================================================
//  函数功能: USART 发送数字 浮点类型
//  函数标记: 内设驱动函数
//  函数说明: 本函数打印浮点数字与实际输入数字存在偏差
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Number - 待发送浮点型数字  取值范围 - -99999.99999~99999.99999
//            Count1 - 整数显示位数  取值范围 - 0~5
//            Count2 - 小数显示位数  取值范围 - 0~5
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendNumber_Float(USART_TypeDef* USARTx, float Number, unsigned char Count1, unsigned char Count2)
{
    unsigned char Number_Integer_Array[5];          // 定义局部数组 用于存储整数位各位数据
    unsigned char Number_Decimal_Array[5];          // 定义局部数组 用于存储小数位各位数据

    unsigned long int  Number_Integer = 0;          // 定义局部变量 表示浮点数的整数部分
    unsigned long int  Number_Decimal = 0;          // 定义局部变量 表示浮点数的小数部分

    // 判断 浮点数字正负
    if(Number < 0)
    {
        Number = 0 - Number;
        UART_SendChar(USARTx, '-');
    }
    else
    {
        UART_SendChar(USARTx, '+');
    }
    
    // 限制 发送位数
    // 由于由于float型的有效十进制数值最多为7位，即整数位 + 小数位 数量一定小于等于7
    while((Count1 + Count2 > 7 ))
    {
        if((Count1 > 5) && (Count1 != 0))
        {
            --Count1;
        }
        else
        {
            --Count2;
        }
    }
    
    // 分离 整数位与小数位
    // 取整数部分
    Number_Integer = (unsigned long int)(Number);  
    // 取小数部分 1e5科学计数法表示10000
    Number_Decimal = (unsigned long int)((Number - Number_Integer + 0.000005) * 1e5);
        
    // 计算各位数值的字符
    if(Count1>4) Number_Integer_Array[0]=(Number_Integer/10000) % 10 + 0x30; 
    if(Count1>3) Number_Integer_Array[1]=(Number_Integer/1000 ) % 10 + 0x30; 
    if(Count1>2) Number_Integer_Array[2]=(Number_Integer/100  ) % 10 + 0x30; 
    if(Count1>1) Number_Integer_Array[3]=(Number_Integer/10   ) % 10 + 0x30; 
    if(Count1>0) Number_Integer_Array[4]=(Number_Integer/1    ) % 10 + 0x30; 
    
    if(Count2>0) Number_Decimal_Array[0]=(Number_Decimal/10000) % 10 + 0x30; 
    if(Count2>1) Number_Decimal_Array[1]=(Number_Decimal/1000 ) % 10 + 0x30; 
    if(Count2>2) Number_Decimal_Array[2]=(Number_Decimal/100  ) % 10 + 0x30; 
    if(Count2>3) Number_Decimal_Array[3]=(Number_Decimal/10   ) % 10 + 0x30; 
    if(Count2>4) Number_Decimal_Array[4]=(Number_Decimal/1    ) % 10 + 0x30; 
   
    UART_SendArray(USARTx, &Number_Integer_Array[5-Count1], Count1);       // 显示整数位
    UART_SendChar(USARTx, '.');
    UART_SendArray(USARTx, &Number_Decimal_Array[0],        Count2);       // 显示小数位
}

//==================================================================================================
//  函数功能: USART 发送数字 二进制数字
//  函数标记: 内设驱动函数
//  函数说明: 无
//--------------------------------------------------------------------------------------------------
//  输入参量: USARTx - 通道号  取值范围 - USARTx1/USARTx2/USARTx3/UARTx4/UARTx5
//            Number - 待发送有符号长整型数字  取值范围 - -99999.99999~99999.99999
//            Count - 整数显示位数  取值范围 - 0~5
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
void UART_SendNumber_Binary(USART_TypeDef* USARTx,int Number,unsigned char Count)
{
    unsigned char i = 0;
    
    for(i=Count; i>0; i--)
    {
        if(Number & ( 1 << (Count-1) ))
        {
            UART_SendChar(USARTx,'1');
        }
        else
        {
            UART_SendChar(USARTx,'0');
        }
        Number <<= 1;
    }
}
```
### USART.H

```c
#ifndef __USART_H__
#define __USART_H__

#include "sys.h"

/*******************************************************************************
// STM32C串口1 中断测试
*******************************************************************************/ 

//--------------------------------------------------------------------------------------------------
//  宏自定义声明    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
#define USART_REC_LEN  			200  	//定义最大接收字节数 200

#define EN_USART1_RX 			1		//使能（1）/禁止（0）串口1接收
#define EN_USART2_RX 			1		//使能（1）/禁止（0）串口1接收  	
#define EN_USART3_RX 			1		//使能（1）/禁止（0）串口1接收 

#define EN_USART4_RX 			1		//使能（1）/禁止（0）串口1接收  	
#define EN_USART5_RX 			1		//使能（1）/禁止（0）串口1接收 
//--------------------------------------------------------------------------------------------------
//  定义引用变量    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
//如果想串口中断接收，请不要注释以下宏定义
extern u8  USART_RX_BUF[USART_REC_LEN]; //接收缓冲,最大USART_REC_LEN个字节.末字节为换行符 
extern u16 USART_RX_STA;         	    	//接收状态标记	


//==================================================================================================
//  实现功能: 串口配置函数
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

void USART1_Configuration(u32 bound);
void USART2_Configuration(u32 bound);
void USART3_Configuration(u32 bound);
void UART4_Configuration(u32 bound);
void UART5_Configuration(u32 bound);


//==================================================================================================
//  实现功能: 串口发送函数
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
void UART_SendChar(USART_TypeDef* USARTx,unsigned char Char);
void UART_SendString(USART_TypeDef* USARTx,unsigned char *String);
unsigned char UART_ReceiveChar(USART_TypeDef* USARTx);
//  USART 发送数组 
void UART_SendArray(USART_TypeDef* USARTx, unsigned char *Array, unsigned char Count);

//  USART 发送回车换行
void UART_SendLine(USART_TypeDef* USARTx);

//  USART 发送数字 
void UART_SendNumber_SignedInteger(USART_TypeDef* USARTx, signed short int Number, unsigned char Count);
void UART_SendNumber_UnsignedInteger(USART_TypeDef* USARTx, unsigned short int Number, unsigned char Count);
void UART_SendNumber_Float(USART_TypeDef* USARTx, float Number, unsigned char Count1, unsigned char Count2);
void UART_SendNumber_Binary(USART_TypeDef* USARTx, int Number, unsigned char Count);

#endif
```

### 串口打印效果
![串口发送函数](https://img-blog.csdnimg.cn/20201111155436387.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![串口1 串口4测试](https://img-blog.csdnimg.cn/20201111155436252.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)


