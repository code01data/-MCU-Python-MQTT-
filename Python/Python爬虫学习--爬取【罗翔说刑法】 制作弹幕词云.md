---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
    - wordcloud词云

tags:   #标签
    - 爬虫
    - 数据可视化
    - python
    - wordcloud词云
---
# Python爬虫学习爬取哔哩哔哩弹幕制作词云
<!-- more -->
## 环境配置
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
## 模块导入

```python
import requests # pip install requests 
import  re   # 正则表达式
import jieba
import wordcloud
import imageio
```
## 弹幕处理
#### 爬取网站地址 <https://www.bilibili.com/video/BV14g4y1z75o>
#### 右击网页点击检查，重新加载页面
#### 抓包寻找弹幕地址，点击进入，复制地址到代码中
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200504142036889.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200504142608520.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200504142608522.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)

## 代码分析
```python
#-*- codeing = utf-8 -*-
#@Time : 2020/5/4 13:27
#@Author : dele
#@File : spider.py
#@Software: PyCharm


# 导入第三方模块
import requests
import  re
import jieba
import wordcloud
import imageio
# 弹幕url 地址
base_url = 'https://api.bilibili.com/x/v1/dm/list.so?oid=186803402'

# 设置请求头，模拟浏览器登录

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36',
        'cookie': 'BAIDUID=D77C61722C38FDD3B0BFA8B2A820D953:FG=1; BIDUPSID=D77C61722C38FDD3B0BFA8B2A820D953; PSTM=1585266931; BDUSS=lV0S3J5WUpoQVpjc1dzSTd2WDdFRFVJcWxxSm1zWmYxOXJvR3ZjNUlRd1NDN1plSVFBQUFBJCQAAAAAABAAAAEAAAAx~5v6bWlrZWFwawAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABJ-jl4Sfo5eR; BDORZ=FFFB88E999055A3F8A630C64834BD6D0; ai-studio-ticket=F4CFFDA9FF2746AF92ABE82F307177F75D82A97D5CDB468D986D3E8F239B685A; PC_TAB_LOG=haokan_website_page; Hm_lvt_4aadd610dfd2f5972f1efee2653a2bc5=1586780010,1586781215; Hm_lpvt_4aadd610dfd2f5972f1efee2653a2bc5=1586781215; reptileData=%7B%22data%22%3A%228ae556604f8334e690c6df18585d95fd66da1768f08b6ef4500a1f442661606743ece5594100dd732b5b7051563e865f31ecc62ed625c9baeb91b86afee8f1f79a81b01972873f7ff06a74b8073c635a0615b26b0790e9afa06686141a80a6de2ca66c7d36af97e2183fd9e72e44bd8b21c7bad462e6fc48f4f2422df70d9ed8%22%2C%22key_id%22%3A%2230%22%2C%22sign%22%3A%22612c0e81%22%7D'
        }
# 定义一个函数
def get_damu(url):
    response = requests.get(url, headers)
    response = response.content.decode('utf-8')
    #通过正则表达式获取两个<d>标签内包含的弹幕信息
    data = re.compile('<d.*?>(.*?)</d>')
    #对目标网页使用正则表达式，获取所有匹配的内容
    danmu = data.findall(response)
    #打印一下看看有没有成功获取到弹幕
    danmu_word = jieba.lcut(" ".join(danmu))
    # 将分词结果再次用空格连接，并转化成制作词云需要的字符串形式
    # print(danmu_word)

    # 将分词结果再次用空格连接，并转化成制作词云需要的字符串形式
    danmu_str = " ".join(danmu_word)
    print(danmu_str)
    # print(danmu)
    # mask 是选择不同形状图片的路径，一般放在于python文件同路径下面
    mask = imageio.imread("E:/deep learning/python_Leran/mask.png")
    w = wordcloud.WordCloud(font_path="msyh.ttc", background_color='white', width=1000, height=500, mask=mask)
    # 将处理好的分词弹幕加载到词云中
    w.generate(danmu_str)
    # 将生成的词云保存为danmu.png图片
    w.to_file('danmu.png')

if __name__ == '__main__':
    get_damu(base_url)

```
##  效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200504141730970.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

## 参考资料
1. 哔哩哔哩小姐姐教你做B站视频弹幕python爬虫，用云词展现做简单数据分析 <https://www.bilibili.com/video/BV1z64y1T7tf>
2. 博客地址<https://lemonhubs.github.io/>
