---
categories:  #分类
    - STM32 ARM单片机
    - C
    - 电子模块
    - 嵌入式
tags:   #标签
    - STM32 ARM单片机
    - 数码管
    - 嵌入式
    - C
---
# STM32 -- 数码管显示
<!-- more -->
### 简介
1.硬件部分
STM32F103C8T6 最小系统板  一位共阴数码管
2.软件部分
Keil软件编程 数码管码表
## 硬件部分
### 数码管
#### 简介
数码管，也称作辉光管，是一种可以显示数字和其他信息的电子设备。玻璃管中包括一个金属丝网制成的阳极和多个阴极。大部分数码管阴极的形状为数字。管中充以低压气体，通常大部分为氖加上一些汞和/或氩。给某一个阴极充电，数码管就会发出颜色光，视乎管内的气体而定，一般都是橙色或绿色。
#### 分类
数码管也称LED数码管，不同行业人士对数码管的称呼不一样，其实都是同样的产品。
按发光二极管单元连接方式可分为共阳极数码管和共阴极数码管。共阳数码管是指将所有发光二极管的阳极接到一起形成公共阳极(COM)的数码管，共阳数码管在应用时应将公共极COM接到+5V，当某一字段发光二极管的阴极为低电平时，相应字段就点亮，当某一字段的阴极为高电平时，相应字段就不亮。共阴数码管是指将所有发光二极管的阴极接到一起形成公共阴极(COM)的数码管，共阴数码管在应用时应将公共极COM接到地线GND上，当某一字段发光二极管的阳极为高电平时，相应字段就点亮，当某一字段的阳极为低电平时，相应字段就不亮。
#### 1.共阳数码管
共阳数码管在应用时应将公共极COM接到+5V，当某一字段发光二极管的阴极为低电平时，相应字段就点亮，当某一字段的阴极为高电平时，相应字段就不亮。


#### 2.共阴数码管
对于共阴极数码管来说，当某个发光二极管的阳极为高电平时，发光二极管点亮，相应的段被显示。同样，共阳极数码管的阳极连接在一起，公共阳极接+5V，当某个发光二极管的阴极接低电平时，该发光二极管被点亮，相应的段被显示

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329160539852.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 数码管码表

```c
unsigned char code smgduan[17] ={0xc0, 0xf9, 0xa4, 0xb0, 0x99, 0x92, 0x82, 0xf8, 
0x80, 0x90, 0x88, 0x83, 0xc6, 0xa1, 0x86, 0x8e};//共阳数码管
unsigned char code  smgduan[17]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,
0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71};////共阴数码管
```

#### 静态数码管硬件电路设计
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329160609282.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 实物
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329160527185.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

## 软件部分

```c
/**********************************************************************
 * 文件名  ：smg.c
 * 描述    ：smg 应用函数库
 * 硬件连接：-----------------
 *          |   PA0 - A   |
 *          |   PA1 - B   |
 *          |   PA2 - C   |
 *          |   PA3 - D   |
 *          |   PA4 - E   |
 *          |   PA5 - F   |
 *          |   PA6 - G   |
 *          |   PA7 - DP  |
 *           ----------------- 																						 
*********************************************************************/

#include "smg.h"
#include "delay.h"
//共阳数码管断码表
u8 const smg_data[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e};

/*
 * 函数名：SMG_GPIO_Config
 * 描述  ：配置数码管用到的I/O口
 * 输入  ：无
 * 输出  ：无
 */
void SMG_GPIO_Config(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_GPIOA, ENABLE);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_2 | GPIO_Pin_3 | GPIO_Pin_4 | GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7;	
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;       
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	GPIO_SetBits(GPIOA, GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_2 | GPIO_Pin_3 | GPIO_Pin_4 | GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7);	 // turn off all led
}

/*
 * 函数名：SMG_Display
 * 描述  ：驱动数码管显示0-F
 * 输入  ：无
 * 输出  ：无
 */
void SMG_Display(void)
{
	u8 i;
	for(i=0;i<16;i++)
    {
			GPIO_Write(GPIOA,smg_data[i]);
        	delay_ms(1000);    		
    }
}

void Display_N(u8 N)
{
	GPIO_Write(GPIOA,smg_data[N]);   		
}
```
##### smg.h
```c
#ifndef __SMG_H
#define	__SMG_H

#include "stm32f10x.h" 

void SMG_GPIO_Config(void);
void SMG_Display(void);
void Display_N(u8 N);

#endif /* __SMG_H */

```
### 数码管案例（基于51单片机 四位数码管模块（74HC595））
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329161633630.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
14脚：DS（SER），串行数据输入引脚

13脚：OE， 输出使能控制脚，它是低电才使能输出，所以接GND

12脚：RCK，存储寄存器时钟输入引脚。上升沿时，数据从移位寄存器转存带存储寄存器。

11脚：SCK，移位寄存器时钟引脚，上升沿时，移位寄存器中的bit 数据整体后移，并接受新的bit（从SER输入）。

10脚：MR,低电平时，清空移位寄存器中已有的bit数据，一般不用，接 高电平即可。

9 脚 ：串行数据出口引脚。当移位寄存器中的数据多于8bit时，会把已有的bit“挤出去”，就是从这里出去的。用于595的级联。

Qx：并行输出引脚

注意：

当芯片资料上面的引脚说有横线时，属于低电平工作。否则高电平工作；

共阳数码管如果要点亮，对应的引脚需要给1

共阴数码管如果要点亮，对应的引脚需要给0

```c
#include"reg51.h"
unsigned char code LED_0F[] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,
0x90,0x8C,0xBF,0xC6,0xA1,0x86,0xFF,0xbf};//共阳数码管码表
unsigned char code  smgduan[17]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,
0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71};//显示0~F的值
 //-----------------------------------------------------------------------------
// 函数原形定义
#define uchar unsigned char
#define uint unsigned int
//能够使用unsigned char //unsigned int 尽量使用最原始的变量类型名字

void main (void);					// 主函数
void LED4_Display (void);			// LED数码管显示
void LED_OUT(uchar X);				// LED数码管单字节串行移位函数

unsigned char code LED_0F[];		// LED字模表
/* 端口引脚定义*/
sbit DIO = P1^0;				//串行数据输入
sbit RCLK  = P1^1;				//时钟脉冲信号――上升沿有效
sbit SCLK = P1^2;				//打入信号――――上升沿有效

//-----------------------------------------------------------------------------
// 全局变量
unsigned char LED[8];	//用于LED的8位显示缓存


//*****************************************************************************
// 主程序
//
void main (void) 
{

	LED[0]=9;
	LED[1]=0;
	LED[2]=8;
	LED[3]=5;

	while(1)
	{
		LED4_Display ();
	} 
} 

// LED数码管显示函数
void LED4_Display (void)
{
	unsigned char code *led_table;          // 查表指针
	unsigned char i;
	//显示第1位
	led_table = LED_0F + LED[0];
	i = *led_table;

	LED_OUT(i);			
	LED_OUT(0x01);	//0x01显示在第一位	

	RCLK = 0;
	RCLK = 1;
	//显示第2位
	led_table = LED_0F + LED[1];
	i = *led_table;

	LED_OUT(i);		
	LED_OUT(0x02);	//0x02显示在第2位	

	RCLK = 0;
	RCLK = 1;
	//显示第3位
	led_table = LED_0F + LED[2];
	i = *led_table;

	LED_OUT(i);			
	LED_OUT(0x04);	//0x04显示在第3位

	RCLK = 0;
	RCLK = 1;
	//显示第4位
	led_table = LED_0F + LED[3];
	i = *led_table;

	LED_OUT(i);			
	LED_OUT(0x08);	//0x08显示在第4位	

	RCLK = 0;
	RCLK = 1;
}

// LED数码管单字节串行移位函数
void LED_OUT(unsigned char number)
{
	unsigned char i;
	for(i=8;i>=1;i--)
	{
	 if (number & 0x80)
          {
               DIO=1;
          } 
          else
          {
              DIO=0;
          }
		number<<=1;
		SCLK = 0;
		SCLK = 1;
	}
}
```


### 参考资料
1.野火STM32视频学习<https://space.bilibili.com/356820657/>
2.野火STM32论坛<http://www.firebbs.cn/forum.php>
3.野火STM32开源资料<http://products.embedfire.com/zh_CN/latest/>
4.畅学电子网 <http://www.eeskill.com/>
5.知乎链接：<https://zhuanlan.zhihu.com/p/103434229>
6.共阳数码管字型码，共阴数码管字型码
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329161848727.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020032916190124.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

