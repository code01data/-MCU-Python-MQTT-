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

# Python requests 网络数据采集图片下载
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
#### 3、解析数据 json模块：把json字符串转化成python可交互的数据类型
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
	pip install json
```
## 代码分析

```python
# 模块导入
import requests
import parsel
#  确定爬取的ur1路径，headers参数
base_url = 'https://tieba.baidu.com/f?kw=%D4%BC%BB%E1'
# 模拟浏览器 登录  User-Agent 相当与身份证，假装成浏览器用户
headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'}

#2、发送请求--requests 模拟浏览器发送请求，获取响应数据

response = requests.get(url=base_url,headers=headers) #得到get 发送请求
html_str = response.text
# 打印html网页源代码
# print(html_str)

#3.解析数据--parsel转 化为Selector对象，Selector对象具有xpath的方法，能够 对转化的数据进行处理
# 转换数据类型
html = parsel.Selector(html_str)
# 数据解析
title_url = html.xpath('//div[@class="threadlist_lz clearfix"]/div/a/@href').extract()
# print(title_url)
# 获取完整的url地址
second_url = 'https://tieba.baidu.com'
for url in title_url:
    all_url =second_url + url
    print('当前贴子链接',all_url)

# 继续发送地址请求
    response_2= requests.get(all_url, headers=headers).text
# 第二次解析
    response_2_data = parsel.Selector(response_2)
    reslut_list = response_2_data.xpath('//cc/div/img[@class="BDE_Image"]/@src').extract()
 #   print(reslut_list)
# 发送图片url
    for li in reslut_list:
        img_data = requests.get(li,headers= headers).content
 # 打印url  print(all_url)

    file_name =li.split('/')[-1]
    print(file_name)
# 保存数据
    with open('image\\'+file_name,'wb') as f:
        print('下载图片',file_name)
        f.write(img_data)
```

## 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417214859893.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 博客<https://lemonhubs.github.io/>
#### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
#### CSDN<https://blog.csdn.net/weixin_43599390>
