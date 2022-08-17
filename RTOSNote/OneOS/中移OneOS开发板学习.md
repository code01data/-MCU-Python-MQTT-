# 中移OneOS开发板学习入门
（做为一个专业的点灯爱好者，学习任何开发板开始前都是先找好学习资料，然后在学习OneOS的内核部分，外设部分，系统组件等）
## OneOS
[![oneos.jpg](https://i-s2.328888.xyz/2022/06/29/62bc53bd7bd50.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc53bd7bd50.jpg)
[OneOS](https://os.iot.10086.cn/)是中国移动针对物联网领域推出的轻量级操作系统，具有可裁剪、跨平台、低功耗、高安全等特点，支持ARM Cortex-A和 Cortex-M、MIPS、RISC-V等主流芯片架构，兼容POSIX、CMSIS等标准接口，支持Javascript、MicroPython等高级语言开发模式，提供图形化开发工具，能够有效提升开发效率、降低开发成本，帮助用户快速开发稳定可靠、安全易用的物联网应用。
### [OneOS在线开发文档](https://os.iot.10086.cn/v2/doc/homePage) 
## OneOS架构

OneOS总体架构采用分层设计，主体由驱动、内核、组件、安全框架组成。采用一个轻量级内核加多个系统组件的模式，加上海量硬件的适配支持，使OneOS具备极高的可伸缩性与易用性。操作系统整体架构如下图：

[![jnqHc8.jpg](https://s1.ax1x.com/2022/06/29/jnqHc8.jpg)](https://imgtu.com/i/jnqHc8)
### 内核

极简的设计思路，在减少资源开销的情况下兼具优秀的实时响应特征，支持多任务管理调度，提供丰富的IPC策略，如信号量、互斥量、消息队列、邮箱等，提供了高效可靠的RTOS内核支撑。

### 驱动
提供丰富的BSP板级支撑，适配超千款MCU，支持ARM、RISC-V、MIPS、Xtensa、C-Sky等主流架构，通过抽象设计，将所有外设以设备方式进行管理，极大提升了应用开发的便利性。

### 组件

提供包括网络协议、云平台接入、远程升级、文件系统、日志系统、测试框架、调试工具等众多通用服务能力，也包括高精度定位等专业应用领域的完整解决方案。由于采用了模块化的设计，因此各个组件相互独立，耦合性低，易于灵活裁剪。

### 安全管理框架

终端侧基于信任根实现轻量级的主动检测和可信度量，提供轻量级的密码算法库及轻量级密钥管理与密钥协商机制，实现端到端安全通信。平台侧基于大数据态势感知技术，帮助用户建立端侧安全画像，根据应用场景制定不同的安全管理策略。

## OneOS特点

### 灵活裁剪

抢占式的实时多任务RTOS内核，支持多任务处理、软件定时器、信号量、互斥锁、消息队列、邮箱和实时调度等特性，RAM和ROM资源占用极小。可灵活裁剪，搭配丰富组件，适应不同客户需求。

### 跨芯片平台

应用程序可无缝移植，大幅提高软件复用率。支持的主流芯片架构有：ARM Cortex-A和Cortex-M、MIPS、RISC-V等。支持几乎所有的MCU和主流的NB-IOT、4G、WIFI、蓝牙通信芯片。

### 组件丰富

提供丰富的组件功能，如互联互通、端云融合、远程升级、室内外定位、低功耗控制等。同时提供开放的第三方组件管理工具，支持添加各类第三方组件，以便扩展系统功能。

### 易于开发

一站式开发工具OneOS Studio可用于对内核和组件的功能进行配置，支持组件自由裁剪，让系统按需进行积木式构建，同时可帮助用户跟踪调试，快速定位问题。

### 低功耗设计

支持MCU和外围设备的功耗管理，用户可以根据业务场景选择相应低功耗方案，系统会自动采用相应功耗控制策略，进行休眠和调频调压，有效降低设备整体功耗。

### 安全设计

针对物联网设备资源受限、海量连接、网络异构等特点，参考等保2.0及《GB/T 36951-2018 信息安全技术 物联网感知终端应用安全技术要求》等规范，在系统安全、通信安全、数据安全等方面提供多维度安全防护能力。

### OpenCPU开发框架

支持通信SoC芯片OpenCPU开发模式，为开发者带来屏蔽复杂通信芯片差异的高效开发方式，提供统一开发体验。同时，在同样的业务功能下，减少了设备额外MCU开销和存储器的使用，大幅降低设备成本。

## 许可协议

OneOS 代码遵循 Apache 2.0 license 开源协议。
[![jnLp90.jpg](https://s1.ax1x.com/2022/06/29/jnLp90.jpg)](https://imgtu.com/i/jnLp90)
## 开发板推荐

### 万耦创世
[![oneos2.jpg](https://i-s2.328888.xyz/2022/06/29/62bc53e6a9a35.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc53e6a9a35.jpg)
万耦开发板，是中国移动推出的基于STM32，NXP等芯片的一个系列开发板，其由不同处理核心的核心板与万耦底板组成。万耦底板是通用的，核心板当前有STM32L475VGT6、STM32F401VET6与NXPLPC55S69三个型号，用户可根据需求选择不同的核心板。

### 万耦天工入门
[![oneos3.jpg](https://i-s2.328888.xyz/2022/06/29/62bc54228dc5f.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc54228dc5f.jpg)
#### [万耦天工STM32F103](https://os.iot.10086.cn/product/#18)
 专为初学开发人员设计。其实就是正点原子的STM32F103开发板，学习使用教程可以参考正点原子的使用教程。
#### [中国移动OneOS开发板开箱测评](https://zhuanlan.zhihu.com/p/417184106) 
2022年中移与正点原子推出OneOS学习教程。
#### [OneOS入门内核系列课程](https://www.bilibili.com/video/BV12S4y1c7b5?)
[![jnLoVJ.jpg](https://s1.ax1x.com/2022/06/29/jnLoVJ.jpg)](https://imgtu.com/i/jnLoVJ)
#### [OneOS入门设备驱动系列课程](https://www.bilibili.com/video/BV1sY4y1k7gR?)
[![jnL75R.jpg](https://s1.ax1x.com/2022/06/29/jnL75R.jpg)](https://imgtu.com/i/jnL75R)
#### [OneOS入门组件系列课程](https://www.bilibili.com/video/BV1634y1e7ae?)
[![jnLOxK.jpg](https://s1.ax1x.com/2022/06/29/jnLOxK.jpg)](https://imgtu.com/i/jnLOxK)

### 万耦启物
万耦启物开发板主控芯片为（国产）灵动MM32F3277G8P，板载AHT20温湿度传感器，板载ESP8266 WiFi模块，便捷接入互联网，板载USB-TTL接口，便捷与PC连接进行串口通讯。
专门为初学者设计，提供全面的基础硬件能力，同时涵盖手把手操作指导教程，方便开发者可以尽快了解OneOS系统的魅力。
[![o.jpg](https://i-s2.328888.xyz/2022/06/29/62bc5457e2fe2.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc5457e2fe2.jpg)
### 硬件资源 接口丰富 上手简单
[![jnbhWV.jpg](https://s1.ax1x.com/2022/06/29/jnbhWV.jpg)](https://imgtu.com/i/jnbhWV)
#### 接口类
1.1 板载USB-TTL接口：启物开发板Debug UART输出接口，硬件接口为USB Type-C母座，直连电脑设备识别为CH340串口，可作为5V供电接口。

1.2 MCU USB0 接口：MM32F3277 USB接口，支持USB2.0 Full-Speed（全速）。硬件接口为USB Type-C母座，可作为5V供电接口。

1.3  屏幕接口：此接口可使用逐飞科技的TFT1.8寸屏幕，也可使用114寸或2.0寸IPS屏幕，或者使用OLED屏幕，连接方式详见后续接口讲解。

1.4  摄像头接口：此接口可接入摄像头类光电传感器，兼容逐飞科技的小钻风硬件二值化摄像头、总钻风全局快门灰度摄像头。
1.5  SWD调试接口：此接口连接MM32F3277芯片的SWD调试引脚，可直接使用逐飞科技的DAP调试下载器与ARM调试下载器进行调试下载。

1.6 JTAG 调试接口：标准的JTAG接口，可使用Jlink调试下载器直连进行调试下载。

1.7  RTC电池：纽扣电池卡扣，可使用纽扣电池为芯片RTC供电。

1.8  电源拓展接口：为了方便用户接线测试使用，预留的3V3、5V与GND接口。

1.9  I0拓展接口：2.54mm间距的双排针接口，引出了芯片上部分IO引脚，包含一些常用的功能例如ADC、PWM、UART 与 SPI等。

1.10 NRF2401接口：2.54mm间距的双排座接口，可直接使用常见的SPI接口的NRF24L01模块。

1.11 SD（TF）卡座：SD卡插槽，可使用SD（TF）卡。

#### 模块类
2.1 蜂鸣器：有源蜂鸣器，使用芯片的B5引脚进行控制，可以使用PWM方式调音。

2.2 AHT20 温湿度传感器：开发板搭载的温湿度传感器，使用IC方式驱动对应芯片B10/B11引脚。

2.3 ESP8266 WiFi模块：开发板搭载的无线WiFi模块，使用UART方式驱动对应芯片BO/B1引脚。
#### 按键类
3.1 用户按键：连接至MCU的D12/D140/15引脚，按下时对应引脚处于低电平。

3.2 功能按键/RST按键：连接至MCU的RST引脚，按下时芯片复位引脚电平拉低进入复位。

3.3 功能按键/BOOTO按键：连接至MCU的H3引脚，当MCU从复位状态进入运行状态时，若此按键处于按下状态，则MCU进入ISP启动模式。

#### 跳线类
 串口选择开关：此跳线开关可选择Debug UART的Tog信息从SWD调试接口输出还是从板载USB-TTL接口输出。
 
#### 指示灯类
 RGB指示灯：RGB灯珠，RED对应芯片A1引脚，GREEN对应芯片A2引脚，BLUE对应芯片A3引脚，可使用对应引脚的PWM或者IO方式驱动。
 
 电源指示灯：主板上各3V3供电指示灯，正常黄色亮起为供电正常。

### 万耦启物开发板学习资料
#### MM32学习
灵动微电子成立于 2011 年，是中国本土通用 32 位 MCU 产品及解决方案供应商。
灵动微电子的 MCU 产品以 MM32 为标识，基于 Arm Cortex-M 系列内核，自主研发软硬件和生态系统。
#### [灵动MM32系列MCU手册例程Pack包下载指南](https://www.cnblogs.com/armny3264-lcpj/p/15959310.html)
#### [灵动微电子MM32 MCU 使用分享 视频教程](https://ke.qq.com/course/302255#term_id=100358219)
#### 逐飞科技开源库 
万耦启物开发板是逐飞科技设计生产的一块物联网开发板。所以在学习使用时，可以寻找相关的开源资料
##### [逐飞科技 MM32F327XG8P 开源库](https://gitee.com/seekfree/MM32F327X_G8P_Library)
##### 万耦启物开发板例程资料
[![oneos5.jpg](https://i-s2.328888.xyz/2022/06/29/62bc548b576a7.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc548b576a7.jpg)
[![jnb4zT.jpg](https://s1.ax1x.com/2022/06/29/jnb4zT.jpg)](https://imgtu.com/i/jnb4zT)
##### [开发板例程资料合集](https://pan.baidu.com/s/1lsO6eBXnFxoPr5TBWrTwPw)提取码：8f9u
#### 开发板支持MDK-Keil开发
启物开发板资料提供了Keil的Pack包，使用Keil开发32位芯片，对于大多数开发者都有一定的基础，能够很快的上手。
[![jnqm6S.jpg](https://s1.ax1x.com/2022/06/29/jnqm6S.jpg)](https://imgtu.com/i/jnqm6S)
#### 工程模板
[![jnqf7d.jpg](https://s1.ax1x.com/2022/06/29/jnqf7d.jpg)](https://imgtu.com/i/jnqf7d)


### OneOS官方例程
[![jnLe41.jpg](https://s1.ax1x.com/2022/06/29/jnLe41.jpg)](https://imgtu.com/i/jnLe41)
```c
/**
 ***********************************************************************************************************************
 * Copyright (c) 2020, China Mobile Communications Group Co.,Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * @file        main.c
 *
 * @brief       User application entry
 *
 * @revision
 * Date         Author          Notes
 * 2020-02-20   OneOS Team      First Version
 ***********************************************************************************************************************
 */

#include <board.h>
#include <timer/clocksource.h>
static void user_task(void *parameter)
{
    int i = 0;

    for (i = 0; i < led_table_size; i++)
    {
        os_pin_mode(led_table[i].pin, PIN_MODE_OUTPUT);
    }

    while (1)
    {
        for (i = 0; i < led_table_size; i++)
        {
            os_pin_write(led_table[i].pin, led_table[i].active_level);
            os_task_msleep(200);
            os_pin_write(led_table[i].pin, !led_table[i].active_level);
            os_task_msleep(200);
        }
    }
}

int main(void)
{
    os_task_t *task;

    task = os_task_create("user", user_task, NULL, 1024, 3);
    OS_ASSERT(task);
    os_task_startup(task);

    return 0;
}
```