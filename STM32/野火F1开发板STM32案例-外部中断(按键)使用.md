---
categories:  #分类
    - C
    - 嵌入式 STM32
    - 中断
tags:   #标签
    - C
    - 软件开发
    - 嵌入式STM32 
    - 野火F1开发
    - 中断
---
# 野火F1开发板STM32案例-外部中断(按键)使用
## 硬件平台
1. 野火STM32F103ZET6 霸道V2开发板
2. 正点原子F1系列开发板
![STM32产品](https://img-blog.csdnimg.cn/20201002210908329.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 软件平台
1. Keil MDK 5.31
2. 串口调试助手

工程下载<https://download.csdn.net/download/weixin_43599390/12910397>

## 中断相关概念
```c
中断配置寄存器
# 配置中断时，使用ISER、 ICER 和 IP 寄存器，
## ISER 是中断使能寄存器
## ICER 是中断清除寄存器
## IP 是中断优先级寄存器

中断优先级
1. 数值越小，优先级越高
2. STM32F103 中只使用4位，高4位有效。
3. 用于表达优先级的高 4 位又被分组成抢占式优先级和响应优先级，称为“亚优先级”或“副优先级”
4. 每个中断源都需要被指定这两种优先级。

中断配置步骤
1.使能外设中断
6. 设置中断优先级分组
初始化 NVIC_InitTypeDef 结构体，设置抢占优先级和响应优先级，使能中断请求。
typedef struct
{
     uint8_t NVIC_IRQChannel; //中断源
     uint8_t NVIC_IRQChannelPreemptionPriority; //抢占优先级
     uint8_t NVIC_IRQChannelSubPriority; //响应优先级
     FunctionalState NVIC_IRQChannelCmd; //中断使能或失能
 } NVIC_InitTypeDef;


NVIC_IRQChannel 中断源:中断源的设置，不同的外设中断，中断源不一样
NVIC_IRQChannelPreemptionPriority  //抢占优先级

NVIC_IRQChannelSubPriority  //响应优先级
NVIC_IRQChannelCmd //中断使能或失能:使能配置为 ENABLE，失能配置为 DISABLE。
```
```c
NVIC_IRQChannel   //中断源
/******  Cortex-M3 Processor Exceptions Numbers ***************************************************/
  NonMaskableInt_IRQn         = -14,    /*!< 2 Non Maskable Interrupt                             */
  MemoryManagement_IRQn       = -12,    /*!< 4 Cortex-M3 Memory Management Interrupt              */
  BusFault_IRQn               = -11,    /*!< 5 Cortex-M3 Bus Fault Interrupt                      */
  UsageFault_IRQn             = -10,    /*!< 6 Cortex-M3 Usage Fault Interrupt                    */
  SVCall_IRQn                 = -5,     /*!< 11 Cortex-M3 SV Call Interrupt                       */
  DebugMonitor_IRQn           = -4,     /*!< 12 Cortex-M3 Debug Monitor Interrupt                 */
  PendSV_IRQn                 = -2,     /*!< 14 Cortex-M3 Pend SV Interrupt                       */
  SysTick_IRQn                = -1,     /*!< 15 Cortex-M3 System Tick Interrupt                   */

/******  STM32 specific Interrupt Numbers *********************************************************/
  WWDG_IRQn                   = 0,      /*!< Window WatchDog Interrupt                            */
  PVD_IRQn                    = 1,      /*!< PVD through EXTI Line detection Interrupt            */
  TAMPER_IRQn                 = 2,      /*!< Tamper Interrupt                                     */
  RTC_IRQn                    = 3,      /*!< RTC global Interrupt                                 */
  FLASH_IRQn                  = 4,      /*!< FLASH global Interrupt                               */
  RCC_IRQn                    = 5,      /*!< RCC global Interrupt                                 */
  EXTI0_IRQn                  = 6,      /*!< EXTI Line0 Interrupt                                 */
  EXTI1_IRQn                  = 7,      /*!< EXTI Line1 Interrupt                                 */
  EXTI2_IRQn                  = 8,      /*!< EXTI Line2 Interrupt                                 */
  EXTI3_IRQn                  = 9,      /*!< EXTI Line3 Interrupt                                 */
  EXTI4_IRQn                  = 10,     /*!< EXTI Line4 Interrupt                                 */
  DMA1_Channel1_IRQn          = 11,     /*!< DMA1 Channel 1 global Interrupt                      */
  DMA1_Channel2_IRQn          = 12,     /*!< DMA1 Channel 2 global Interrupt                      */
  DMA1_Channel3_IRQn          = 13,     /*!< DMA1 Channel 3 global Interrupt                      */
  DMA1_Channel4_IRQn          = 14,     /*!< DMA1 Channel 4 global Interrupt                      */
  DMA1_Channel5_IRQn          = 15,     /*!< DMA1 Channel 5 global Interrupt                      */
  DMA1_Channel6_IRQn          = 16,     /*!< DMA1 Channel 6 global Interrupt                      */
  DMA1_Channel7_IRQn          = 17,     /*!< DMA1 Channel 7 global Interrupt                      */

```
### STM32F103  中断向量表
![ 中断向量表1](https://img-blog.csdnimg.cn/2020100315141155.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![ 中断向量表2](https://img-blog.csdnimg.cn/20201003151410982.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
###  EXTI外部中断
```c
1. STM32F10x 外部中断/事件控制器（EXTI）包含多达 20 个用于产生事件/中断请求的边沿检测器。
2. EXTI 的每根输入线都可单独进行配置，以选择类型（中断或事件）和相应的触发事件（上升沿触发、下降沿触发或边沿触发）
还可独立地被屏蔽。
3. EXIT功能:产生中断;产生事件.
```
### STM32 EXIT框架图
![STM32 EXIT框架图](https://img-blog.csdnimg.cn/20201003151626597.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## EXTI外部中断步骤
1. 使能I0口时钟，配置I0口模式为输入
2. 开启AFIO时钟，设置I0口与中断线的映射关系
3. 配置中断分组（NVIC），使能中断
4. 初始化EXTI，选择触发方式
5. 编写EXTI中断服务函数
#### GPIO引脚配置（本文中和外部中断bsp_exit.h一起进行初始化，可以分开进行配置相关函数）
(一般配置过程类似，无论使用什么外设，UART,IIC,SPI,ADC 一般情况都要GPIO初始化)
```c
//定义GPIO初始化结构体
//使能 GPIO时钟 (时钟分频)
//设置相关外部设备的对应引脚
//设置GPIO端口模式(GPIO输入 GPIO输出)
//设置生效(GPIO端口启动生效)
# GPIO输入模式
void initKey(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;                  //定义GPIO初始化结构体
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); //使能 GPIO时钟 (时钟分频)
    GPIO_InitStructure.GPIO_Pin = KEY_UP_PIN|KEY_DOWN_PIN;//设置相关外部设备的对应引脚
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;         //设置上拉输入 //设置GPIO端口模式
	GPIO_Init(GPIOA, &GPIO_InitStructure);			      //设置生效(GPIO端口启动生效)
    
}

# GPIO输出模式
void initLED(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;                  //定义GPIO初始化结构体
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE); //使能GPIO时钟
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5;		      //设置对应引脚
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;      //设置推挽输出
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;     //工作速度50MHz
	GPIO_Init(GPIOB, &GPIO_InitStructure);                //设置生效
	GPIO_ResetBits(GPIOB, GPIO_Pin_5);				      //默认低电平，LED不
}
```

#### 配置嵌套向量中断控制器NVIC步骤
1. 定义NVIC结构体        NVIC_InitTypeDef 结构体
```c
typedef struct
{
	uint8_t NVIC_IRQChannel; //中断源
	uint8_t NVIC_IRQChannelPreemptionPriority; //抢占优先级
	uint8_t NVIC_IRQChannelSubPriority; //响应优先级
	FunctionalState NVIC_IRQChannelCmd; //中断使能或失能
} NVIC_InitTypeDef;
```
2. 配置NVIC为优先级组
![优先级组](https://img-blog.csdnimg.cn/20201003160403277.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
```c
NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1); 
```
3. 配置中断源
```c
NVIC_InitStructure.NVIC_IRQChannel = KEY1_INT_EXTI_IRQ;
// #define KEY1_INT_EXTI_PORTSOURCE   GPIO_PortSourceGPIOA
// #define KEY1_INT_EXTI_PINSOURCE    GPIO_PinSource0
// #define KEY1_INT_EXTI_LINE         EXTI_Line0
// #define KEY1_INT_EXTI_IRQ          EXTI0_IRQn
```
4. 配置抢占优先级
```c
 NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
```
5. 配置子优先级 
```c
NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
```
6. 使能中断通道
```c
NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
```
7. 初始化NVIC
```c
NVIC_Init(&NVIC_InitStructure);
```
#### 配置 EXTI中断口，并设置中断优先级步骤流程

```c

1. 定义GPIO_InitTypeDef EXTI_InitTypeDef 结构体
GPIO_InitTypeDef GPIO_InitStructure; 
EXTI_InitTypeDef EXTI_InitStructure;

typedef struct
{
  uint16_t GPIO_Pin;             /*!< Specifies the GPIO pins to be configured.
                                      This parameter can be any value of @ref GPIO_pins_define */

  GPIOSpeed_TypeDef GPIO_Speed;  /*!< Specifies the speed for the selected pins.
                                      This parameter can be a value of @ref GPIOSpeed_TypeDef */

  GPIOMode_TypeDef GPIO_Mode;    /*!< Specifies the operating mode for the selected pins.
                                      This parameter can be a value of @ref GPIOMode_TypeDef */
}GPIO_InitTypeDef;

typedef struct
{
  uint32_t EXTI_Line;               /*!< Specifies the EXTI lines to be enabled or disabled.
                                         This parameter can be any combination of @ref EXTI_Lines */
   
  EXTIMode_TypeDef EXTI_Mode;       /*!< Specifies the mode for the EXTI lines.
                                         This parameter can be a value of @ref EXTIMode_TypeDef */

  EXTITrigger_TypeDef EXTI_Trigger; /*!< Specifies the trigger signal active edge for the EXTI lines.
                                         This parameter can be a value of @ref EXTIMode_TypeDef */

  FunctionalState EXTI_LineCmd;     /*!< Specifies the new state of the selected EXTI lines.
                                         This parameter can be set either to ENABLE or DISABLE */ 
}EXTI_InitTypeDef;

```
![GPIO结构体](https://img-blog.csdnimg.cn/20201003162222876.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![中断事件结构体](https://img-blog.csdnimg.cn/20201003162222867.png#pic_center)

```c
/*开启按键GPIO口的时钟*/
RCC_APB2PeriphClockCmd(KEY1_INT_GPIO_CLK,ENABLE);
/* 配置 NVIC 中断*/
NVIC_Configuration();
```
##### GPIO引脚配置
```c
/*--------------------------KEY1配置-------------------------*/
/* 选择按键用到的GPIO */	
  GPIO_InitStructure.GPIO_Pin = KEY1_INT_GPIO_PIN;
  /* 配置为浮空输入 */	
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_Init(KEY1_INT_GPIO_PORT, &GPIO_InitStructure);
/*------------------------KEY2配置-----------------------------*/
  /* 选择按键用到的GPIO */	
  GPIO_InitStructure.GPIO_Pin = KEY2_INT_GPIO_PIN;
  /* 配置为浮空输入 */	
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_Init(KEY2_INT_GPIO_PORT, &GPIO_InitStructure);
```
##### 中断配置
1. 中断信号源 
2. EXIT模式
3. 外部中断触发类型
4. 使能中断EXIT
5. 中断初始化
```c
/* 选择EXTI的信号源 */
  GPIO_EXTILineConfig(KEY1_INT_EXTI_PORTSOURCE, KEY1_INT_EXTI_PINSOURCE); 
  EXTI_InitStructure.EXTI_Line = KEY1_INT_EXTI_LINE;
	/* EXTI为中断模式 */
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
	/* 上升沿中断 */
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
  /* 使能中断 */	
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
```

### BSP_EXIT.H
```c
//引脚定义
#define KEY1_INT_GPIO_PORT         GPIOA
#define KEY1_INT_GPIO_CLK          (RCC_APB2Periph_GPIOA|RCC_APB2Periph_AFIO)
#define KEY1_INT_GPIO_PIN          GPIO_Pin_0
#define KEY1_INT_EXTI_PORTSOURCE   GPIO_PortSourceGPIOA
#define KEY1_INT_EXTI_PINSOURCE    GPIO_PinSource0
#define KEY1_INT_EXTI_LINE         EXTI_Line0
#define KEY1_INT_EXTI_IRQ          EXTI0_IRQn

#define KEY1_IRQHandler            EXTI0_IRQHandler


#define KEY2_INT_GPIO_PORT         GPIOC
#define KEY2_INT_GPIO_CLK          (RCC_APB2Periph_GPIOC|RCC_APB2Periph_AFIO)
#define KEY2_INT_GPIO_PIN          GPIO_Pin_13
#define KEY2_INT_EXTI_PORTSOURCE   GPIO_PortSourceGPIOC
#define KEY2_INT_EXTI_PINSOURCE    GPIO_PinSource13
#define KEY2_INT_EXTI_LINE         EXTI_Line13
#define KEY2_INT_EXTI_IRQ          EXTI15_10_IRQn

#define KEY2_IRQHandler            EXTI15_10_IRQHandler

```
### BSP_EXIT.C
#### 配置嵌套向量中断控制器NVIC
```c
#include “bsp_exit.h”
/**
  * @brief  配置嵌套向量中断控制器NVIC
  * @param  无
  * @retval 无
  */
static void NVIC_Configuration(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  /* 配置NVIC为优先级组1 */
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
  
  /* 配置中断源：按键1 */
  NVIC_InitStructure.NVIC_IRQChannel = KEY1_INT_EXTI_IRQ;
  /* 配置抢占优先级 */
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  /* 配置子优先级 */
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  /* 使能中断通道 */
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
  /* 配置中断源：按键2，其他使用上面相关配置 */  
  NVIC_InitStructure.NVIC_IRQChannel = KEY2_INT_EXTI_IRQ;
  NVIC_Init(&NVIC_InitStructure);
}
```
#### 配置 IO为EXTI中断口，并设置中断优先级

```c
void EXTI_Key_Config(void)
{
	GPIO_InitTypeDef GPIO_InitStructure; 
	EXTI_InitTypeDef EXTI_InitStructure;

	/*开启按键GPIO口的时钟*/
	RCC_APB2PeriphClockCmd(KEY1_INT_GPIO_CLK,ENABLE);
												
	/* 配置 NVIC 中断*/
	NVIC_Configuration();
	
/*--------------------------KEY1配置-----------------------------*/
	/* 选择按键用到的GPIO */	
  GPIO_InitStructure.GPIO_Pin = KEY1_INT_GPIO_PIN;
  /* 配置为浮空输入 */	
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_Init(KEY1_INT_GPIO_PORT, &GPIO_InitStructure);

	/* 选择EXTI的信号源 */
  GPIO_EXTILineConfig(KEY1_INT_EXTI_PORTSOURCE, KEY1_INT_EXTI_PINSOURCE); 
  EXTI_InitStructure.EXTI_Line = KEY1_INT_EXTI_LINE;
	
	/* EXTI为中断模式 */
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
	/* 上升沿中断 */
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
  /* 使能中断 */	
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
	
  /*--------------------------KEY2配置-----------------------------*/
	/* 选择按键用到的GPIO */	
  GPIO_InitStructure.GPIO_Pin = KEY2_INT_GPIO_PIN;
  /* 配置为浮空输入 */	
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_Init(KEY2_INT_GPIO_PORT, &GPIO_InitStructure);

	/* 选择EXTI的信号源 */
  GPIO_EXTILineConfig(KEY2_INT_EXTI_PORTSOURCE, KEY2_INT_EXTI_PINSOURCE); 
  EXTI_InitStructure.EXTI_Line = KEY2_INT_EXTI_LINE;
	
	/* EXTI为中断模式 */
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
	/* 下降沿中断 */
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;
  /* 使能中断 */	
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
}
```
### 中断服务函数

```c
#include "stm32f10x_it.h"
#include "bsp_test.h"
/**
******************************************************************************
  * @file    stm32 用户自定义外部中断
  * @author  dele
  * @version V1.0
  * @date    2020-10-03
  * @brief   按键测试（中断模式/EXTI模式）
  * 实验平台:野火 F103-霸道 STM32 开发板 
  ******************************************************************************
  */ 
void KEY1_IRQHandler(void)
{
  //确保是否产生了EXTI Line中断
	if(EXTI_GetITStatus(KEY1_INT_EXTI_LINE) != RESET) 
	{
		// LED1 取反		
		LED1_TOGGLE;
	    BSP_KEY1_EXIT_LCDTEST(); 
	    USART_SendString(USART1,"KEY1 EXIT www.delehub.top");
	    USART_SendLine(USART1);
    //清除中断标志位
		EXTI_ClearITPendingBit(KEY1_INT_EXTI_LINE);  
     
	}  
}

void KEY2_IRQHandler(void)
{
  //确保是否产生了EXTI Line中断
	if(EXTI_GetITStatus(KEY2_INT_EXTI_LINE) != RESET) 
	{
		// LED2 取反		
		LED2_TOGGLE
	    BSP_KEY2_EXIT_LCDTEST(); 
	    USART_SendString(USART1,"KEY2 EXIT 2020-10-03 14:50");  
	    USART_SendLine(USART1);
    //清除中断标志位
		EXTI_ClearITPendingBit(KEY2_INT_EXTI_LINE);
      
	}  
}
```

#### 按键外部中断测试函数

```c
void BSP_KEY1_EXIT_LCDTEST(void)
{
  LCD_SetFont(&Font8x16);
	LCD_SetColors(RED,WHITE);
  ILI9341_Clear(0,0,LCD_X_LENGTH,LCD_Y_LENGTH);	/* 清屏，显示全黑 */
  ILI9341_DispStringLine_EN(LINE(0),"2020-10-03 14:30 BSP_EXIT_TEST");
  ILI9341_DispStringLine_EN(LINE(1),"KEY1 EXIT TEST");
  LCD_SetTextColor(RED);
  ILI9341_DrawCircle(100,200,20,1);
}

void BSP_KEY2_EXIT_LCDTEST(void)
{
  LCD_SetFont(&Font8x16);
	LCD_SetColors(RED,WHITE);
  ILI9341_Clear(0,0,LCD_X_LENGTH,LCD_Y_LENGTH);	/* 清屏，显示全黑 */
  ILI9341_DispStringLine_EN(LINE(3),"2020-10-03 14:30 DELEHUB");
  ILI9341_DispStringLine_EN(LINE(4),"KEY2 EXIT TEST");
  LCD_SetTextColor(GREEN);
  ILI9341_DrawCircle(100,200,40,0);
}
```

#### MAIN.C
```c
/****************************************************************
  * @file    main.c
  * 实验平台:野火 F103-霸道 STM32 开发板  ***************************************************************** 第三方库文件导入  START THE FILE
 ***************************************************************/ 
#include "stm32f10x.h"
#include "bsp_led.h"  
#include "bsp_key.h" 
#include "bsp_beep.h"
#include "bsp_exit.h"
#include "timer.h"
#include "bsp_ili9341_lcd.h"
#include "bsp_SysTick.h"
#include "bsp_usart.h"
#include <stdio.h>
#include "bsp_test.h"
#include "STM32F103xxxx_USART.H"  
/******************************************************************************
END THE FILE
  * 第三方库文件导入*********************************************************/ 
void HardWare_Iint(void)
{
  
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);
  EXTI_Key_Config();
  LED_Iint();
  Key_Iint();
  Beep_Init();
  //TIM4_Int_Init(9999,7199);
  ILI9341_Init();
  USART_Configure();
  
}
/**
  * @brief  主函数
  * @param  无
  * @retval 无
  */ 
int main(void)
{	
	/* 硬件端口初始化 */
	HardWare_Iint();
	while(1)
	{
	}
}
```
### 串口打印效果
![串口打印效果](https://img-blog.csdnimg.cn/20201003153440133.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

### TFT显示效果
![TFT显示效果key2](https://img-blog.csdnimg.cn/20201003153501455.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![TFT显示效果key2](https://img-blog.csdnimg.cn/20201003153501430.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 博客地址<https://delehub.vercel.app/>
