---
categories:  #分类
    - 物联网
    - MQTT
    - EMQX
    - 嵌入式
tags:   #标签
    - 物联网
    - MQTT
    - EMQX
    - 嵌入式
    - WIN10
---
# win10本地安装EMQ 实现MQTT连接
<!-- more -->
## EMQ简介
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430083013451.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### EMQ X (Erlang/Enterprise/Elastic MQTT Broker) 是基于 Erlang/OTP 平台开发的开源物联网 MQTT 消息服务器。
### Erlang/OTP是出色的软实时 (Soft-Realtime)、低延时 (Low-Latency)、分布式 (Distributed)的语言平台。
### MQTT 是轻量的 (Lightweight)、发布订阅模式 (PubSub) 的物联网消息协议。
### EMQ X 设计目标是实现高可靠，并支持承载海量物联网终端的MQTT连接，支持在海量物联网设备间低延时消息路由:
1. 稳定承载大规模的 MQTT 客户端连接，单服务器节点支持50万到100万连接。
2. 分布式节点集群，快速低延时的消息路由，单集群支持1000万规模的路由。
3. 消息服务器内扩展，支持定制多种认证方式、高效存储消息到后端数据库。
4. 完整物联网协议支持，MQTT、MQTT-SN、CoAP、LwM2M、WebSocket 或私有协议支持.
### win10 安装过程
### 压缩包下载地址<>
```bash
1. 下载压缩包，解压
2. cmd进入emqttd文件夹
3. 进入bin文件夹
4. 输入  emqttd start
5. 打开浏览器 输入http://ip address:18083/#/
6. 打开页面，输入用户名admin 密码public 这是默认账号密码，可以直接修改
```
### 下载压缩包，解压
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084335147.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084356749.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084406906.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### cmd进入emqttd文件夹 
#### 进入bin文件夹
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084419268.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 输入  emqttd start
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084601393.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 打开浏览器 输入http://ip address:18083/#/
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084704299.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084820610.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200430084834356.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 参考资料
1. EMQ官方开发文档<https://docs.emqx.io/broker/latest/en/introduction/checklist.html>
2.  哔哩哔哩-树莓的小创意室 建立自己的mqtt服务器 esp8266 安卓app远程控制 语音识别 信息回传 <https://www.bilibili.com/video/BV1mJ411r7M9?t=264>









