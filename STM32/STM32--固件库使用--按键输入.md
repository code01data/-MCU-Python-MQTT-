---
categories:  #分类
    - STM32 ARM单片机
    - C
    - 电子模块
    - 嵌入式
tags:   #标签
    - STM32 ARM单片机
    - 键盘
    - 嵌入式
    - C
---
# STM32--固件库使用--按键输入
<!-- more -->
## 简介
1.硬件
STM32F103C8T6 独立按键
2.软件
keil软件

## 硬件部分
1.按键分类与输入原理

按键按照结构原理科分为两类，一类是触点式开关按键，如机械式开关、导电橡胶式开关灯；另一类是无触点式开关按键，如电气式按键，磁感应按键等。前者造价低，后者寿命长。目前，微机系统中最常见的是触点式开关按键。

在单片机应用系统中，除了复位按键有专门的复位电路及专一的复位功能外，其他按键都是以开关状态来设置控制功能或输入数据的。当所设置的功能键或数字键按下时，计算机应用系统应完成该按键所设定的功能，键信息输入时与软件结构密切相关的过程。

对于一组键或一个键盘，总有一个接口电路与CPU相连。CPU可以采用查询或中断方式了解有无将按键输入，并检查是哪一个按键按下，将该键号送人累加器，然后通过跳转指令转入执行该键的功能程序，执行完成后再返回主程序。

2.按键结构与特点

微机键盘通常使用机械触点式按键开关，其主要功能式把机械上的通断转换为电气上的逻辑关系。也就是说，它能提供标准的TTL逻辑电平，以便于通用数字系统的逻辑电平相容。机械式按键再按下或释放时，由于机械弹性作用的影响，通常伴随有一定的时间触点机械抖动，然后其触点才稳定下来。其抖动过程如下图1所示，抖动时间的长短与开关的机械特性有关，一般为5-10ms。在触点抖动期间检测按键的通与断，可能导致判断出错，即按键一次按下或释放错误的被认为是多次操作，这种情况是不允许出现的。为了克服你、按键触点机械抖动所致的检测误判，必须采取消抖措施。按键较少时，可采用硬件消抖；按键较多式，采用软件消抖。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329162917702.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
按键编码

一组按键或键盘都要通过I/O口线查询按键的开关状态。根据键盘结构的不同，采用不同的编码。无论有无编码，以及采用什么编码，最后都要转换成为与累加器中数值相对应的键值，以实现按键功能程序的跳转。


（2）键盘程序

一个完整的键盘控制程序应具备以下功能：

a.检测有无按键按下，并采取硬件或软件措施消抖。

b.有可靠的逻辑处理办法。每次只处理一个按键，期间对任何按键的操作对系统不产生影响，且无论一次按键 时间有多长，系统仅执行一次按键功能程序。

c.准确输出按键值（或键号），以满足跳转指令要求。

3.独立按键

（1）独立按键

单片机控制系统中，如果只需要几个功能键，此时，可采用独立式按键结构。

独立按键式直接用I/O口线构成的单个按键电路，其特点式每个按键单独占用一根I/O口线，每个按键的工作不会影响其他I/O口线的状态。独立按键的典型应用如图所示。独立式按键电路配置灵活，软件结构简单，但每个按键必须占用一个I/O口线，因此，在按键较多时，I/O口线浪费较大，不宜采用。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329162937333.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

独立按键的软件常采用查询式结构。先逐位查询没跟I/O口线的输入状态，如某一根I/O口线输入为低电平，则可确认该I/O口线所对应的按键已按下，然后，再转向该键的功能处理程序。
## 软件部分
#### key.c
```c

#include"key.h"
void KEY_GPIO_Config(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;         //定义结构体指针变量
	RCC_APB2PeriphClockCmd(KEY1_GPIO_CLK|KEY2_GPIO_CLK,ENABLE);  
 //开启按键端口的时钟
	/*按键输入控制GPIO端口的步骤*/
	/*
	  {
   1.选择按键的引脚
   2.设置按键的引脚为浮空输入
   3.使用结构体初始化按键
   }
	*/
  //key1
	GPIO_InitStructure.GPIO_Pin = KEY1_GPIO_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_Init(KEY1_GPIO_PORT, &GPIO_InitStructure);
	//key2
	GPIO_InitStructure.GPIO_Pin = KEY2_GPIO_PIN; 
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
	GPIO_Init(KEY2_GPIO_PORT, &GPIO_InitStructure);	
	
}
 /*
 * 函数名：Key_Scan
 * 描述  ：检测是否有按键按下
 * 输入  ：GPIOx：x 可以是 A，B，C，D或者 E
 *		     GPIO_Pin：待读取的端口位 	
 * 输出  ：KEY_OFF(没按下按键)、KEY_ON（按下按键）
 */
uint8_t Key_Scan(GPIO_TypeDef* GPIOx,uint16_t GPIO_Pin)
{	/*检测是否有按键按下 */
	if(GPIO_ReadInputDataBit(GPIOx,GPIO_Pin) == KEY_ON )  
	{	 /*等待按键释放 *///松手检测
		while(GPIO_ReadInputDataBit(GPIOx,GPIO_Pin) == KEY_ON);   	
		return 	KEY_ON;	 
	}
	else
		return KEY_OFF;
}

```
#### key.h
```c

#ifndef __KEY_H
#define __KEY_H

#include "stm32f10x.h"
/*
注意：该引脚定义是根据野火STM32F103霸道开发板的原理图定义的，如果需要自行的设计需要重新更改宏定义选择不同的GPIO端口
STM32F103ZET6芯片共有144个引脚
其中：GPIOA,GPIOB,GPIOC,GPIOD,GPIOE
*/

//  引脚定义
#define    KEY1_GPIO_CLK     RCC_APB2Periph_GPIOA
#define    KEY1_GPIO_PORT    GPIOA			   
#define    KEY1_GPIO_PIN	 GPIO_Pin_0

#define    KEY2_GPIO_CLK     RCC_APB2Periph_GPIOC
#define    KEY2_GPIO_PORT    GPIOC		   
#define    KEY2_GPIO_PIN	 GPIO_Pin_13


 /** 按键按下标置宏
	*  按键按下为高电平，设置 KEY_ON=1， KEY_OFF=0
	*  若按键按下为低电平，把宏设置成KEY_ON=0 ，KEY_OFF=1 即可
	*/
#define KEY_ON	1
#define KEY_OFF	0

void KEY_GPIO_Config(void);
uint8_t Key_Scan(GPIO_TypeDef* GPIOx,uint16_t GPIO_Pin);

#endif


```
#### main.c
```c
#include "stm32f10x.h"   
#include "key.h"

int main(void)
{
	
	  LED_GPIO_Config();
	  KEY_GPIO_Config();
		while(1)                            
	{	   
		if( Key_Scan(KEY1_GPIO_PORT,KEY1_GPIO_PIN) == KEY_ON  )
		{
			GPIO_ResetBits(LED1_GPIO_PORT , LED1_GPIO_PIN);//开
			GPIO_SetBits(LED2_GPIO_PORT   , LED2_GPIO_PIN);//关
			GPIO_SetBits(LED3_GPIO_PORT   , LED3_GPIO_PIN);//关
		}  

		if( Key_Scan(KEY2_GPIO_PORT,KEY2_GPIO_PIN) == KEY_ON  )
		{
		    GPIO_SetBits(LED1_GPIO_PORT , LED1_GPIO_PIN);//关
			GPIO_SetBits(LED2_GPIO_PORT , LED2_GPIO_PIN);//关
			GPIO_SetBits(LED3_GPIO_PORT , LED3_GPIO_PIN);//关
			 
		}		
	}
}
```
### 案例（51单片机 独立按键）
```c
#include"reg51.h"

/*引脚端口定义*/
sbit key1=P1^0;
sbit key2=P1^1;
sbit key3=P1^2; 
sbit key4=P1^3;

sbit led1=P2^1;
sbit led2=P2^2;

/* 声明定义*/
#define uchar unsigned char
#define uint  unsigned int
void DELAY_nMS(unsigned int time);	
void key_scan(void);

/*函数主体部分*/
void DELAY_nMS(unsigned int time)//DELAY_nMS(1)//延迟一毫秒
{
  unsigned int  i,j;             
  for(i=0;i<time;i++)    
     for(j=0;j<939;j++); 
}	
/*独立按键扫描函数*/
void key_scan(void)
{
	if(key1==0)		  //检测按键K1是否按下
	{	
		DELAY_nMS(10);   //消除抖动 一般大约10ms
		if(key1==0)	 //再次判断按键是否按下
		{
			led1=~led1;	  //led状态取反
		}
		while(!key1);	 //检测按键是否松开
	}	
	if(key2==0)		  //检测按键K1是否按下
	{	
		DELAY_nMS(10);   //消除抖动 一般大约10ms
		if(key2==0)	 //再次判断按键是否按下
		{
			led2=~led2;	  //led状态取反
		}
		while(!key2);	 //检测按键是否松开
	}	

}

void keyscan(void)
{
  if(key1==0)		  //检测按键K1是否按下
	{	
		DELAY_nMS(10);   //消除抖动 一般大约10ms
		if(key1==0)	 //再次判断按键是否按下
		{
				          //执行需要完成的操作
		}
		while(!key1);	 //检测按键是否松开
	}	
}


/*主函数部分*/
void main(void)
{
	while(1)
	{
		key_scan();
	}
}
```

### 参考资料
1.野火STM32视频学习<https://space.bilibili.com/356820657/>
2.野火STM32论坛<http://www.firebbs.cn/forum.php>
3.野火STM32开源资料<http://products.embedfire.com/zh_CN/latest/>
4.知乎链接<https://zhuanlan.zhihu.com/p/103575964>

