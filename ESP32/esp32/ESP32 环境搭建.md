<h1><a name="t0" one-link-mark="yes"></a><a id="1_IDF_14" one-link-mark="yes"></a>1、安装 IDF环境离线包</h1> 
<hr> 
<ul><li> <p>下载<code>IDF V4.4</code>的离线安装包，900多M：<a href="https://dl.espressif.com/dl/esp-idf/" one-link-mark="yes">离线版IDF下载</a></p> </li><li> 
<p>开始安装。<br> <img src="https://img-blog.csdnimg.cn/cf8b198208cb429a8fe27c09cf0931a9.png" alt="在这里插入图片描述"></p> </li><li> <p>应用修复，后，再下一步。<br> <img src="https://img-blog.csdnimg.cn/be89754ba69b4876befa17d0fca91364.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></p> </li><li> <p>选择自己的安装位置，下一步。<br> <img src="https://img-blog.csdnimg.cn/8aaf711b54b44186af9389521b5c2334.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></p> </li><li> <p>默认，下一步。<br> <img src="https://img-blog.csdnimg.cn/d1f2aedce0584a5dbafa22034f7613ce.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></p> </li><li> <p>开始安装，等待安装完成。<br> <img src="https://img-blog.csdnimg.cn/55f5e4d7a4a845db9a8a1d47d4f32d34.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"><br> <img src="https://img-blog.csdnimg.cn/19edff7e26354bc8a36972be6a7efb73.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"><br> <img src="https://img-blog.csdnimg.cn/17c6455f732b4214a1d5545a8be5d435.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"><br> <img src="https://img-blog.csdnimg.cn/8ec7ddbdaa28452a8eac4f5ad187ee5e.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></p> </li><li> <p>自带的Eclipse IDE需要JRE环境。因为我这是拿了台新系统的旧电脑来演示，什么工具都没有。</p> </li><li> <p>不用理会，反正这个IDE自己用不习惯，后面用VSC。如个人真的有需要的话，再把JRE或者JDK装上。<br> <img src="https://img-blog.csdnimg.cn/b0cacb989ce84287a4b4b423e1d26fe8.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_16,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></p> </li></ul> 
<hr> 
<h1><a name="t1" one-link-mark="yes"></a><a id="2VScode_40" one-link-mark="yes"></a>2、VScode乐鑫插件安装</h1> 
<hr> 
<ul><li>VScode安装乐鑫插件，搜索并安装。</li><li>截至目前最新的插件版本是V1.4.0。本教程的操作均基于此版本。<br> <img src="https://img-blog.csdnimg.cn/e5b0c09206a146779d0561324e52973f.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_13,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></li><li>插件安装完后，查看 - 命令面板（快捷键Ctrl+Shift+P）。</li><li>输入 <code>configure esp-idf extension</code>，点击。<br> <img src="https://img-blog.csdnimg.cn/73351370eed9407787458d017abc4de2.png" alt="在这里插入图片描述"></li><li>选择<code>最后一项</code>。使用已存在的配置。</li><li>前两种方式均是在线安装，网络不好的会比较慢或者干脆不能安装成功。因为刚刚已经使用离线包搭建好了环境，接下来选 <code>使用已存在的配置</code> 即可。</li><li>插件会自动检测并识别系统内的位置环境。<br> <img src="https://img-blog.csdnimg.cn/e7a2d4738fab46ef80d9185d47fc2da5.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></li><li>静待成功。<br> <img src="https://img-blog.csdnimg.cn/bd66bf371f66405fa2d099f7a404e1a9.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></li><li>【注意】如果未出现第三项，也就是未自动检测出已存在配置。请使用第二项 <code>高级</code> 安装。<br> <img src="https://img-blog.csdnimg.cn/9b7809c260034571a11d76d3caba9594.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></li><li>按如下操作。选择实际路径。</li><li>稍后会提示安装缺少的工具，点安装后等待即可。<br> <img src="https://img-blog.csdnimg.cn/8c96956ee9a4496dbfdaed8c4fdfa2f2.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBATWFya19tZA==,size_20,color_FFFFFF,t_70,g_se,x_16" alt="在这里插入图片描述"></li></ul> 
<hr> 
<h1><a name="t2" one-link-mark="yes"></a><a id="3IDFDemoESP32_65" one-link-mark="yes"></a>3、从IDF的Demo中新建ESP32工程</h1> 
<hr> 
<p>  用 <code>Vscode乐鑫插件</code> 的功能，从<code>SDK</code> 的 <code>Demo</code> 模板中创建新工程。<code>ESP-IDF</code>自带了丰富的Demo，这些都会是以后学习的重要资源。</p> 
<ul><li>查看 - 命令面板（快捷键Ctrl+Shift+P）。</li><li>输入<code>show examples projects</code>，点击。<br> <img src="https://img-blog.csdnimg.cn/03237f5640924fa69e50851709c896bb.png" alt="在这里插入图片描述"></li><li>点击弹出的 <code>Use current ESP-ID</code>，使用本地<code>SDK</code>。</li><li>也就是最开始用离线版安装环境的路径。<br> <img src="https://img-blog.csdnimg.cn/e48d6a4029f54660ab64cfaed29efe53.png" alt="在这里插入图片描述"></li><li>稍后会显示如下的界面。

##### 
![在这里插入图片描述](https://img-blog.csdnimg.cn/d52660f330c44cb0bfa94d3b0de07e29.png#pic_center)

### 4.创建工程
![在这里插入图片描述](https://img-blog.csdnimg.cn/e7af09ddfa4f444a92ae0343cf5d68e6.png#pic_center)
#### ESP32开发板类型选择
使用的NodeMCU32S开发板
![在这里插入图片描述](https://img-blog.csdnimg.cn/7389e9979fa54d09ad5a719707f86466.png#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/f56140ad03d6419882da95bff6bb4758.png#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/0b76b40f5ef54d039b4869e41ed6ecf4.png#pic_center)
#####  串口连接开发板
![在这里插入图片描述](https://img-blog.csdnimg.cn/bf5a70232cae47e29d14c03a92a6e795.png#pic_center)
#### 编译工程(编译时间有点长)
![在这里插入图片描述](https://img-blog.csdnimg.cn/b74cd3ad428b47dab0b1b544adef0465.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/ed66b4dbfbc54e959bb6803a389bae1c.png#pic_center)
#### 下载程序 选择串口下载
![在这里插入图片描述](https://img-blog.csdnimg.cn/484d356029504c1b977a7057bdb1e7a8.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/3131bbf6b8ce48ea93f3a4a51c4ef87f.png#pic_center)
#### 下载程序（download）

![在这里插入图片描述](https://img-blog.csdnimg.cn/48e5231254fa47278947c86fa50bc39a.png#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/db11c3e377b047068ea97d67904e3576.png#pic_center)
### 代码（Hello World）

```c
/* Hello World Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/
#include <stdio.h>
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "esp_spi_flash.h"

void app_main(void)
{
    printf("Hello world!\n");
    printf("delehub wzx 20220403!\n");
    printf("Hello ESP32 ESPIDF!\n");


    /* Print chip information */
    esp_chip_info_t chip_info;
    esp_chip_info(&chip_info);
    printf("This is %s chip with %d CPU core(s), WiFi%s%s, ",
            CONFIG_IDF_TARGET,
            chip_info.cores,
            (chip_info.features & CHIP_FEATURE_BT) ? "/BT" : "",
            (chip_info.features & CHIP_FEATURE_BLE) ? "/BLE" : "");

    printf("silicon revision %d, ", chip_info.revision);

    printf("%dMB %s flash\n", spi_flash_get_chip_size() / (1024 * 1024),
            (chip_info.features & CHIP_FEATURE_EMB_FLASH) ? "embedded" : "external");

    printf("Minimum free heap size: %d bytes\n", esp_get_minimum_free_heap_size());

    for (int i = 10; i >= 0; i--) {
        printf("Restarting in %d seconds...\n", i);
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
    printf("Restarting now.\n");
    fflush(stdout);
    esp_restart();
}

```

### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/1c737e2401f04e79b605beb437d88eaa.png#pic_center)
#### 参考
1.[ESP32c3开发环境搭建 IDF V4.4离线版安装使用](https://blog.csdn.net/Mark_md/article/details/123218678?spm=1001.2014.3001.5502)
2.[杨奉武--001-ESP32学习开发-开发环境搭建(Windows+VSCode)](https://www.cnblogs.com/yangfengwu/p/14667359.html)
