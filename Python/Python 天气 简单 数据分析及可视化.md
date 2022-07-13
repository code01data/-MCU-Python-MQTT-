---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
    - 数据可视化
    - 数据分析
tags:   #标签
    - 爬虫
    - python
    - 数据可视化
    - 数据分析
---

# Python 天气情况数据分析及可视化
<!-- more -->
### 环境配置
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
### 第三方库导入

```bash
## pip install 模块 清华大学镜像源
import requests 
from bs4 import  BeautifulSoup
import io
import sys
import pandas
from matplotlib import pyplot as plt
```
### 步骤

```bash
1.爬虫requests 获取数据
2.pandas 处理数据
3.matplotlib 绘制图形
4.其他 保存数据进入csv格式，简单处理，例如雷达图
```

### 小案例
#### 雷达图

```python
#-*- codeing = utf-8 -*-
#@Time : 2020/6/2 20:07
#@Author : dele
#@File : demo.py
#@Software: PyCharm


# 雷达图
import pygal
# pip install pygal 安装模块

rader_chart = pygal.Radar()


rader_chart.title = '成绩分析'
rader_chart.x_labels = ["数学","英语","文综","理综","体育"]
rader_chart.add('StdudetA',[139,122,80,250,10])
rader_chart.add('StdudetB',[129,100,80,250,40])
rader_chart.add('StdudetC',[150,100,80,150,60])
rader_chart.add('StdudetD',[99,140,80,150,90])
rader_chart.render_to_file('radar_chart.svg')

```
#### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602214421984.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 天气案例
####  爬取天气网站地址<http://www.tianqihoubao.com/lishi/>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602214644360.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 然后一直选择找到你需要的数据地址
例如：如图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602214731538.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 进行网页分析 F12检查网页分析源代码
### Python 爬虫代码分析
### Pandas matplotlib 模块
##### Pandas
pandas 是基于NumPy 的一种工具，该工具是为了解决数据分析任务而创建的。Pandas 纳入了大量库和一些标准的数据模型，提供了高效地操作大型数据集所需的工具。pandas提供了大量能使我们快速便捷地处理数据的函数和方法。你很快就会发现，它是使Python成为强大而高效的数据分析环境的重要因素之一。
 ##### 基本功能
```bash
1. 数据文件读取/文本数据读取
2. 索引、选取和数据过滤
3. 算法运算和数据对齐
4. 函数的应用和映射
5. 重置索引
6. 数学统计方法
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602220448310.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### matplotlib
Matplotlib 是一个 Python 的 2D绘图库，它以各种硬拷贝格式和跨平台的交互式环境生成出版质量级别的图形 。
通过 Matplotlib，开发者可以仅需要几行代码，便可以生成绘图，直方图，功率谱，条形图，错误图，散点图等。
##### Matplotlib基础知识
```bash

1.Matplotlib中的基本图表包括的元素
x轴和y轴
水平和垂直的轴线
x轴和y轴刻度
刻度标示坐标轴的分隔，包括最小刻度和最大刻度
x轴和y轴刻度标签
表示特定坐标轴的值
绘图区域
实际绘图的区域
2.hold属性
hold属性默认为True，允许在一幅图中绘制多个曲线；将hold属性修改为False，每一个plot都会覆盖前面的plot。
但是不推荐去动hold这个属性，这种做法（会有警告）。因此使用默认设置即可。
3.网格线
grid方法
使用grid方法为图添加网格线
设置grid参数（参数与plot函数相同）
.lw代表linewidth，线的粗细
.alpha表示线的明暗程度
4.axis方法
如果axis方法没有任何参数，则返回当前坐标轴的上下限
5.xlim方法和ylim方法
除了plt.axis方法，还可以通过xlim，ylim方法设置坐标轴范围
6.legend方法

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602220350171.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```python
#-*- codeing = utf-8 -*-
#@Time : 2020/6/2 20:26
#@Author : dele
#@File : weather.py
#@Software: PyCharm


import requests
from bs4 import  BeautifulSoup
import io
import sys
import pandas


sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')
def get_data(weather_url):
    rseponse = requests.get(weather_url)

    html = rseponse.content.decode('gbk')
    soup = BeautifulSoup(html,'html.parser')

    tr_lsit = soup.find_all('tr')

    print(tr_lsit)
    dates,conditions,temp = [],[],[]
    for data in tr_lsit[1:]:
        sub_data = data.text.split()
        dates.append(sub_data[0])
        conditions.append(''.join(sub_data[1:3]))
        temp.append(''.join(sub_data[3:6]))

    # 数据保存
    _data = pandas.DataFrame()
    _data['日期'] = dates
    _data['天气情况'] = conditions
    _data['气温'] = temp

    return _data
    # print(_data)
    # _data.to_csv('anqing.csv',index=False,encoding='gbk')
    # 获取数据并保存csv格式，进行下面的数据分析
    
# 定义成函数形式进行封装
data_month_3 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202003.html')
data_month_4 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202004.html')
data_month_5 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202005.html')

data = pandas.concat([data_month_3,data_month_4,data_month_5]).reset_index(drop=True)
data.to_csv('anqing.csv',index=False,encoding='gbk')
```
### 数据可视化

```python
from matplotlib import pyplot as plt

# 画图
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

datalsit = pandas.read_csv('G:/Python_Web/weather/anqing.csv',encoding='gbk')

# 数据处理
datalsit['最高气温'] = datalsit['气温'].str.split('/',expand=True)[0]
datalsit['最低气温'] = datalsit['气温'].str.split('/',expand=True)[1]

datalsit['最高气温'] = datalsit['最高气温'].map(lambda x:int(x.replace('℃','')))
datalsit['最低气温'] = datalsit['最低气温'].map(lambda x:int(x.replace('℃','')))

dates = datalsit['日期']
highs = datalsit['最高气温']
lows =  datalsit['最低气温']

# 画图

fig = plt.figure(dpi=128,figsize=(10,6))

plt.plot(dates,highs,c='red',alpha=0.5)
plt.plot(dates,lows,c='blue',alpha=0.5)

plt.fill_between(dates,highs,lows,facecolor='blue',alpha=0.2)
# 图表格式
# 设置图标的图形格式
plt.title('2020安庆市3-5月天气情况',fontsize=24)
plt.xlabel('',fontsize=6)
fig.autofmt_xdate()
plt.ylabel('气温',fontsize=12)
plt.tick_params(axis='both',which='major',labelsize=10)
# 修改刻度
plt.xticks(dates[::20])
# 显示
plt.show()
```
## 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200602215239449.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 完整代码

```python
#-*- codeing = utf-8 -*-
#@Time : 2020/6/2 20:26
#@Author : dele
#@File : weather.py
#@Software: PyCharm


import requests
from bs4 import  BeautifulSoup
import io
import sys
import pandas
from matplotlib import pyplot as plt

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')
def get_data(weather_url):
    rseponse = requests.get(weather_url)

    html = rseponse.content.decode('gbk')
    soup = BeautifulSoup(html,'html.parser')

    tr_lsit = soup.find_all('tr')

    print(tr_lsit)
    dates,conditions,temp = [],[],[]
    for data in tr_lsit[1:]:
        sub_data = data.text.split()
        dates.append(sub_data[0])
        conditions.append(''.join(sub_data[1:3]))
        temp.append(''.join(sub_data[3:6]))

    # 数据保存
    _data = pandas.DataFrame()
    _data['日期'] = dates
    _data['天气情况'] = conditions
    _data['气温'] = temp

    return _data
    # print(_data)
    # _data.to_csv('anqing.csv',index=False,encoding='gbk')

# data_month_3 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202003.html')
# data_month_4 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202004.html')
# data_month_5 =get_data('http://www.tianqihoubao.com/lishi/anqing/month/202005.html')
#
# data = pandas.concat([data_month_3,data_month_4,data_month_5]).reset_index(drop=True)
# data.to_csv('anqing.csv',index=False,encoding='gbk')



plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

datalsit = pandas.read_csv('G:/Python_Web/weather/anqing.csv',encoding='gbk')

# 数据处理
datalsit['最高气温'] = datalsit['气温'].str.split('/',expand=True)[0]
datalsit['最低气温'] = datalsit['气温'].str.split('/',expand=True)[1]

datalsit['最高气温'] = datalsit['最高气温'].map(lambda x:int(x.replace('℃','')))
datalsit['最低气温'] = datalsit['最低气温'].map(lambda x:int(x.replace('℃','')))

dates = datalsit['日期']
highs = datalsit['最高气温']
lows =  datalsit['最低气温']

# 画图

fig = plt.figure(dpi=128,figsize=(10,6))

plt.plot(dates,highs,c='red',alpha=0.5)
plt.plot(dates,lows,c='blue',alpha=0.5)

plt.fill_between(dates,highs,lows,facecolor='blue',alpha=0.2)
# 图表格式
# 设置图标的图形格式
plt.title('2020安庆市3-5月天气情况',fontsize=24)
plt.xlabel('',fontsize=6)
fig.autofmt_xdate()
plt.ylabel('气温',fontsize=12)
plt.tick_params(axis='both',which='major',labelsize=10)
# 修改刻度
plt.xticks(dates[::20])
# 显示
plt.show()
```

### 博客地址<https://www.delehub.top/>
### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
