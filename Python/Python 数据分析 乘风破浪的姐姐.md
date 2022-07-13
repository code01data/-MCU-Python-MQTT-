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
# 乘风破浪的姐姐 数据分析
<!-- more -->


## 代码
```python
#-*- codeing = utf-8 -*-
#@Time : 2020/6/21 22:08
#@Author : dele
#@File : demo.py
#@Software: PyCharm


import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_csv("E:\\deep learning\\Spider\\analysisdata\\final_data.csv", encoding='gbk')
pd.set_option("display.max_colwidth",1000)
df.names = [i.strip('\r\n') for i in df.names]
print(df)


import requests
names = df['names']
urls = df['picUrl']
for name,url in zip(names, urls):
    with open('candidate/{}.jpg'.format(name.strip('\r\n')), 'wb') as f:
        f.write(requests.get(url).content)

# 年龄分布
df.age = [int(i.strip().replace('（', '').replace('）','').replace('岁','')) for i in df.age.values]


# from  pyecharts import Pie, Bar, Line
from pyecharts.charts import Pie, Bar, Line, Funnel
from pyecharts.options.global_options import ThemeType
from pyecharts import options as opts
# from pyecharts.charts import Pie, Bar, line

attr = []
count = []
age_cut = pd.cut(df.age, [26,33,40,47,54], labels=[u"26-33",u"33-40",u"40-47",u"47-54"])  # 对年龄进行分段划分

for i, j in age_cut.value_counts().items():
    attr.append(i)
    count.append(j)


pie = (Pie(init_opts=opts.InitOpts(
        theme=ThemeType.CHALK
        )).add('', [list(z) for z in zip(attr, count)],
            radius=["30%", "75%"],rosetype="radius")
         .set_global_opts(title_opts=opts.TitleOpts(title="《乘风破浪的姐姐》", subtitle="年龄分布"))
           .set_series_opts(label_opts=opts.LabelOpts(formatter="{b}: {d}%"))
       )
pie.render("age.html")

#  职业分布
from collections import Counter

jobsClass = Counter(filter(None, ''.join(df.jobs.values).split(',')))

funnel = (Funnel(init_opts=opts.InitOpts(
        theme=ThemeType.CHALK
        ))
          .add("《乘风破浪的姐姐》", [list(z) for z in zip(jobsClass.keys(), jobsClass.values())],
               sort_='ascending',
               label_opts=opts.LabelOpts(position="inside"))
          .set_global_opts(title_opts=opts.TitleOpts(title="《乘风破浪的姐姐》", subtitle="职业分布"),)
         )
funnel.render('job.html')

# 家乡分布
from pyecharts.charts import Map
import random
provinces = Counter(df.hometown)
print(provinces)
area = [(i[0],i[1]) for i in provinces.items()]
maps = (
        Map(init_opts=opts.InitOpts(
        theme=ThemeType.ROMANTIC
        ))
        .add("出生地", area, "china")
        .set_global_opts(
            title_opts=opts.TitleOpts(title="Map-基本示例"),
            legend_opts=opts.LegendOpts(is_show=False),
            visualmap_opts=opts.VisualMapOpts(max_=5, is_piecewise=True),
        )
    )

maps.render("中国地图.html")

# 成绩比较
from pyecharts import options as opts
from pyecharts.charts import Bar, Line

top = df[:29]
names = top.names.values.tolist()
ages = top.age.values.tolist()
scores = top.primaryScore.values.tolist()

bar = (
    Bar(init_opts=opts.InitOpts(
        theme=ThemeType.ROMANTIC
        ))
    .add_xaxis(names)
    .add_yaxis("年龄", ages)
    .extend_axis(
        yaxis=opts.AxisOpts(
            axislabel_opts=opts.LabelOpts(formatter="{value}分"), interval=20
        )
    )
    .set_series_opts(label_opts=opts.LabelOpts(is_show=False,))
    .set_global_opts(
        title_opts=opts.TitleOpts(title="《乘风破浪的姐姐》"),
        yaxis_opts=opts.AxisOpts(axislabel_opts=opts.LabelOpts(formatter="{value}岁",color='blue'), min_=0, max_=40),
    )
)

line = Line().add_xaxis(names).add_yaxis("初舞台评分", scores, yaxis_index=1)
bar.overlap(line)
bar.render("年龄-得分.html")

print(sum(ages) / 5)
```
# 效果 
## 年龄分布
![avatar](http://graph.baidu.com/resource/1220a680523206e1df40901596794170.jpg)
## 成绩分布
![avatar](http://graph.baidu.com/resource/122991e7c7dac11816b4e01596794167.jpg)
## 职业分布
![avatar](http://graph.baidu.com/resource/122d1310e41b383f8d58001596794164.jpg)
## 城市分布
![avatar](http://graph.baidu.com/resource/1226ef532a127c82da31201596794180.jpg)

## 参考资料 微信公众号 菜鸟学python 
### 博客<https://www.delehub.top/>
                