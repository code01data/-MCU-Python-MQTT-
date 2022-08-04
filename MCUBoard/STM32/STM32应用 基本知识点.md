---
categories:  #分类
    - STM32 ARM单片机
    - C
    - 电子模块
    - 嵌入式
tags:   #标签
    - STM32 ARM单片机
    - 嵌入式
    - C
---
# STM32--基本知识点
<!-- more -->
## GPIO端口模式
（1）GPIO_Mode_AIN 模拟输入
（2）GPIO_Mode_IN_FLOATING 浮空输入
（3）GPIO_Mode_IPD 下拉输入
（4）GPIO_Mode_IPU 上拉输入
（5）GPIO_Mode_Out_OD 开漏输出
（6）GPIO_Mode_Out_PP 推挽输出
（7）GPIO_Mode_AF_OD 复用开漏输出
（8）GPIO_Mode_AF_PP 复用推挽输出
## STM32F10C8T6 引脚分布功能图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329154507476.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329154420177.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329154429334.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329154437766.jpg#pic_center)
## STM32F10C8T6 串口分布

```
串口 1
PA9  /USART1 _TX/TIM1_ _CH2 
PA10 /USART1_ RX/TIM1_ _CH3 ;

串口 2
PA2  /USART2_ TX/ ADC_ IN2/TIM2_ CH3
PA3  /USART2_ RX/ADC_ IN3/TIM2_ _CH4

串口 3 

21 PB10 /12C2 SCL 1 USART3_ TX
22 PB11 / 12C2_ SDA /USART3 _RX
```
## 学习案例
### STM32固件库使用(GPIO端口控制LED)
#### led.c
```c
#include"led.h"

void LED_GPIO_Config(void)
{
		GPIO_InitTypeDef GPIO_InitStructure;             //定义结构体指针变量	
	    RCC_APB2PeriphClockCmd(LED1_GPIO_CLK,ENABLE);  
     //配置时钟RCC_APB2PeriphClock寄存器
    /*配置GPIO端口的模式
		{
			1.选择要控制的GPIO引脚
			2.设置引脚模式(通用推挽输出)
			3.设置引脚速率
		}*/
        GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_Out_PP;   
		GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	
	  GPIO_InitStructure.GPIO_Pin   = LED1_GPIO_PIN;	//red
	  GPIO_Init(LED1_GPIO_PORT, &GPIO_InitStructure);	//调用GPIO库函数，初始化GPIO端口
	  
	  GPIO_InitStructure.GPIO_Pin   = LED2_GPIO_PIN;	//blue
	  GPIO_Init(LED2_GPIO_PORT, &GPIO_InitStructure);	//调用GPIO库函数，初始化GPIO端口
	  
	  GPIO_InitStructure.GPIO_Pin   = LED3_GPIO_PIN;	//green
	  GPIO_Init(LED3_GPIO_PORT, &GPIO_InitStructure);	//调用GPIO库函数，初始化GPIO端口
```
#### led.h
```c
#ifndef __LED_H
#define __LED_H

#include"stm32f10x.h"
/*
注意：该引脚定义是根据野火STM32F103霸道开发板的原理图定义的，如果需要自行的设计需要重新更改宏定义选择不同的GPIO端口
STM32F103ZET6芯片共有144个引脚
其中：GPIOA,GPIOB,GPIOC,GPIOD,GPIOE
*/

/*red*/

#define LED1_GPIO_PORT    	GPIOB			              /* GPIO端口 */
#define LED1_GPIO_CLK 	    RCC_APB2Periph_GPIOB		/* GPIO端口时钟 */
#define LED1_GPIO_PIN		    GPIO_Pin_5			        /* 连接到SCL时钟线的GPIO */

/*blue*/

#define LED2_GPIO_PORT    	GPIOB			              /* GPIO端口 */
#define LED2_GPIO_CLK 	    RCC_APB2Periph_GPIOB		/* GPIO端口时钟 */
#define LED2_GPIO_PIN		    GPIO_Pin_1			        /* 连接到SCL时钟线的GPIO */

/*green*/

#define LED3_GPIO_PORT    	GPIOB			              /* GPIO端口 */
#define LED3_GPIO_CLK 	    RCC_APB2Periph_GPIOB		/* GPIO端口时钟 */
#define LED3_GPIO_PIN		    GPIO_Pin_0			        /* 连接到SCL时钟线的GPIO */


#define ON  0
#define OFF 1

/* 使用标准的固件库控制IO*/
#define LED1(a)	if (a)	\
					GPIO_SetBits(LED1_GPIO_PORT,LED1_GPIO_PIN);\
					else		\
					GPIO_ResetBits(LED1_GPIO_PORT,LED1_GPIO_PIN)

#define LED2(a)	if (a)	\
					GPIO_SetBits(LED2_GPIO_PORT,LED2_GPIO_PIN);\
					else		\
					GPIO_ResetBits(LED2_GPIO_PORT,LED2_GPIO_PIN)

#define LED3(a)	if (a)	\
					GPIO_SetBits(LED3_GPIO_PORT,LED3_GPIO_PIN);\
					else		\
					GPIO_ResetBits(LED3_GPIO_PORT,LED3_GPIO_PIN)


/* 直接操作寄存器的方法控制IO */
#define	digitalHi(p,i)		 {p->BSRR=i;}	 //输出为高电平		
#define digitalLo(p,i)		 {p->BRR=i;}	 //输出低电平
#define digitalToggle(p,i) {p->ODR ^=i;} //输出反转状态


/* 定义控制IO的宏 */
#define LED1_TOGGLE		 digitalToggle(LED1_GPIO_PORT,LED1_GPIO_PIN)
#define LED1_OFF		   digitalHi(LED1_GPIO_PORT,LED1_GPIO_PIN)
#define LED1_ON			   digitalLo(LED1_GPIO_PORT,LED1_GPIO_PIN)

#define LED2_TOGGLE		 digitalToggle(LED2_GPIO_PORT,LED2_GPIO_PIN)
#define LED2_OFF		   digitalHi(LED2_GPIO_PORT,LED2_GPIO_PIN)
#define LED2_ON			   digitalLo(LED2_GPIO_PORT,LED2_GPIO_PIN)

#define LED3_TOGGLE		 digitalToggle(LED3_GPIO_PORT,LED3_GPIO_PIN)
#define LED3_OFF		   digitalHi(LED3_GPIO_PORT,LED3_GPIO_PIN)
#define LED3_ON			   digitalLo(LED3_GPIO_PORT,LED3_GPIO_PIN)

/* 基本混色，后面高级用法使用PWM可混出全彩颜色,且效果更好 */

//红
#define LED_RED  \
					LED1_ON;\
					LED2_OFF\
					LED3_OFF

//绿
#define LED_GREEN		\
					LED1_OFF;\
					LED2_ON\
					LED3_OFF

//蓝
#define LED_BLUE	\
					LED1_OFF;\
					LED2_OFF\
					LED3_ON

					
//黄(红+绿)					
#define LED_YELLOW	\
					LED1_ON;\
					LED2_ON\
					LED3_OFF
//紫(红+蓝)
#define LED_PURPLE	\
					LED1_ON;\
					LED2_OFF\
					LED3_ON

//青(绿+蓝)
#define LED_CYAN \
					LED1_OFF;\
					LED2_ON\
					LED3_ON
					
//白(红+绿+蓝)
#define LED_WHITE	\
					LED1_ON;\
					LED2_ON\
					LED3_ON
					
//黑(全部关闭)
#define LED_RGBOFF	\
					LED1_OFF;\
					LED2_OFF\
					LED3_OFF

void LED_GPIO_Config(void);

#endif

```
#### main.c
```c
#include "stm32f10x.h"   
#include "led.h"

int main(void)
{
	// 来到这里的时候，系统的时钟已经被配置成72M。
		LED_GPIO_Config();
		while(1)
		{
			    //red
			     GPIO_ResetBits(LED1_GPIO_PORT , LED1_GPIO_PIN);//开
			     DELAY_nMS(2000);
			 GPIO_SetBits(LED1_GPIO_PORT , LED1_GPIO_PIN);//关
			 DELAY_nMS(2000);
			 // blue
			 GPIO_ResetBits(LED2_GPIO_PORT , LED2_GPIO_PIN);//开
			 DELAY_nMS(1000);
			 GPIO_SetBits(LED2_GPIO_PORT , LED2_GPIO_PIN);//关
			 DELAY_nMS(1000);
			 //green 
			 GPIO_ResetBits(LED3_GPIO_PORT , LED3_GPIO_PIN);//开
			 DELAY_nMS(3000);
			 GPIO_SetBits(LED3_GPIO_PORT , LED3_GPIO_PIN);//关
			 DELAY_nMS(3000);	
		}	
}
```
#### 软件延迟函数
##### delay.c
```c

#include"DELAY.H"                           

void DELAY_nUS(unsigned int Time)
{
	while(--Time);
}
void DELAY_nMS(unsigned int time)
{
  unsigned int  i,j;             
  for(i=0;i<time;i++)    
     for(j=0;j<939;j++); 
}



```
##### dely.h
```c

#ifndef __DELAY_H
#define __DELAY_H

#include "stm32f10x.h"

void DELAY_nUS(unsigned int Time);
void DELAY_nMS(unsigned int time);

#endif
```
### STM32 GPIO端口 寄存器点灯

```c
#include"stm32f10x.h"//STM32库文件

/***************************************************
  * @file    main.c
  * @author  dele
  * @version V1.0
  * @date    2020-01-28
  * @brief   测试LED
*****************************************************/
/*****************************************************
    操作LED时寄存器的步骤
	{
	  1.打开 GPIO 端口的时钟
	  2.配置IO口  (输出/输入)
      3.控制ODR寄存器的高低电平状态
	}
*****************************************************/
/*函数声明*/
int main(void);
void DELAY_nMS(unsigned int time);
void SystemInit(void);


/*****************************************************
函数名称：main()
函数功能：主函数
*****************************************************/
int main(void)
{	
	while(1)
	{
		// 打开 GPIOB 端口的时钟
		*( unsigned int * )0x40021018 |=  ( (1) << 3 );	
		// 配置IO口为输出
		*( unsigned int * )0x40010C00 |=  ( (1) << (4*0) );
		// 控制 ODR 寄存器
		*( unsigned int * )0x40010C0C &= ~(1<<0);//输出低电平	
		 DELAY_nMS(1000);		
		// 打开 GPIOB 端口的时钟
		*( unsigned int * )0x40021018 |=  ( (1) << 3 );	
		// 配置IO口为输出
		*( unsigned int * )0x40010C00 |=  ( (1) << (4*0) );	
		*( unsigned int * )0x40010C0C |= (1<<0); //输出高电平	
		DELAY_nMS(2000);
	}
}



/**********************************************************************
函数名称：DELAY_nMS()
函数功能：延迟函数(延迟1ms)
***********************************************************************/
void DELAY_nMS(unsigned int time)
{
  unsigned int  i,j;             
  for(i=0;i<time;i++)    
     for(j=0;j<939;j++); 
}

/**********************************************************************
函数名称：SystemInit()
函数功能：系统初始化(从汇编代码进入C程序)
***********************************************************************/
void SystemInit(void)
{
	//骗过编译器
}


```

注：使用开发板是野火F103ZET6霸道开发板（代码是火哥的例程资料代码）

#### 参考资料
1.野火STM32视频学习<https://space.bilibili.com/356820657/>
2.野火STM32论坛<http://www.firebbs.cn/forum.php>
3.野火STM32开源资料<http://products.embedfire.com/zh_CN/latest/>

