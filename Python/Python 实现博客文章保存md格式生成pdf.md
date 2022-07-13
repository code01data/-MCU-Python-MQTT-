---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫

tags:   #标签
    - 爬虫
    - python
---
# Python 实现某博客网站文章保存md格式生成pdf
<!-- more -->
1. 导入第三方模块
```bash
pip install requests -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install parsel -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install tomd -i https://pypi.tuna.tsinghua.edu.cn/simple
```
2. 环境配置 
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
3. 代码分析

```python
# 模块导入

import requests  #pip install requests

import parsel
import tomd
import  re

# 把文章保存成markdown格式

def download_article(article_url):
    response = requests.get(article_url)
    html = response.text
    #print(html)

    # 把网页变成css选择器
    # 解析网页数据
    sel = parsel.Selector(html)
    title = sel.css('.title-article::text').get()
    content = sel.css('article').get()

    text = tomd.Tomd(content).markdown
    text = re.sub('<a.*?a>',"",text)  #正则表达式
    # 提取文章的内容与格式
    # print(title)
    # print(content)

    with open(title + '.md',mode='w',encoding='utf-8') as f:
        f.write("#"+title)
        f.write(text)

# 博客地址u'r'l,填入即可
article_url = 'https://blog.csdn.net/weixin_44048823/article/details/90247052'

download_article(article_url)
```
# 效果

```python
复制url 运行py文件
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/2020042211491938.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```bash
出现 >>> 表示已经完成下载
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422114949529.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```bash
查看 文件夹里面markdown文件
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115505626.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### markdwon to pdf
```bash
1.打开Typora 网站 https://www.typora.io/#
2.下载电脑操作系统对应的版本，并安装
3.打开下载的md文件
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115027594.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115135996.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```bash
使用Typora打开md文件
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115227706.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```bash
对于可能的乱码，目前不会其他的，删除就可以了
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115625643.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200422115243654.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020042211530954.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/202004221153199.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 博客地址<https://lemonhubs.github.io/>

