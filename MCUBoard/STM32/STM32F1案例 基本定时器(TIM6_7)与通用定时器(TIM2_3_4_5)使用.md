---
categories:  #分类
    - C
    - 嵌入式 STM32
    - 定时器
tags:   #标签
    - C
    - 软件开发
    - 嵌入式STM32 
    - 野火F1系列开发板
    - TFT液晶显示屏
    - 基本定时器 通用定时器
---
# STM32F1案例 ST7735 TFT液晶显示屏综合库使用
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
## STM32F103ZET6 定时器
####  STM32F1系列中，除了互联型的产品，共有 8 个定时器。

1. 基本定时器 
TIM6和 TIM7是一个 16 位的只能向上计数的定时器，
功能：只能定时，没有外部 IO。

2. 通用定时器 
TIM2/3/4/5 是一个 16 位的可以向上/下计数的定时器，
功能：可以定时，可以输出比较，可以输入捕捉，每个定时器有四个外部 IO。

3. 高级定时器 
TIM1/8是一个 16 位的可以向上/下计数的定时器，
功能：可以定时，可以输出比较，可以输入捕捉，还可以有三相电机互补输出信号，每个定时器有 8 个外部 IO。
![定时器分布情况](https://img-blog.csdnimg.cn/20201109233843761.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### TIM_TimeBaseInitTypeDef 结构体内部成员
```c
typedef struct
{
  uint16_t TIM_Prescaler;      //定时器预分频器  

  uint16_t TIM_CounterMode;    //计数模式

  uint16_t TIM_Period;        // 定时器周期    

  uint16_t TIM_ClockDivision;     // 时钟分频 7200

  uint8_t TIM_RepetitionCounter; // 高级定时器 重复计数器
                                    
} TIM_TimeBaseInitTypeDef;       

```
#### 定时器中断服务函数

```c
void TIMx_IRQHandler(void)   //TIMx中断
{ 
  
    if (TIM_GetITStatus(TIMx, TIM_IT_Update) != RESET)  //检查TIMx更新中断发生与否
    {
        //do somethings 
        TIM_ClearITPendingBit(TIMx, TIM_IT_Update  );  //清除TIMx更新中断标志
    }
}
```

## 软件部分
### MAIN.C

```c
//--------------------------------------------------------------------------------------------------
//  包含的头文件    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------
#include "sys.h"
#include "delay.h"
#include "UART.H"
//#include "USART.H"
#include "led.h"
#include "LCD.H"
#include "QDTFT_demo.h"
#include "Picture.h"
#include "key.h"
#include "oled.h"
#include "beep.h"
#include "timer.h"

//--------------------------------------------------------------------------------------------------
//  宏自定义声明    |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//--------------------------------------------------------------------------------------------------

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
    USART_Configure();//串口配置
    Timer_Configure();//定时器配置
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
  USART_SendString(USART1,"usart1 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,0,"usart1 test",Red,White);
  #endif
  
  #if 0
  USART_SendString(USART2,"usart2 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,16,"usart2 test",Red,White);
  #endif
  
  #if 0
  USART_SendString(USART3,"usart3 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,32,"usart3 test",Red,White);
  #endif
  
  #if 0
  USART_SendString(UART4,"uart4 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,48,"uart4 test",Red,White);
  #endif
  
  #if 0
  USART_SendString(UART5,"uart5 test \r\n");
  delay_ms(500);
  TFT_ShowString_16x16(0,54,"uart5 test",Red,White);
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
        USART_SendString(USART1,"key_value:3 \r\n");
      }
      if(key_value==2)
      {
        TFT_ShowNumber_SignedInteger_16x16(60,0,key_value,2,Red,White);
        USART_SendString(USART1,"key_value:2 \r\n");
      }
      if(key_value==1)
      {
        TFT_ShowNumber_SignedInteger_16x16(60,0,key_value,2,Red,White);
        USART_SendString(USART1,"key_value:1 \r\n");
      }
}

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

//==================================================================================================
//  实现功能: 主函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
int main(void)          
{	
    
    Hareware_Iint();
   
    TFT_ShowString_16x16(0,0,"stm32 timertest",Magenta,White);
    TFT_ShowString_16x16(0,32,"timeCount1 ",Blue1,White);
    TFT_ShowString_16x16(0,60,"timeCount2 ",Red,White);
    TFT_ShowString_16x16(0,90,"timeCount3 ",Red,White);
    TFT_ShowString_16x16(0,120,"timeCount4",Red,White);
    TFT_ShowString_16x16(0,140,"Basictime",Magenta,White);
  
    while(1)
    { 
      Basic_GeneralTimer_Test();
    }
}

```
### timer.c

```c
#include "timer.h"


//==================================================================================================
//  实现功能: 定时器1 初始化函数
//  函数说明: 高级定时器 TIM1 TIM8
//  函数备注: 定时，输出比较，输入捕捉，有三相电机互补输出信号，每个定时器有8个外部IO。
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void TIM1_Int_Init(u16 arr, u16 psc)
{
    TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;
    NVIC_InitTypeDef NVIC_InitStructure;
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_TIM1, ENABLE);

    TIM_TimeBaseStructure.TIM_Period = arr;
    TIM_TimeBaseStructure.TIM_Prescaler = psc;
    TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1;
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
    TIM_TimeBaseStructure.TIM_RepetitionCounter = 0;
    TIM_TimeBaseInit(TIM1, &TIM_TimeBaseStructure);
    TIM_ITConfig(TIM1, TIM_IT_Update, ENABLE );

    NVIC_InitStructure.NVIC_IRQChannel = TIM1_UP_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);
    TIM_Cmd(TIM1, ENABLE);
}

void TIM2_Int_Init(u16 arr, u16 psc)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
    NVIC_InitTypeDef NVIC_InitStructure;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM2, ENABLE); //时钟使能

    TIM_TimeBaseStructure.TIM_Period = arr;      //设置在下一个更新事件装入活动的自动重装载寄存器周期的值     计数到5000为500ms
    TIM_TimeBaseStructure.TIM_Prescaler =psc;    //设置用来作为TIMx时钟频率除数的预分频值  10Khz的计数频率
    TIM_TimeBaseStructure.TIM_ClockDivision = 0; //设置时钟分割:TDTS = Tck_tim
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
    TIM_TimeBaseInit(TIM2, &TIM_TimeBaseStructure); //根据TIM_TimeBaseInitStruct中指定的参数初始化TIMx的时间基数单位

    TIM_ITConfig(TIM2,TIM_IT_Update,ENABLE ); //使能指定的TIM3中断,允许更新中断

    NVIC_InitStructure.NVIC_IRQChannel = TIM2_IRQn;  //TIM3中断
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;  //先占优先级0级
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;  //从优先级3级
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ通道被使能
    NVIC_Init(&NVIC_InitStructure);  //根据NVIC_InitStruct中指定的参数初始化外设NVIC寄存器

    TIM_Cmd(TIM2, ENABLE);  //使能TIMx
}


//=================================================================================================
//  实现功能: 定时器3 初始化函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void TIM3_Int_Init(u16 arr, u16 psc)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
    NVIC_InitTypeDef NVIC_InitStructure;
//    TIM_OCInitTypeDef TIM_OCInitStructure;
    
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE); //时钟使能
    //RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO,ENABLE);

    //定时器TIM3初始化
    TIM_TimeBaseStructure.TIM_Period = arr; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值
    TIM_TimeBaseStructure.TIM_Prescaler = psc; //设置用来作为TIMx时钟频率除数的预分频值
    TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1; //设置时钟分割:TDTS = Tck_tim
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
    TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure); //根据指定的参数初始化TIMx的时间基数单位

//    //pwm 初始化
//    TIM_OCInitStructure.TIM_OCMode=TIM_OCMode_PWM1;
//    TIM_OCInitStructure.TIM_OutputState=TIM_OutputState_Enable;
//    TIM_OCInitStructure.TIM_OCPolarity=TIM_OCPolarity_Low;

//    TIM_OC3Init(TIM3,&TIM_OCInitStructure);

//    TIM_OC3PreloadConfig(TIM3,TIM_OCPreload_Enable);

    TIM_ITConfig(TIM3, TIM_IT_Update, ENABLE ); 
    
    NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;            //TIM3中断
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;  //先占优先级0级
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;         //从优先级3级
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;            //IRQ通道被使能
    NVIC_Init(&NVIC_InitStructure);      //根据NVIC_InitStruct中指定的参数初始化外设NVIC寄存器

    TIM_Cmd(TIM3, ENABLE);  

}
//==================================================================================================
//  实现功能: 定时器4 初始化函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  

void TIM4_Int_Init(u16 arr, u16 psc)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
    NVIC_InitTypeDef NVIC_InitStructure;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM4, ENABLE); //时钟使能


    //定时器TIM4初始化
    TIM_TimeBaseStructure.TIM_Period = arr; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值
    TIM_TimeBaseStructure.TIM_Prescaler = psc; //设置用来作为TIMx时钟频率除数的预分频值
    TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1; //设置时钟分割:TDTS = Tck_tim
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
    TIM_TimeBaseInit(TIM4, &TIM_TimeBaseStructure); //根据指定的参数初始化TIMx的时间基数单位

    TIM_ITConfig(TIM4, TIM_IT_Update, ENABLE ); //使能指定的TIM4中断,允许更新中断

    //中断优先级NVIC设置
    NVIC_InitStructure.NVIC_IRQChannel = TIM4_IRQn;  //TIM4中断
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;  //先占优先级0级
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;  //从优先级3级
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ通道被使能
    NVIC_Init(&NVIC_InitStructure);  //初始化NVIC寄存器

    TIM_Cmd(TIM4, ENABLE); //使能定时器4
}
//==================================================================================================
//  实现功能: 定时器5 初始化函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
void TIM5_Init(u16 arr,u16 psc)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
    NVIC_InitTypeDef NVIC_InitStructure;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM5, ENABLE); //时钟使能

    TIM_TimeBaseStructure.TIM_Period = arr; //设置在下一个更新事件装入活动的自动重装载寄存器周期的值     计数到5000为500ms
    TIM_TimeBaseStructure.TIM_Prescaler =psc; //设置用来作为TIMx时钟频率除数的预分频值  10Khz的计数频率
    TIM_TimeBaseStructure.TIM_ClockDivision = 0; //设置时钟分割:TDTS = Tck_tim
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;  //TIM向上计数模式
    TIM_TimeBaseInit(TIM5, &TIM_TimeBaseStructure); //根据TIM_TimeBaseInitStruct中指定的参数初始化TIMx的时间基数单位

    TIM_ITConfig(TIM5,TIM_IT_Update,ENABLE ); //使能指定的TIM3中断,允许更新中断

    NVIC_InitStructure.NVIC_IRQChannel = TIM5_IRQn;  //TIM3中断
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;  //先占优先级0级
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;  //从优先级3级
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE; //IRQ通道被使能
    NVIC_Init(&NVIC_InitStructure);  //根据NVIC_InitStruct中指定的参数初始化外设NVIC寄存器

    TIM_Cmd(TIM5, ENABLE);  //使能TIMx
}
//==================================================================================================
//  函数功能: TIME6,7 基本定时器
//  函数标记: 内设驱动函数
//  函数说明: 
//--------------------------------------------------------------------------------------------------
//  输入参量: 无
//  输出参量: 无
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================
// 中断优先级配置
static void BASIC_TIM_NVIC_Config(void)
{
    NVIC_InitTypeDef NVIC_InitStructure; 
    // 设置中断组为0
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_0);		
		// 设置中断来源
    NVIC_InitStructure.NVIC_IRQChannel = BASIC_TIM_IRQ ;	
		// 设置主优先级为 0
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;	 
	  // 设置抢占优先级为3
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 3;	
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);
}

/*
 * 注意：TIM_TimeBaseInitTypeDef结构体里面有5个成员，TIM6和TIM7的寄存器里面只有
 * TIM_Prescaler和TIM_Period，所以使用TIM6和TIM7的时候只需初始化这两个成员即可，
 * 另外三个成员是通用定时器和高级定时器才有.
 *-----------------------------------------------------------------------------
 *typedef struct
 *{ TIM_Prescaler            都有
 *	TIM_CounterMode			     TIMx,x[6,7]没有，其他都有
 *  TIM_Period               都有
 *  TIM_ClockDivision        TIMx,x[6,7]没有，其他都有
 *  TIM_RepetitionCounter    TIMx,x[1,8,15,16,17]才有
 *}TIM_TimeBaseInitTypeDef; 
 *-----------------------------------------------------------------------------
 */


static void BASIC_TIM_Mode_Config(void)
{
    TIM_TimeBaseInitTypeDef  TIM_TimeBaseStructure;
		
		// 开启定时器时钟,即内部时钟CK_INT=72M
    BASIC_TIM_APBxClock_FUN(BASIC_TIM_CLK, ENABLE);
	
		// 自动重装载寄存器的值，累计TIM_Period+1个频率后产生一个更新或者中断
    TIM_TimeBaseStructure.TIM_Period = BASIC_TIM_Period;	

	  // 时钟预分频数为
    TIM_TimeBaseStructure.TIM_Prescaler= BASIC_TIM_Prescaler;
	
		// 时钟分频因子 ，基本定时器没有，不用管
    //TIM_TimeBaseStructure.TIM_ClockDivision=TIM_CKD_DIV1;
		
		// 计数器计数模式，基本定时器只能向上计数，没有计数模式的设置
    //TIM_TimeBaseStructure.TIM_CounterMode=TIM_CounterMode_Up; 
		
		// 重复计数器的值，基本定时器没有，不用管
		//TIM_TimeBaseStructure.TIM_RepetitionCounter=0;
	
	  // 初始化定时器
    TIM_TimeBaseInit(BASIC_TIM, &TIM_TimeBaseStructure);
		
		// 清除计数器中断标志位
    TIM_ClearFlag(BASIC_TIM, TIM_FLAG_Update);
	  
		// 开启计数器中断
    TIM_ITConfig(BASIC_TIM,TIM_IT_Update,ENABLE);
		
		// 使能计数器
    TIM_Cmd(BASIC_TIM, ENABLE);	
}

void BASIC_TIM_Init(void)
{
	BASIC_TIM_NVIC_Config();
	BASIC_TIM_Mode_Config();
}

//==================================================================================================
//  实现功能: 定时器1 中断服务函数函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  

void TIM1_UP_IRQHandler(void)
{
    if(TIM_GetITStatus(TIM1, TIM_IT_Update) != RESET)
    {

    }
    TIM_ClearFlag(TIM1, TIM_IT_Update );
}

//==================================================================================================
//  实现功能: 定时器1 中断服务函数函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
extern unsigned int time3;
extern unsigned int timeflag3;

void TIM2_IRQHandler(void)
{

    if(TIM_GetITStatus(TIM2, TIM_IT_Update) != RESET)
    {
       TIM_ClearITPendingBit(TIM2, TIM_FLAG_Update);       
       time3++;
       timeflag3=1;
      
    }
     
}
//==================================================================================================
//  实现功能: 定时器3 中断服务函数函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//==================================================================================================  
extern unsigned int time2;
extern unsigned int timeflag2;

void TIM3_IRQHandler(void)   //TIM3中断
 {
     if (TIM_GetITStatus(TIM3, TIM_IT_Update) != RESET) //检查指定的TIM中断发生与否:TIM 中断源 
     {
         
       TIM_ClearITPendingBit(TIM3, TIM_IT_Update  );  //清除TIMx的中断待处理位:TIM 中断源 
       
       time2++;
       timeflag2=1;
         
     }
 }
//==================================================================================================
//  实现功能: 定时器4 中断服务函数函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
extern unsigned int time4;
extern unsigned int timeflag4; 
 
void TIM4_IRQHandler(void)   //TIM4中断
{
    if (TIM_GetITStatus(TIM4, TIM_IT_Update) != RESET)  //检查TIM4更新中断发生与否
    {
      TIM_ClearITPendingBit(TIM4, TIM_IT_Update  );  //清除TIM4更新中断标志
       
       time4++;
       timeflag4=1;
    }
}    

//==================================================================================================
//  实现功能: 定时器5 中断服务函数函数
//  函数说明: 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 

extern unsigned int time1;
extern unsigned int timeflag1;

void TIM5_IRQHandler(void)   //TIM3中断
{
    if (TIM_GetITStatus(TIM5, TIM_IT_Update) != RESET) //检查指定的TIM中断发生与否:TIM 中断源
    {

      TIM_ClearITPendingBit(TIM5, TIM_IT_Update  );  //清除TIMx的中断待处理位:TIM 中断源
      
       time1++;
       timeflag1=1;
    }
      
}

//==================================================================================================
//  实现功能: 定时器6,7 中断服务函数函数
//  函数说明:  基本定时器6，7 
//  函数备注: 
//--------------------------------------------------------------------------------------------------
//  |   -   |   -   |   0   |   1   |   2   |   3   |   4   |   5   |   6   |   7   |   8   |   9   
//================================================================================================== 
extern unsigned int Basictime;
void  BASIC_TIM_IRQHandler (void)
{
	if ( TIM_GetITStatus( BASIC_TIM, TIM_IT_Update) != RESET ) 
	{	
		
		TIM_ClearITPendingBit(BASIC_TIM , TIM_FLAG_Update);
    
    Basictime++;

	}		 	
}

```
### timer.h

```c
#ifndef __TIMER_H
#define __TIMER_H
#include "sys.h"

/********************基本定时器TIM参数定义，只限TIM6、7************/
#define BASIC_TIM6 // 如果使用TIM7，注释掉这个宏即可

#ifdef  BASIC_TIM6 // 使用基本定时器TIM6
#define            BASIC_TIM                   TIM6
#define            BASIC_TIM_APBxClock_FUN     RCC_APB1PeriphClockCmd
#define            BASIC_TIM_CLK               RCC_APB1Periph_TIM6
#define            BASIC_TIM_Period            (1000-1)
#define            BASIC_TIM_Prescaler         71
#define            BASIC_TIM_IRQ               TIM6_IRQn
#define            BASIC_TIM_IRQHandler        TIM6_IRQHandler

#else  // 使用基本定时器TIM7
#define            BASIC_TIM                   TIM7
#define            BASIC_TIM_APBxClock_FUN     RCC_APB1PeriphClockCmd
#define            BASIC_TIM_CLK               RCC_APB1Periph_TIM7
#define            BASIC_TIM_Period            1000-1
#define            BASIC_TIM_Prescaler         71
#define            BASIC_TIM_IRQ               TIM7_IRQn
#define            BASIC_TIM_IRQHandler        TIM7_IRQHandler

#endif

void TIM1_Int_Init(u16 arr,u16 psc);

void TIM2_Int_Init(u16 arr,u16 psc);
void TIM3_Int_Init(u16 arr,u16 psc);
void TIM4_Int_Init(u16 arr,u16 psc);
void TIM5_Init(u16 arr,u16 psc);
static void BASIC_TIM_Mode_Config(void);
void BASIC_TIM_Init(void);

#endif

```
### 简单效果图片

![定时器1s效果图片](https://img-blog.csdnimg.cn/20201109234248875.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

