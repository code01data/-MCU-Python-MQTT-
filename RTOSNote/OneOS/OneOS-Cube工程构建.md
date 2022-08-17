# 中移OneOS入门学习 --OneOS系统工程构建
（做为一个专业的点灯爱好者，学习任何开发板开始前都是先找好学习资料，然后在学习OneOS的内核部分，外设部分，系统组件等）
## OneOS
[![oneos.jpg](https://i-s2.328888.xyz/2022/06/29/62bc53bd7bd50.jpg)](https://i-s2.328888.xyz/2022/06/29/62bc53bd7bd50.jpg)
[OneOS](https://os.iot.10086.cn/)是中国移动针对物联网领域推出的轻量级操作系统，具有可裁剪、跨平台、低功耗、高安全等特点，支持ARM Cortex-A和 Cortex-M、MIPS、RISC-V等主流芯片架构，兼容POSIX、CMSIS等标准接口，支持Javascript、MicroPython等高级语言开发模式，提供图形化开发工具，能够有效提升开发效率、降低开发成本，帮助用户快速开发稳定可靠、安全易用的物联网应用。


## OneOS-Cube工程构建
通过示例工程演示的使用和体验，我们初步感受到了OneOS的运行效果，也对如何使用OneOS建立了一定的信心。但示例工程毕竟不能做成产品，要想进行产品开发，还要根据产品的需求开发产品代码。那么，如何构建产品的代码工程，将是摆在各位开发者面前的一个问题。

一种简单的方法是，基于示例工程构建产品代码工程。具体的步骤是：

构建一个合适的示例工程（示例工程所使用的芯片型号与产品所使用的芯片型号相同）；
根据产品的需求，更改示例工程的设置；
在示例工程的board目录和application目录中，可以增加新的目录和文件，用以开发产品代码。
### 工具与源码下载
#### OneOS-Cube OneOS-V2.3.0
#### 
[源码](https://os.iot.10086.cn/download-official/)
[Tool](https://os.iot.10086.cn/download-official/tool)
![oneoscube.png](https://img1.imgtp.com/2022/07/08/hWfahtsv.png)
![oneosv2.3.png](https://img1.imgtp.com/2022/07/08/qhvrfAov.png)
#### 解压
打开文件夹 包括两个重要的文件
![oneso.png](https://img1.imgtp.com/2022/07/08/B62gNMV1.png)
打开project文件夹，然后使用OneOS-Cube右键打开
![onepro.png](https://img1.imgtp.com/2022/07/08/eRxlbg1r.png)
![oneos1.png](https://img1.imgtp.com/2022/07/08/vXGpbkRZ.png)
### 进入配置界面
![配置界面.png](https://img1.imgtp.com/2022/07/08/2MgJ4BLA.png)
现在选择芯片厂商，芯片类型，芯片种类，具体芯片
![cs.png](https://img1.imgtp.com/2022/07/08/bs0ACVnU.png)

#### 选择STM32 STM32F103系列 选择了STM32F103ZET6

![Snipaste_2022-07-08_10-41-22.png](https://img1.imgtp.com/2022/07/08/L19eUi2E.png)
![Snipaste_2022-07-08_10-41-39.png](https://img1.imgtp.com/2022/07/08/3lmBmMfn.png)
![Snipaste_2022-07-08_10-41-05.png](https://img1.imgtp.com/2022/07/08/V4QSlSU6.png)
### 完成基础芯片的选择，完成基本配置 (ESC退出，自动构建mdk5工程)
![Snipaste_2022-07-08_10-45-44.png](https://img1.imgtp.com/2022/07/08/s6iHhqpM.png)
![Snipaste_2022-07-08_10-46-08.png](https://img1.imgtp.com/2022/07/08/MfGI9MWq.png)

### STM32F103ZET6工程构建完成 
![Snipaste_2022-07-08_10-46-42.png](https://img1.imgtp.com/2022/07/08/MjNLB1iJ.png)
![Project-stm32f1zet6.png](https://img1.imgtp.com/2022/07/08/Yp7J5i5o.png)
### 使用MDK打开工程，编译代码，烧录固件即可(观察现象)
![Snipaste_2022-07-08_10-47-43.png](https://img1.imgtp.com/2022/07/08/7V4CQpMw.png)

### 
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
 * 2020-11-20   OneOS Team      First Version
 ***********************************************************************************************************************
 */

#include <board.h>
#include <os_task.h>

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

    task = os_task_create("user", user_task, NULL, 512, 3);
    OS_ASSERT(task);
    os_task_startup(task);

    return 0;
}
-
```




