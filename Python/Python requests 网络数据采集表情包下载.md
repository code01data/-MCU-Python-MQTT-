---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
tags:   #标签
    - 爬虫
    - python
    - 图片下载
---

# Python requests 网络数据采集贴吧图片下载
<!-- more -->
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
## 爬虫的一般思路 主要流程步骤

```bash
#### 1、分析目标网页，确定爬取的url路径，headers参数
#### 2、发送请求--requests 模拟浏览器发送请求，获取响应数据
#### 3、解析数据 json模块：把json字符串转化成python可交互的数据类型
#### 4、保存数据--保存在目标文件夹中
```
## 环境配置

```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
##### 爬取网站地址<https://www.fabiaoqing.com/>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417215400629.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 导入第三方模块

```python
	pip install requests
	pip install json
```

## 代码分析

```python
# 模块导入
import  requests
import  parsel
import  os

images_dir = 'image' # 文件保存
# for循环 下载多页的图片
for page in range(1,11):
    # response = requests. get(base_url,headers)
    # 请求网站 获得数据
    # f'https://www.fabiaoqing.com/biaoqing/lists/page/{page}.html'  f 填空
    response = requests.get(f'https://www.fabiaoqing.com/biaoqing/lists/page/{page}.html')
    print(response.text)

    # 数据解析方式 css xpath re
    sel = parsel.Selector(response.text)
    # css技术
    # print(sel.css('.ui.segment img').getall())
    # print(sel.xpath('//*[@id="bqb"]/div[1]/div[32]/a/img').getall())

    imgs = sel.css('.ui.segment img')
    
    for img in imgs:
        image_url = img.xpath('./@data-original').get()
        image_name = img.xpath('./@title').get()
        print(image_url,image_name)
        # 下载图片
        response = requests.get(image_url)
        # 图片视频音频文件都是二进制的，用wb进行保存，写入response.content
        suffix = image_url.split('.')[-1]

        try:
            # open第一个参数path文件夹名/文件名
            # 为什么要加一个判断，判断文件夹是否存在
            # 文件夹文件目录数据库已经存在的东西 创建一个文件夹
            if not  os.path.exists(images_dir):
                os.mkdir(images_dir)
            with open(images_dir+'/'+image_name + '.'+suffix, mode='wb') as f:
                f.write(response.content)
        except:
            pass
```
## 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417215520311.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
##### 博客<https://lemonhubs.github.io/>
#### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
#### CSDN<https://blog.csdn.net/weixin_43599390>
