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
# Python网络视频数据下载
<!-- more -->
## 简介
1. 模块导入（第三方包）

```bash
	pip install requests
	pip install json
```
2.  基本流程（思路）

```bash
# 爬虫的一般思路
# 1、分析目标网页，确定爬取的url路径，headers参数
# 2、发送请求--requests 模拟浏览器发送请求，获取响应数据
# 3、解析数据 json模块：把json字符串转化成python可交互的数据类型
# 4、保存数据--保存在目标文件夹中
```
## 案例分析
1. 使用浏览器打开网络数据采集网站<https://haokan.baidu.com/>
	我们随便选择一个分类，例如娱乐<https://haokan.baidu.com/tab/yule>
#### 使用的浏览器是谷歌chrome浏览器![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041419581473.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
2. 使用谷歌浏览器右击打开检查
3. 选择Network![在这里插入图片描述](https://img-blog.csdnimg.cn/20200414200722450.png#pic_center)
4. 重新加载界面，选择XHR
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041420074068.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
5. 选择videorec?tab...选项打开 里面有两个主要部分
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200414201347983.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
	1. Headers
	![在这里插入图片描述](https://img-blog.csdnimg.cn/20200414201305560.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
	2. Preview
	![在这里插入图片描述](https://img-blog.csdnimg.cn/20200414201328532.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
6. 建立一个python工程文件
7. 使用的环境 Pycharm python3.7.6 anconad 
### 代码分析

```python
import requests  #导入模块
# 爬取网页的url
# headers
base_url = 'https://haokan.baidu.com/videoui/api/videorec?tab=dongman&act=pcFeed&pd=pc&num=20&shuaxin_id=1586786048409'
headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36',
'cookie': 'BAIDUID=D77C61722C38FDD3B0BFA8B2A820D953:FG=1; BIDUPSID=D77C61722C38FDD3B0BFA8B2A820D953; PSTM=1585266931; BDUSS=lV0S3J5WUpoQVpjc1dzSTd2WDdFRFVJcWxxSm1zWmYxOXJvR3ZjNUlRd1NDN1plSVFBQUFBJCQAAAAAABAAAAEAAAAx~5v6bWlrZWFwawAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABJ-jl4Sfo5eR; BDORZ=FFFB88E999055A3F8A630C64834BD6D0; ai-studio-ticket=F4CFFDA9FF2746AF92ABE82F307177F75D82A97D5CDB468D986D3E8F239B685A; PC_TAB_LOG=haokan_website_page; Hm_lvt_4aadd610dfd2f5972f1efee2653a2bc5=1586780010,1586781215; Hm_lpvt_4aadd610dfd2f5972f1efee2653a2bc5=1586781215; reptileData=%7B%22data%22%3A%228ae556604f8334e690c6df18585d95fd66da1768f08b6ef4500a1f442661606743ece5594100dd732b5b7051563e865f31ecc62ed625c9baeb91b86afee8f1f79a81b01972873f7ff06a74b8073c635a0615b26b0790e9afa06686141a80a6de2ca66c7d36af97e2183fd9e72e44bd8b21c7bad462e6fc48f4f2422df70d9ed8%22%2C%22key_id%22%3A%2230%22%2C%22sign%22%3A%22612c0e81%22%7D'
        }
response = requests. get(base_url,headers)
# print(response . request . headers )
data = response . json()
print(data)
data_list = data['data']['response']['videos']#列表
# print(data_list)
#遍历列表
for datal in data_list:
    video_title = datal['title'] +'.mp4'  #视频的文件名
    video_ur1 = datal['play_url']  # 视频的ur1地址
    #   print(video_title,video_ur1)
    print('srart download.....：',video_title)
    video_data = requests. get(video_ur1,headers=headers).content
    # 4、保存数据--保存在目标文件夹中
    with open('video\\'+ video_title,mode='wb') as f:
        f.write(video_data)
        print('download finised ....\n')

print('下载结束了')

```
```bash
1. base_url 视频网站的的url
2. headers 模拟浏览器登录 user-agent cookie
3. 文件的保存
```
### 参考资料
1. 哔哩哔哩<https://www.bilibili.com/video/BV16741127po>
2. 菜鸟教程 Python<https://www.runoob.com/python3/python3-tutorial.html>
3. CSDN<https://blog.csdn.net/weixin_43599390/article/details/105519601>
4. 知乎<https://zhuanlan.zhihu.com/p/130449420>

