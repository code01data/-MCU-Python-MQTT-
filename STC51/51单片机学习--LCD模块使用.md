---
categories:  #分类
    - 单片机
    - LCD
    - 电子模块
tags:   #标签
    - 51单片机
    - LCD
---

# 51单片机学习--LCD模块使用
### 常见的液晶显示屏模块 LCD1602 LCD12864 
<!-- more -->
## LCD1602
### LCD1602模块
工业字符型液晶。1602是指LCD显示的内容为16X2,即可以显示两行，每行16个字符.
### 特殊接口说明:
1.   RS:寄存器选择输入端
2.   RS=1:指向数据寄存器
3.   RS=0:指向指令寄存器
4.   RW:读写控制输入端
5.    RW=0:写操作 RW=1：读操作
6. E:使能信号输入端,读操作时，高电平有效；写操作时，下降沿有效；

### 初始化过程
第一步：写指令38H，显示模式设置；
第二步：写指令08H，显示关闭；
第三步；写指令01H，显示清屏；
第四步：写指令06H，显示光标移动设置；
第五步：写指令0CH，显示光标开及光标设置
![avatar](/medias/images/lcd1.jpg)
![avatar](/medias/images/lcd2.jpg)
![avatar](/medias/images/lcd3.jpg)
### 硬件电路
![avatar](/medias/images/lcd4.jpg)
### 软件代码
```c
#include"reg51.h"//51单片机头文件
/*相关引脚的定义*///该部分可以自己去定义，我是学习51单片机时选择普中单片机开发板。
sbit rs=P2^6;    //命令/数据选择
sbit rw=P2^5;    //读写口
sbit  e=P2^7;    //锁存控制
/*函数声明*/

void LCD1602_SetArea(unsigned char X,unsigned char Y);
void LCD1602_ShowChar(unsigned char X,unsigned char Y,unsigned char Char);
void LCD1602_ShowString(unsigned char X,unsigned char Y,unsigned char *String);
void LCD1602_ShowArray(unsigned char X,unsigned char Y,unsigned char *Array,unsigned char Count);
void LCD1602_ShowNumber_Integer(unsigned char X,unsigned char Y,int IntegerNumber,unsigned char Count);
void InitLCD();

/*延迟函数的定义*/
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
//向LCD写一命令
void wcode(unsigned char t)
{
  rs=0;           // 写的是命令
  rw=0;           // 写状态
  e=1;            //使能
  P0=t;           //写入命令 
  DELAY_nMS(2);      //等待写入,如果时间太短，会导致液晶无法显示
  e=0;            //数据的锁定
}
//向LCD写一数据
void wdata(unsigned char t)
{
  rs=1;          // 写的是数据
  rw=0;          // 写状态
  e=1;           //使能
  P0=t;          //写入数据
  DELAY_nMS(2);     //等待写入,如果时间太短，会导致液晶无法显示
  e=0;           //数据的锁定
}
//LCD设置坐标位置
void LCD1602_SetArea(unsigned char X,unsigned char Y)
{
    switch(Y)
    {
        case 0: wcode(0x80 + X); break;
        case 1: wcode(0xC0 + X); break;
        default:break;
    }
}
//LCD显示字符
void LCD1602_ShowChar(unsigned char X,unsigned char Y,unsigned char Char)
{
    LCD1602_SetArea(X,Y);                           // 设置显示坐标
    wdata(Char);                        // 显示指定字符
}
//LCD显示字符串
void LCD1602_ShowString(unsigned char X,unsigned char Y,unsigned char *String)
{            
    LCD1602_SetArea(X,Y);                           // 设置显示坐标
    while(*String)
    {
        wdata(*String);
        String++;
    }
}
//LCD显示数组
void LCD1602_ShowArray(unsigned char X,unsigned char Y,unsigned char *Array,unsigned char Count)
{
    unsigned char i;                                // 定义局部变量，用于函数循环计数
    LCD1602_SetArea(X,Y);                           // 设置显示坐标

    for(i=0; i<Count; i++)
    {
        wdata(Array[i]);
    }
}
//LCD显示有符号的整形数字
void LCD1602_ShowNumber_Integer(unsigned char X,unsigned char Y,int IntegerNumber,unsigned char Count)
{
    unsigned char Number_Integer_Array[5]={0};

    //----------------------------------------------------------------------------------------------
    // 判断 整型数字正负
    //----------------------------------------------------------------------------------------------
    if(IntegerNumber < 0)
    {
        IntegerNumber=0 - IntegerNumber;
        LCD1602_ShowChar(X, Y, '-');
    }
    else
    {
        LCD1602_ShowChar(X, Y, '+');
    }

    //----------------------------------------------------------------------------------------------
    // 限制 显示字符数
    //----------------------------------------------------------------------------------------------
    if(Count > 5)
    {
        Count = 5;
    }
    Number_Integer_Array[0] = (IntegerNumber / 10000) % 10 + 0x30;
    Number_Integer_Array[1] = (IntegerNumber / 1000 ) % 10 + 0x30;
    Number_Integer_Array[2] = (IntegerNumber / 100  ) % 10 + 0x30;
    Number_Integer_Array[3] = (IntegerNumber / 10   ) % 10 + 0x30;
    Number_Integer_Array[4] = (IntegerNumber / 1    ) % 10 + 0x30;

    LCD1602_ShowArray(X+1,Y,&(Number_Integer_Array+(5-Count)),Count);
}

/*******************************************************************************
* 函 数 名       : Display_Unsignedint（）
* 函数功能		 : 显示无符号整形
* 输    入       : 无
* 输    出       : 无
*******************************************************************************/
void LCD1602_ShowNumber_UnsignedInt(unsigned char x,unsigned char y,unsigned int Number,unsigned char Count)
{
	unsigned char NumbArray[6]={0};    
   
    NumbArray[0]=(Number/10000)%10+0x30; 
    NumbArray[1]=(Number/1000) %10+0x30;
    NumbArray[2]=(Number/100)  %10+0x30;
    NumbArray[3]=(Number/10)   %10+0x30;
    NumbArray[4]=(Number/1)    %10+0x30; 
    NumbArray[5]= 0;
 
    LCD1602_ShowString(x,y,&NumbArray[5-Count]);
}
/*******************************************************************************
* 函 数 名       : Display_Float（）
* 函数功能		 : 显示浮点数
* 输    入       : 无
* 输    出       : 无
*******************************************************************************/
void LCD1602_Display_Float(unsigned char x,
                    unsigned char y,
                    float Number,
                    unsigned char Count1,
                    unsigned char Count2)
{
    unsigned char NumberArray[11]={0};         

    unsigned int  Number_Integer = 0;      
    unsigned int  Number_Decimal = 0;       

    float Number_Temp;
    
    Number_Temp = Number;
    
    if(Number_Temp < 0)
    {
        Number_Temp= 0 - Number_Temp;
    }
    Number_Integer = (unsigned int)(Number_Temp);                                        
    Number_Decimal = (unsigned short)((Number_Temp - Number_Integer + 0.0005) * 1e3);     

    NumberArray[ 0] = '+';
    NumberArray[ 1] = Number_Integer/10000 % 10 + 0x30;
    NumberArray[ 2] = Number_Integer/ 1000 % 10 + 0x30;
    NumberArray[ 3] = Number_Integer/  100 % 10 + 0x30;
    NumberArray[ 4] = Number_Integer/   10 % 10 + 0x30;
    NumberArray[ 5] = Number_Integer/    1 % 10 + 0x30;
	NumberArray[ 6] ='.';
    NumberArray[ 7] = Number_Decimal/  100 % 10 + 0x30;
    NumberArray[ 8] = Number_Decimal/   10 % 10 + 0x30;
    NumberArray[ 9] = Number_Decimal/    1 % 10 + 0x30;
    NumberArray[10] = 0;
    
    if(Number>0)
    {
        NumberArray[5-Count1] = '+';
    }
    else
    {
        NumberArray[5-Count1] = '-';
    }
    
    NumberArray[7+Count2] = 0; 
    LCD1602_ShowString(x, y, &NumberArray[5-Count1]);

}
//LCD初始化
void InitLCD()
{  		 
   wcode(0x01);	  //清屏
   wcode(0x06);   //输入方式控制,增量光标不移位
   wcode(0x0e);   //显示开关控制
   wcode(0x38);   //功能设定:设置16x2显示，5x7显示,8位数据接口     	
}

/*******************************************************************************
* 函 数 名       : main（）
* 函数功能       :主函数
* 输    入       : 无
* 输    出       : 无
*******************************************************************************/
void main()
{
	InitLCD();
	while(1)
	{
		 LCD1602_ShowString(0,0,"hello mcu");
		 LCD1602_Display_Float(0,1,123.4,3,1);
	}
}
```

## LCD12864模块
12864LCD属于点阵图形液晶显示模块，不但能显示字符，还能显示汉字和图形，分带汉字库和不带那字库两种，价格也有差别。带汉字库的12864LCD使用起来非常方便，不需要编写复杂的汉字显示程序，只要按时序写入两个字节的汉字机内码，汉字就能显示出来了，驱动程序简单许多。本文例程就是基于带汉字库的12864液晶显示模块。DM12864M 汉字图形点阵液晶显示模块，可显示汉字及图形，内置 8192 个中文汉字（16X16 点阵）、128个字符 64X256 点阵显示 RAM。
### 12864有两种工作模式。
#### （1）文本工作模式
整屏平均分成32个显示区（每个显示区是16X16点阵），每个显示区可显示一个中文，每个显示区可显示两个英文ASCII字符。下图为汉字显示坐标即地址。
![avatar](/medias/images/lcd5.jpg)

#### （2）绘图工作模式
整屏按水平方向每16个点分为一组，所以整屏共有8192/16＝512组，每次可控制任意一组的16个点。图形显示坐标：水平方向 X—以字节单位，垂直方向 Y—以位为单位。
![avatar](/medias/images/lcd6.jpg)

### 12864的硬件接口
![avatar](/medias/images/lcd7.jpg)
![avatar](/medias/images/lcd8.jpg)
### 软件代码
```c
#include"reg51.h"
/*********************************************************************************************************************************
  实验名称：普中单片机12864的使用
  实验效果：倒计时100显示
*****************************************************************************************************************************/

/**********************************************************************************************************
                    端口定义
************************************************************************************************************/

sbit RS=P2^6; //命令/数据选择  
sbit RW=P2^5;  //读写口 
sbit  E=P2^7;	  //锁存控制  
sbit RES = P2^0; 
sbit PSB = P2^2;

/**********************************************************************************************************
              函数声明        
************************************************************************************************************/

void InitLCD(void);	

void Display_Char(unsigned char x,unsigned char y,unsigned char  Char);
void Display_String(unsigned char x,unsigned char y,unsigned char  *s);
void Display_UnsignedInt(unsigned char x,
                          unsigned char y,
                          unsigned int Number,
						  unsigned  char Count); 
void Display_SignedInt(unsigned char x,
                       unsigned char y,
                       signed int Number,
                       unsigned char Count)	;
void Display_Float(unsigned char x,
                    unsigned char y,
                    float Number,
                    unsigned char Count1,
                    unsigned char Count2);
					
void DELAY_nUS(unsigned int Time);
void DELAY_nMS(unsigned int time);
void delay(unsigned int time);  
/**********************************************************************
	函数主体部分
***************************************************************************/
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

void delay(unsigned int time)              //int型数据为16位,所以最大值为65535            
 {										   //0.1ms
   unsigned int  i,j;                  //定义变量i,j,用于循环语句 
   for(i=0;i<time;i++)         //for循环,循环50*time次
     for(j=0;j<50;j++);       //for循环,循环50次
 }

//查忙
void checkbusy(void)           
{
   RS=0;                   
   RW=1;                  
   E=1;                    
   while((P0&0x80)==0x80); 
   E=0;                   
}

void wcode(unsigned char cmdcode)
{
   checkbusy();           
   RS=0;                   
   RW=0;                   
   E=1;                  
   P0=cmdcode;            
   delay(10);               
   E=0;                    
}
void wdata(unsigned char dispdata)
{
   checkbusy();           
   RS=1;                  
   RW=0;                  
   E=1;                   
   P0=dispdata;           
   delay(10);              
   E=0;                    
}
void InitLCD(void)
   {
   PSB=1;            
   RES=0;
   delay(10);         
   RES=1;             
   wcode(0x30);       
   wcode(0x0c);       
   wcode(0x01);       
   wcode(0x06);       	
}  

void Display_Char(unsigned char x,unsigned char y,unsigned char  Char)   
{                                    
  switch(y)                              
     { 
	  case 0: wcode(0x80+x);break;  
	  case 1: wcode(0x90+x);break;   
	  case 2: wcode(0x88+x);break;    
	  case 3: wcode(0x98+x);break;  
      default:break;
	 }
	 wdata(Char);


}
void Display_String(unsigned char x,unsigned char y,unsigned char  *s)   
{                                    
 switch(y)                                     
     { 
	  case 0: wcode(0x80+x);break;   
	  case 1: wcode(0x90+x);break;    
	  case 2: wcode(0x88+x);break;   
	  case 3: wcode(0x98+x);break;    
      default:break;
	 }
   while(*s>0)                        
     {  
      wdata(*s);                     
      delay(10);                     
      s++;                         
     }
}
void Display_UnsignedInt(unsigned char x,unsigned char y,unsigned int Number,unsigned char Count)
{
	unsigned char NumbArray[6]={0};    
   
    NumbArray[0]=(Number/10000)%10+0x30; 
    NumbArray[1]=(Number/1000) %10+0x30;
    NumbArray[2]=(Number/100)  %10+0x30;
    NumbArray[3]=(Number/10)   %10+0x30;
    NumbArray[4]=(Number/1)    %10+0x30; 
    NumbArray[5]= 0;
 
    Display_String(x,y,&NumbArray[5-Count]);
}
void Display_SignedInt(unsigned char x,
                       unsigned char y,
                       signed int Number,
                       unsigned char Count)
{
    unsigned char NumberArray[7]={0};    
    signed int Number_Temp;
    
    Number_Temp = Number;
    if(Number_Temp<0)
    {
        Number_Temp = 0 - Number_Temp;
    }

    NumberArray[0]='+'; 
    NumberArray[1]=(Number_Temp/10000)%10+0x30; 
    NumberArray[2]=(Number_Temp/1000) %10+0x30;
    NumberArray[3]=(Number_Temp/100)  %10+0x30;
    NumberArray[4]=(Number_Temp/10)   %10+0x30;
    NumberArray[5]=(Number_Temp/1)    %10+0x30;
    NumberArray[6]=0;
    
    if(Number>0)
    {
        NumberArray[5-Count] = '+';
    }
    else
    {
        NumberArray[5-Count] = '-';
    }
    
    Display_String(x, y, &NumberArray[5-Count]);
}
void Display_Float(unsigned char x,
                    unsigned char y,
                    float Number,
                    unsigned char Count1,
                    unsigned char Count2)
{
    unsigned char NumberArray[11]={0};         

    unsigned int  Number_Integer = 0;      
    unsigned int  Number_Decimal = 0;       

    float Number_Temp;
    
    Number_Temp = Number;
    
    if(Number_Temp < 0)
    {
        Number_Temp= 0 - Number_Temp;
    }

  
    Number_Integer = (unsigned int)(Number_Temp);                                        
    Number_Decimal = (unsigned short)((Number_Temp - Number_Integer + 0.0005) * 1e3);     


    NumberArray[ 0] = '+';
    NumberArray[ 1] = Number_Integer/10000 % 10 + 0x30;
    NumberArray[ 2] = Number_Integer/ 1000 % 10 + 0x30;
    NumberArray[ 3] = Number_Integer/  100 % 10 + 0x30;
    NumberArray[ 4] = Number_Integer/   10 % 10 + 0x30;
    NumberArray[ 5] = Number_Integer/    1 % 10 + 0x30;
	NumberArray[ 6] ='.';
    NumberArray[ 7] = Number_Decimal/  100 % 10 + 0x30;
    NumberArray[ 8] = Number_Decimal/   10 % 10 + 0x30;
    NumberArray[ 9] = Number_Decimal/    1 % 10 + 0x30;
    NumberArray[10] = 0;
    
    if(Number>0)
    {
        NumberArray[5-Count1] = '+';
    }
    else
    {
        NumberArray[5-Count1] = '-';
    }
    
    NumberArray[7+Count2] = 0; 
    Display_String(x, y, &NumberArray[5-Count1]);

}


void main()
{
     int i;
	 InitLCD();
   while(1)
   {
         for(i=100;i>0;i--)
    	 {
            Display_SignedInt(0,0,i,3);
            DELAY_nMS(500);
         }
   }


}
```

知乎链接 <https://zhuanlan.zhihu.com/p/102563354>
