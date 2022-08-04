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
# Altium designer -- 基本规则设置 (5)

<!-- more -->
## 覆铜设计Polygon
### 硬件设计
1. 软件 Altium designer 10
2. PCB设计
### 规则设置
一、覆铜连接 PolygonConnect Style
- - - - - - - - - - - - - - - - - - - - - - - -
AD10 与 AD16规则有所不同
AD10情况：
规则名称：PolygonConnect_IsVia_IsPolygon
语句1：IsVia
语句2：IsPolygon
连接类型：Direct Connect
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331125724921.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
AD16情况：
规则名称：PolygonConnect_IsVia_IsPolygon
语句1：InNet('GND') And IsVia
语句2：IsPolygon
连接类型：Direct Connect
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331125736654.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
AD10情况：
规则名称：PolygonConnect
连接类型：Relief Connect
导线数：4
导线宽度：10mil
设置导线宽度为15mil -> 10mil，原因15mil会导致GND网络标签焊盘焊接困难。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331125852866.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
AD16情况：
规则名称：PolygonConnect
连接类型：Relief Connect
导线数：4
导线宽度：10mil
导线间距：12mil
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331125903719.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
覆铜情况说明：
覆铜模式：Hatched(Tracks/Arcs)
轨迹宽度：10mil
栅格宽度：0mil
孵化模式：90度
属性 - 层：Top Layer或 Bottom Layer
属性 - 最小整洁长度：3mil
网络选项 - 链接到网络：GND 
                       Pour Over All Same Net Objects
                       选中 死铜移除
                       ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200331125923437.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

