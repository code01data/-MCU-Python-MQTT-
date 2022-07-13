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

# Python cosplay壁纸图片下载(大家都懂的)
<!-- more -->
## 环境配置
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
## 爬虫的一般思路 主要流程步骤

```bash
#### 1、分析目标网页，确定爬取的url路径，headers参数
#### 2、发送请求--requests 模拟浏览器发送请求，获取响应数据
#### 3、解析数据parsel转化为Selector对象，Selector对象 具有xpath的方法，能够对转化的数据进行处理
#### 4、保存数据--保存在目标文件夹中
```
## 环境配置

```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
## 导入第三方模块

```python
	pip install requests
	pip install parsel
```
## 网页分析
#### 爬取网站美桌壁纸<http://www.win4000.com/>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200526215128429.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 爬取cosply壁纸（好东西，大家都懂得）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200526215139304.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

#### 网页链接相册的链接地址分析
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200526214708351.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)

```bash
html_data= parsel.Selector(data_text)
data_list = html_data.xpath('//div[@class="Left_bar"]//ul/li/a/@href').extract()
print(data_list)

# 获取标签 '//'  从匹配选择的当前节点选择文档中的节点，而不考虑它们的位置。
div 标签 使用@方法获取class 属性
ul/li/ 获取地址一步一步到了li标签下面
li 标签下面有a标签，标签下面有href属性，href属性里面有一些资源
```
#### 详情页面图片资源获取
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200526214708209.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)

```bash
# 详情页面数据解析
# img_url = response_2_data.xpath('//div[@class="pic-meinv"]/a/img/@data-original').extract_first()
# 获取标签 '//'  从匹配选择的当前节点选择文档中的节点，而不考虑它们的位置。
div 标签 使用@方法获取class 属性 pic-meinv
标签下面有a标签，标签下面有img属性，@data-original属性里面有一些图片地址链接资源
```

## 代码分析
```python
#-*- codeing = utf-8 -*-
#@Time : 2020/5/26 20:17
#@Author : dele
#@File : cosplay.py
#@Software: PyCharm

#爬虫的般思路
#1、分析目标网页。确定爬取的ur1路径，headers参数
#2、发送请求--requests 模拟浏览器发送请求，获取响应数据
#3、解析数据--parsel转化为Selector对象，Selector对象 具有xpath的方法，能够对转化的数据进行处理
#4、保存数据


# cosplay 静态网页 数据获取 基本方法


# 模块导入
import  requests
import  parsel
import  os

# 目标网页分析

base_url = 'http://www.win4000.com/meinvtag26.html'

headers ={
'user-agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36'
}
# 发送请求--requests 模拟浏览器发送请求，获取响应数据
response = requests.get(url=base_url,headers= headers)
response.encoding = response.apparent_encoding # 自动识别编码格式  “charset=utf-8"  ”utf-8“
data_text = response.text

# print(data_text) #打印网页源代码

html_data= parsel.Selector(data_text)
data_list = html_data.xpath('//div[@class="Left_bar"]//ul/li/a/@href').extract()
print(data_list)

for alllist in data_list:
    response_2 =requests.get(url=alllist,headers=headers).text
    response_2_data = parsel.Selector(response_2)
    img_url = response_2_data.xpath('//div[@class="pic-meinv"]/a/img/@data-original').extract_first()

    print(img_url)


    img_url_data = requests.get(url=img_url,headers=headers).content

    file_name = img_url.split('/')[-1]

    with open('cosplay_img\\'+file_name,mode='wb') as f:
        print('正在保存图片：',file_name)
        f.write(img_url_data)
```
### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200526215516158.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

### 博客<https://www.delehub.top/>







```

