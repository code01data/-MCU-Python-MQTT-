---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
tags:   #标签
    - 爬虫
    - python
    - 视频下载
---
# Python requests 网络数据采集视频下载
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
# 学习模块
# requests
# json
# 动态数据抓包


# 下载一页的视频
import requests  #导入模块 pip install requests

# 1、分析目标网页，确定爬取的url路径，headers参数
base_url ='https://www.ku6.com/video/feed?pageNo=0&pageSize=40&subjectId=74'

headers = {'user-agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
}
# 2、发送请求 requests 模拟浏览器发送请求，获取响应数据
response = requests.get(base_url,headers= headers) #
data = response.json()
print(data)

# 3、解析数据 json模块：把json字符串转化成python可交互的数据类型

data_list = data['data']
# print.pprint(data_list) 打印列表

# for循环遍历列表
for datal in data_list:
    video_title = datal['title'] + ".mp4"  # 视频标题
    video_url = datal['playUrl']           #  视频Url
    # print(video_title,video_url)           # 打印标题
    print('srart download.....：',video_title)  # 打印 srart download  视频标题
    video_data = requests.get(video_url,headers=headers).content  #
    # 图片视频音频文件都是二进制的，用wb进行保存，写入response.content content方法
    with open('video\\'+ video_title,mode='wb') as f:  #保存数据
        f.write(video_data)
        print('download finised ....\n')

print('download endding') 
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417214212915.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417214226213.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200417214244761.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041721425842.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041721440330.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
##### 博客<https://lemonhubs.github.io/>
#### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
#### CSDN<https://blog.csdn.net/weixin_43599390>