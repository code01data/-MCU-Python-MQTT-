---
categories:  #分类
    - AD
    - PCB
    - 嵌入式
tags:   #标签
    - AD
    - PCB
    - 嵌入式
---
# Altium designer -- 基本规则设置 （1）
<!-- more -->
## 间距设置Clearance
## 硬件设计
1. 软件 Altium designer 10
2. PCB设计
### 间距设置
- - - - - - - - - - - - - - - - - - - - - - - -
规则名称1：Clearance
一般间距 - 最小间距：6mil/8mil （优先考虑8mil）
规则1：All
规则2：All
- - - - - - - - - - - - - - - - - - - - - - - -
规则名称2：Clearance_IsGND
GND网络间距 - 最小间距：15mil/12mil（优先考虑12mil）
规则1：InNet('GND')
规则2：All
- - - - - - - - - - - - - - - - - - - - - - - -
### AD10界面
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331123417541.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331123426686.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331123435772.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331123507522.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

