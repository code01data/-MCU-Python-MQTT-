---
categories:  #分类
    - STM32 ARM单片机
    - C
    - 电子模块
    - 嵌入式
tags:   #标签
    - STM32 ARM单片机
    - 矩阵键盘
    - 嵌入式
    - C
---
# STM32   矩阵键盘
<!-- more -->
## 简介
1.硬件部分
2.软件部分

## 硬件部分
矩阵键盘的工作方式

对键盘的响应取决于键盘的工作方式，键盘的工作方式应根据实际应用系统中的CPU的工作状况而定，其选取的原则是既要保证CPU能及时响应按键操作，又不要过多占用CPU的工作时间。通常键盘的工作方式有三种，编程扫描、定时扫描和中断扫描。

（1）编程扫描方式

编程扫描方式是利用CPU完成其它工作的空余时间，调用键盘扫描子程序来响应键盘输入的要求。在执行键功能程序时，CPU不再响应键输入要求，直到CPU重新扫描键盘为止。

（2）定时扫描方式

定时扫描方式就是每隔一段时间对键盘扫描一次，它利用单片机内部的定时器产生一定时间（例如10ms）的定时，当定时时间到就产生定时器溢出中断。CPU响应中断后对键盘进行扫描，并在有按键按下时识别出该键，再执行该键的功能程序。

（3）中断扫描方式

上述两种键盘扫描方式，无论是否按键，CPU都要定时扫描键盘，而单片机应用系统工作时，并非经常需要键盘输入，因此，CPU经常处于空扫描状态。

为提高CPU工作效率，可采用中断扫描工作方式。其工作过程如下：当无按键按下时，CPU处理自己的工作，当有按键按下时，产生中断请求，CPU转去执行键盘扫描子程序，并识别键号。

4x4矩阵键盘模块原理图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329163924418.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

4x4矩阵键盘模块实物图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200329163935351.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 软件部分
#### key.c
```c
/*********************************************************************
 * 文件名  ：key4x4.c
 * 描述    ：按键应用函数库        

 * 硬件连接：-------------------------
 *          | PB8  - H4          |
 *          | PB9  - H3			 |
 *          | PB10 - H2          |
 *          | PB11 - H1		     |
 *          | PB12 - L4          |
 *          | PB13 - L3		     |
 *          | PB14 - L2          |
 *          | PB15 - L1			 |
 *           -------------------------
 * 库版本  ：ST3.5.0
*********************************************************************/

#include "key4x4.h" 
#include "delay.h" 

 /*
 * 函数名：Key_GPIO_Config
 * 描述  ：配置按键用到的I/O口 GPIO端口可以自行定义
 * 输入  ：无
 * 输出  ：无
 */
void Key4x4_GPIO_Config(void)
{
  	GPIO_InitTypeDef GPIO_InitStructure;
  	
  	/*开启按键端口的时钟*/
  	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);

 	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_12 | GPIO_Pin_13 | GPIO_Pin_14 | GPIO_Pin_15; //GPIO端口引脚可以自行定义
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz; 
   //配置引脚速度
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU; 
    //配置引脚模式  GPIO_Mode_IPU 上拉输入
	GPIO_Init(GPIOB, &GPIO_InitStructure);

  	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_11;	
  	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;       
  	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  	GPIO_Init(GPIOB, &GPIO_InitStructure);
}
 /*
 * 函数名：u8 Key_Scan
 * 描述  ：按键扫描函数
 * 输入  ：无
 * 输出  ：无
 */
u8 Key_Scan(void)
{
	u16 temp;
	u8 ucBackValue=0;
	//====扫描第一列==========
	GPIO_Write(GPIOB,0xfe00); 
	temp=GPIO_ReadInputData(GPIOB); //读出整个口得到的值
	temp=temp&0xf000;    //屏蔽低4位
	if (temp!=0xf000)      //假如高4位不全是1
	{ 
		delay_ms(20);      // 延时消抖再读
		temp=GPIO_ReadInputData(GPIOB); 
		temp=temp&0xf000;
		if (temp!=0xf000)     //消抖后如果再次高4位确定不是全1
		{ 
			temp=GPIO_ReadInputData(GPIOB)&0xff00; //读出此次按键的值
			switch(temp)
			{ 
				case 0xee00:
				ucBackValue = 1;break;
				case 0xde00:
				ucBackValue = 5;break;
				case 0xbe00:
				ucBackValue = 9;break;
				case 0x7e00:
				ucBackValue = 13;break;
				default:break;
			}
			while(temp!=0xf000)   //等待按键放开，初始必然被执行
			{ 
				temp=GPIO_ReadInputData(GPIOB); 
				temp=temp&0xf000;
			}

		}
	}

	//====第二列送0==========
	GPIO_Write(GPIOB,0xfd00); 
	temp=GPIO_ReadInputData(GPIOB); //读出整个口得到的值
	temp=temp&0xf000;    //屏蔽低4位
	if (temp!=0xf000)      //假如高4位不全是1
	{ 
		delay_ms(20);      // 延时消抖再读
		temp=GPIO_ReadInputData(GPIOB); 
		temp=temp&0xf000;
		if (temp!=0xf000)     //消抖后如果再次高4位确定不是全1
		{ 
			temp=GPIO_ReadInputData(GPIOB)&0xff00; //读出此次按键的值
			switch(temp)
			{ 
				case 0xed00:
					ucBackValue = 2; break;
				case 0xdd00:
					ucBackValue = 6; break;
				case 0xbd00:
					ucBackValue = 10; break;
				case 0x7d00:
					ucBackValue = 14; break;
				default:break;
		}
			while(temp!=0xf000)   //等待按键放开
			{ 
				temp=GPIO_ReadInputData(GPIOB); 
				temp=temp&0xf000;
			}
		}
	}
	//====第3列送0==========
	GPIO_Write(GPIOB,0xfb00); 
	temp=GPIO_ReadInputData(GPIOB); //读出整个口得到的值
	temp=temp&0xf000;    //屏蔽低4位
	if (temp!=0xf000)      //假如高4位不全是1
	{ 
		delay_ms(20);      // 延时消抖再读
		temp=GPIO_ReadInputData(GPIOB); 
		temp=temp&0xf000;
		if (temp!=0xf000)     //消抖后如果再次高4位确定不是全1
		{ 
			temp=GPIO_ReadInputData(GPIOB)&0xff00; //读出此次按键的值
			switch(temp)
			{ 
				case 0xeb00:
				ucBackValue = 3; break;
				case 0xdb00:
				ucBackValue = 7; break;
				case 0xbb00:
				ucBackValue = 11; break;
				case 0x7b00:
				ucBackValue = 15; break;
				default:break;
		}
		while(temp!=0xf000)   //等待按键放开
		{ 
			temp=GPIO_ReadInputData(GPIOB); 
			temp=temp&0xf000;
		}
		}
	}
	//====第4列送0==========
	GPIO_Write(GPIOB,0xf700); 
	temp=GPIO_ReadInputData(GPIOB); //读出整个口得到的值
	temp=temp&0xf000;    //屏蔽低4位
	if (temp!=0xf000)      //假如高4位不全是1
	{ 
		delay_ms(20);       // 延时消抖再读
		temp=GPIO_ReadInputData(GPIOB); 
		temp=temp&0xf000;
		if (temp!=0xf000)     //消抖后如果再次高4位确定不是全1
		{ 
			temp=GPIO_ReadInputData(GPIOB)&0xff00; 
			switch(temp)
			{ 
				case 0xe700:
				ucBackValue = 4; break;
				case 0xd700:
				ucBackValue = 8; break;
				case 0xb700:
				ucBackValue = 12; break;
				case 0x7700:
				ucBackValue = 16; break;
				default:break;
			}
			while(temp!=0xf000)   //等待按键放开
			{ 
				temp=GPIO_ReadInputData(GPIOB); 
				temp=temp&0xf000;
			}
		}
	}
	return ucBackValue;
}

```
#### key.h

```c
#ifndef __KEY_H
#define	__KEY_H

#include "stm32f10x.h"


void Key4x4_GPIO_Config(void);
u8 Key_Scan(void);

#endif /* __KEY_H */
```
### 案例（51单片机 矩阵键盘 数码管显示0~F）

```c
#include "reg52.h"			 //此文件中定义了单片机的一些特殊功能寄存器

typedef unsigned int u16;	  //对数据类型进行声明定义
typedef unsigned char u8;

#define GPIO_DIG P0
#define GPIO_KEY P1  //可以改变，引脚可以自定义
unsigned char  KeyValue;	//用来存放读取到的键值
unsigned char code smgduan[17]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,
0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71};//显示0~F的值//共阴数码管

/*******************************************************************************
* 函 数 名         : delay
* 函数功能		   : 延时函数，i=1时，大约延时10us
*******************************************************************************/
void delay(u16 i)
{
	while(i--);	
}
/*******************************************************************************
* 函 数 名         : KeyDown
* 函数功能		   : 检测有按键按下并读取键值
* 输    入         : 无
* 输    出         : 无
*******************************************************************************/
void KeyDown(void)
{
	unsigned char a=0;
	GPIO_KEY=0x0f;
	if(GPIO_KEY!=0x0f)//读取按键是否按下
	{
		delay(1000);//延时10ms进行消抖
		if(GPIO_KEY!=0x0f)//再次检测键盘是否按下
		{	
			//测试列
			GPIO_KEY=0X0F;
			switch(GPIO_KEY)
			{
				case(0X07):	KeyValue=0;break;
				case(0X0b):	KeyValue=1;break;
				case(0X0d):     KeyValue=2;break;
				case(0X0e):	KeyValue=3;break;
			}
			//测试行
			GPIO_KEY=0XF0;
			switch(GPIO_KEY)
			{
				case(0X70):	KeyValue=KeyValue;break;
				case(0Xb0):	KeyValue=KeyValue+4;break;
				case(0Xd0):     KeyValue=KeyValue+8;break;
				case(0Xe0):	KeyValue=KeyValue+12;break;
			}
			
		}
	}
             while((a<50)&&(GPIO_KEY!=0xf0))	 //检测按键松手检测
	{
		delay(100);
		a++;
	}
}
void main()
{
	 while(1)
	 {
		        KeyDown();//按键判断函数
			GPIO_DIG=~smgduan[KeyValue];
	 }
}
```

### 参考资料
1.野火STM32视频学习<https://space.bilibili.com/356820657/>
2.野火STM32论坛<http://www.firebbs.cn/forum.php>
3.野火STM32开源资料<http://products.embedfire.com/zh_CN/latest/>
4.畅学电子网 <http://www.eeskill.com/>
5.知乎链接<https://zhuanlan.zhihu.com/p/103576433>

