---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
    - 百度AIstudio

tags:   #标签
    - 文字识别
    - python
    - 百度智能云
    - 百度AIstudio
---

# Python小白逆袭大神 爬取青春有你2 小姐姐信息和图片
<!-- more -->
## 环境配置

```bash
1.基于百度百度AIstudio平台 加入课程即可，环境已经配置好了(白嫖算力)
2.本地电脑环境
Pycharm python3.7
3.模块导入
import json  # pip install json
import re   # pip install re
import requests # pip install requests
import datetime # pip install datetime
from bs4 import BeautifulSoup # pip install bs4
import os  # pip install os
#### 实在不行一个一个去网上找安装教程，应该很简单的，这些库应该很少出问题
```

## 爬虫思路

```bash
1.发送请求（requests模块）

2.获取响应数据（服务器返回）

3.解析并提取数据（BeautifulSoup查找或者re正则）

4.保存数据
```
### request模块：

```python
requests是python实现的简单易用的HTTP库，官网地址：http://cn.python-requests.org/zh_CN/latest/

requests.get(url)可以发送一个http get请求，返回服务器响应内容。
```
### BeautifulSoup库：
```bash
BeautifulSoup 是一个可以从HTML或XML文件中提取数据的Python库。网址：https://beautifulsoup.readthedocs.io/zh_CN/v4.4.0/
BeautifulSoup支持Python标准库中的HTML解析器,还支持一些第三方的解析器,其中一个是 lxml。
BeautifulSoup(markup, "html.parser")或者BeautifulSoup(markup, "lxml")，推荐使用lxml作为解析器,因为效率更高。
```

## 代码分析

```bash
1.爬取百度百科中《青春有你2》中所有参赛选手信息，返回页面数据
2.对爬取的页面数据进行解析，并保存为JSON文件
3.爬取每个选手的百度百科图片，并进行保存
4.打印爬取的所有图片的路径
```
###  1.爬取百度百科中《青春有你2》中所有参赛选手信息，返回页面数据

```python
import json
import re
import requests
import datetime
from bs4 import BeautifulSoup
import os

#获取当天的日期,并进行格式化,用于后面文件命名，格式:20200420
today = datetime.date.today().strftime('%Y%m%d')    

def crawl_wiki_data():
    """
    爬取百度百科中《青春有你2》中参赛选手信息，返回html
    """
    headers = { 
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
    }
    url='https://baike.baidu.com/item/青春有你第二季'                         

    try:
        response = requests.get(url,headers=headers)
        print(response.status_code)

        #将一段文档传入BeautifulSoup的构造方法,就能得到一个文档的对象, 可以传入一段字符串
        soup = BeautifulSoup(response.text,'lxml')
        
        #返回的是class为table-view log-set-param的<table>所有标签
        tables = soup.find_all('table',{'class':'table-view log-set-param'})

        crawl_table_title = "参赛学员"

        for table in  tables:           
            #对当前节点前面的标签和字符串进行查找
            table_titles = table.find_previous('div').find_all('h3')
            for title in table_titles:
                if(crawl_table_title in title):
                    return table       
    except Exception as e:
        print(e)

```
### 2.对爬取的页面数据进行解析，并保存为JSON文件

```python
def parse_wiki_data(table_html):
    '''
    从百度百科返回的html中解析得到选手信息，以当前日期作为文件名，存JSON文件,保存到work目录下
    '''
    bs = BeautifulSoup(str(table_html),'lxml')
    all_trs = bs.find_all('tr')

    error_list = ['\'','\"']

    stars = []

    for tr in all_trs[1:]:
         all_tds = tr.find_all('td')

         star = {}

         #姓名
         star["name"]=all_tds[0].text
         #个人百度百科链接
         star["link"]= 'https://baike.baidu.com' + all_tds[0].find('a').get('href')
         #籍贯
         star["zone"]=all_tds[1].text
         #星座
         star["constellation"]=all_tds[2].text
         #身高
         star["height"]=all_tds[3].text
         #体重
         star["weight"]= all_tds[4].text

         #花语,去除掉花语中的单引号或双引号
         flower_word = all_tds[5].text
         for c in flower_word:
             if  c in error_list:
                 flower_word=flower_word.replace(c,'')
         star["flower_word"]=flower_word 
         
         #公司
         if not all_tds[6].find('a') is  None:
             star["company"]= all_tds[6].find('a').text
         else:
             star["company"]= all_tds[6].text  

         stars.append(star)

    json_data = json.loads(str(stars).replace("\'","\""))   
    with open('work/' + today + '.json', 'w', encoding='UTF-8') as f:
        json.dump(json_data, f, ensure_ascii=False)

```

### 3.爬取每个选手的百度百科图片，并进行保存

```python
def crawl_pic_urls():
    '''
    爬取每个选手的百度百科图片，并保存
    ''' 
    with open('work/'+ today + '.json', 'r', encoding='UTF-8') as file:
         json_array = json.loads(file.read())

    headers = { 
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36' 
     }
    


    for star in json_array:

        name = star['name']
        link = star['link']

        response = requests.get(link,headers=headers)
        bs = BeautifulSoup(response.text,'lxml')

        pic_list_url = bs.select('.summary-pic a')[0].get('href')
        pic_list_url = 'https://baike.baidu.com' + pic_list_url

        pic_list_response = requests.get(pic_list_url,headers=headers)
        bs = BeautifulSoup(pic_list_response.text,'lxml')
        pic_list_html = bs.select('.pic-list img ')

        pic_urls = []

        for pic_html in pic_list_html:
            pic_url = pic_html.get('src')
            pic_urls.append(pic_url)


        # tables = soup.find_all('div',{'class':'summary-pic'})

        # for table in tables:
        #     Href = table.a['href']
        #     album_url = "https://baike.baidu.com" +Href

        #     response = requests.get(album_url, headers=headers)
        #     soup = BeautifulSoup(response.text, "lxml")
        #     pic_list_div = soup.find('div', {'class': 'pic-list'})

        #     albumImages = pic_list_div.find_all('img')

        #     for album_image in albumImages:
        #         album_image_url = album_image["src"]

                # pic_urls.append(album_image_url)
                # count =count+1
                # print(count)
                
        down_pic(name,pic_urls)

```


```python
def down_pic(name,pic_urls):
    '''
    根据图片链接列表pic_urls, 下载所有图片，保存在以name命名的文件夹中,
    '''
    path = 'work/'+'pics/'+name+'/'

    if not os.path.exists(path):
      os.makedirs(path)

    for i, pic_url in enumerate(pic_urls):
        try:
            pic = requests.get(pic_url, timeout=15)
            string = str(i + 1) + '.jpg'
            with open(path+string, 'wb') as f:
                f.write(pic.content)
                print('成功下载第%s张图片: %s' % (str(i + 1), str(pic_url)))
        except Exception as e:
            print('下载第%s张图片时失败: %s' % (str(i + 1), str(pic_url)))
            print(e)
            continue
```
###  4.打印爬取的所有图片的路径
```python
def show_pic_path(path):
    '''
    遍历所爬取的每张图片，并打印所有图片的绝对路径
    '''
    pic_num = 0
    for (dirpath,dirnames,filenames) in os.walk(path):
        for filename in filenames:
           pic_num += 1
           print("第%d张照片：%s" % (pic_num,os.path.join(dirpath,filename)))           
    print("共爬取《青春有你2》选手的%d照片" % pic_num)
    
```

```python
if __name__ == '__main__':

     #爬取百度百科中《青春有你2》中参赛选手信息，返回html
     html = crawl_wiki_data()

     #解析html,得到选手信息，保存为json文件
     parse_wiki_data(html)

     # #从每个选手的百度百科页面上爬取图片,并保存
     crawl_pic_urls()

     #打印所爬取的选手图片路径
     show_pic_path('/home/aistudio/work/pics/')

     print("所有信息爬取完成！")
```
### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200423223152445.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200423224755886.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

## 参考资料
1.百度AIstduio-Python小白逆袭大神 <https://aistudio.baidu.com/aistudio/projectdetail/421488>
2.百度AIstduio开发平台 <https://aistudio.baidu.com/aistudio/index>





