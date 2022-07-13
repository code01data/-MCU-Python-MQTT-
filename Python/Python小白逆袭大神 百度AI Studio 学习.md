---
categories:  #分类
    - Python
    - 软件开发
    - 爬虫
    - 百度AIstudio
    - paddlepaddle

tags:   #标签
    - 文字识别
    - python
    - 百度智能云
    - 百度AIstudio
    - 百度飞桨 paddlepaddle
---

# 百度AI-Studio【飞桨】Python小白逆袭大神课程 学习心得
<!-- more -->
## 百度AI-Studio学习平台
### 简介
#### 开源深度学习平台 飞桨
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428093905856.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
####  百度AI开放平台
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428094046302.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### Python小白逆袭大神课程

```bash
1. 课程安排明确，视频，文档资料更新快速
2. 课程安排相应的作业，实时同步你所学习的
3. 评论区，讨论激励
4. 最重要的是奖品丰富，白嫖算力(这是最简单的奖品)
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428094120554.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428094120518.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428094120488.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428094120471.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
## 主要学习内容：

#### Day1：Python基础练习(百度智能云平台体验)
##### 作业二：查找特定名称文件
```bash
遍历”Day1-homework”目录下文件；
找到文件名包含“2020”的文件；
将文件名保存到数组result中；
按照序号、文件名分行打印输出。
```

```python
#导入OS模块
import os
#待搜索的目录路径
path = "Day1-homework"
#待搜索的名称
filename = "2020"
#定义保存结果的数组
result = []

def findfiles():
    for root, dirs, files in os.walk(path):
        for name in files:
            if filename in os.path.join(root,name):
                result.append(os.path.join(root,name))
    list = sorted(result)
    for i, res in enumerate(list):
        l = []
        l.append(str(i + 1))
        l.append(res)
        print(l)
    

if __name__ == '__main__':
    findfiles()
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/202004280949069.png#pic_center)
##### 百度智能云平台体验
##### Python 百度智能云文字识别 实现手写文字识别<https://blog.csdn.net/weixin_43599390/article/details/105636437>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428095157453.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428095157451.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### Day2：爬取《青春有你2》小姐姐图片信息
##### Python小白逆袭大神 爬取青春有你2 小姐姐信息和图片<https://blog.csdn.net/weixin_43599390/article/details/105719255>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428095551511.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 下面这个是课程交流群里面一个大佬的博客记录过程，十分有意思
##### 被遗忘的8张图片（day2爬虫的王姝慧的问题）<https://blog.csdn.net/yinyiyu/article/details/105722144>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428100324189.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

#### Day3-《青春有你2》选手数据分析可视化
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428095635495.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

```python
import matplotlib.pyplot as plt
import numpy as np
import json
import matplotlib.font_manager as font_manager

with open('data/data31557/20200422.json', 'r', encoding='UTF-8') as file:
         json_array = json.loads(file.read())

labels = '40~45kg','45~50kg','50~55kg','55~60kg'
weight_size=[0,0,0,0]  #4个分类
explode = (0,0.1,0.1,0.1)  #分离程度
def weght_sort(weight):
    weight = float(weight.replace('kg',''))
    if weight<45:
        weight_size[0] += 1
    elif 45<=weight<50:
        weight_size[1] += 1
    elif 50<=weight<=55:
        weight_size[2] += 1
    elif weight>55:
        weight_size[3] += 1

weights = []
for star in json_array:
    weight = star['weight']
    weght_sort(weight)
    weights.append(weight)
print(len(weights))
print(weights)

# 设置显示中文
plt.rcParams['font.sans-serif'] = ['SimHei'] # 指定默认字体

plt.figure(figsize=(10,8))#长宽



patches,l_text,p_text = plt.pie(weight_size,explode=explode,labels=labels,
                                labeldistance = 1.1,autopct = '%3.1f%%',shadow = True,
                                startangle = 90,pctdistance = 0.5)
#labeldistance，文本的位置离远点有多远，1.1指1.1倍半径的位置
#autopct，圆里面的文本格式，%3.1f%%表示小数有三位，整数有一位的浮点数
#shadow，饼是否有阴影
#startangle，起始角度，0，表示从0开始逆时针转，为第一块。一般选择从90度开始比较好看
#pctdistance，百分比的text离圆心的距离


plt.legend()
plt.title("体重分布",fontsize = 24)
plt.savefig('work/bin_result.jpg')
print(weight_size)
plt.show()
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428095752502.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)


#### Day4：自制数据集，利用PaddleHub  进行识别
##### 这个作业最烦人，一个路径问题让许多人都出现问题，也是这个课程中讨论最多的的一个问题 
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428100723731.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 明明有图片，但是找不到
#### 自制数据集的一些东西
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428100954369.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428100954344.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### 预测效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428103915140.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

#### Day5：大作业 《青春有你2》**评论调取**、**词频**统计、绘制**词云**；自制数据集、利用PaddleHub进行**评论**情感**分析**
#### 要求效果![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428101244219.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 实际效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428101401967.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### day5 代码

```python

from __future__ import print_function
import requests
import json
import re #正则匹配
import time #时间处理模块
import jieba #中文分词
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.font_manager as font_manager
from PIL import Image
from wordcloud import WordCloud  #绘制词云模块
import paddlehub as hub
import emoji

#请求爱奇艺评论接口，返回response信息
'''
请求爱奇艺评论接口，返回response信息
参数  url: 评论的url
:return: response信息
'''
def getMovieinfo(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
    }  # 模仿数据请求，防止反爬虫

    #爱奇艺第14期下
    response = requests.get(url,headers=headers)
    return response.text   

'''
解析json数据，获取评论
参数  lastId:最后一条评论ID  arr:存放文本的list
:return: 新的lastId
 '''
#解析json数据，获取评论
def saveMovieInfoToFile(lastId,arr):
    url ="https://sns-comment.iqiyi.com/v3/comment/get_comments.action?agent_type=118&agent_version=9.11.5&\authcookie=null&business_type=17&content_id=15535228800&hot_size=0&last_id="

    url += str(lastId)
    responseTxt = getMovieinfo(url) #获取网页
    responseJson = json.loads(responseTxt)  #获取网页数据
    comments = responseJson['data']['comments']  #获取评论数据（包括id，内容等）
    for val in comments:
        if 'content' in  val.keys():  #防止有val没有'conten'键
            con = (val['content'])  #具体评论文本
            #print(con)  #打印评论
            arr.append(con)  #添加进arr
    else:
        lastId = str(val["id"])#最后一个id
    return lastId
In[7]
#去除文本中特殊字符
def clear_special_char(content):
    '''
    正则处理特殊字符
    参数 content:原文本
    return: 清除后的文本
    '''
    s = ''
    #将表情符转换成英文字符
    s = emoji.demojize(content)
    #去除不可见字符
    s = re.sub('[\001\002\003\004\005\006\007\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a]+', '', s)
    # 去除中文，返回中文列表
    s = re.findall(r'[\u4e00-\u9fa5]', content)
    #重新转换成字符串
    s = ''.join(s)
    return s
In[8]
'''
利用jieba进行分词
参数 text:需要分词的句子或文本
return：分词后的评论列表
'''
def fenci(content):
    su = []
    for com in content:
        seg =jieba.lcut(com,cut_all=False)
        for s in seg:
            su.append(s)
    return su
In[9]
'''
创建停用词表
参数 file_path:停用词文本路径
return：停用词列表stop
'''
def stopwordslist(file_path):
    spc_word = ["欣虞书","真的","言喻",'一个','啊啊啊','镜头','哈哈哈']  #特殊停用词  
    stop = []  #停用词列表
    f1 = open(file_path, "r", encoding="utf-8")
    for line in f1.readlines():
        line = line.split('\n')  # 去除换行符
        stop.append(line[0])  # 添加进停用词列表
    #print(stop)
    for i in spc_word:
        stop.append(i) #添加特殊停止词
    f1.close() 
    return stop
In[10]
'''
去除停用词,统计词频
参数 file_path:停用词文本路径 stopwords:停用词list counts: 词频统计结果
return con  #返回的是不带停用词的单词列表   
'''
#content：完全净化后的评论词列表
#word_counts：词频字典
#停用词库来源：百度
def movestopwords(file_path,content,word_counts):
    con = []
    stop = stopwordslist(file_path)
    for s in content:
        if s in stop:
            continue
        con.append(s)
    for word in con:
        if(len(word)!=1):  #如果存在就+1，如果不存在就创建
            word_counts[word] = word_counts.get(word,0)+1
    return con  #返回的是不带停用词的单词列表    
    
In[25]
'''
词频统计图
'''
def drawcounts(s,num):
    # # 显示matplotlib生成的图形
    # % matplotlib inline
    x_aixs = []
    y_aixs = []
    c_order = sorted(s.items(),key=lambda x:x[1],reverse=True)  #排序
    for c in c_order[:num]:
        x_aixs.append(c[0])
        y_aixs.append(c[1])
    # 设置显示中文
    plt.rcParams['font.sans-serif'] = ['SimHei'] # 指定默认字体
    #plt.rcParams['axes.unciode_minus'] = False #解决保存图像是负号’-‘显示为方块的问题
    plt.bar(x_aixs,y_aixs)
    plt.title('''词频统计''',fontsize = 24)
    plt.savefig('bar_result.jpg')
    
In[35]
'''
根据词频绘制词云图
参数 word_f:统计出的词频结果
return：none
'''
def drawcloud(word_f):
    cloud_mask = np.array(Image.open('wujiaoxing.png'))  #加载背景形状，转换成数组形式
    ignore = set([])  #忽略词

    wc = WordCloud(
        background_color = 'white',
        mask = cloud_mask,  #背景形状
        max_words=100,  #显示词数
        font_path='simhei.ttf',
        min_font_size=10,  #最小尺寸
        max_font_size=100,
        width=1200,
        relative_scaling=0.3,
        stopwords=ignore,  #忽略词
        mode='RGBA')
    wc.fit_words(word_f)  #填充词云
    wc.to_file('pic.png')
In[36]
'''
使用hub对评论进行内容分析
return：分析结果
'''
def text_detection(text):
    porn_detection_lstm = hub.Module(name="porn_detection_lstm")
    input_dict = {"text":text}
    results = porn_detection_lstm.detection(data=input_dict,use_gpu=False,batch_size=1)  #训练结果
    #print(results)
    print("可能敏感句子:")
    for index,item in enumerate(results):
        if item['porn_detection_key'] == 'porn':
            print(item['text'],':',item['porn_probs'])
In[37]
#评论是多分页的，得多次请求爱奇艺的评论接口才能获取多页评论,有些评论含有表情、特殊字符之类的
#num 是页数，一页10条评论，假如爬取1000条评论，设置num=100
if __name__ == "__main__":
    con = []#含有特殊字符的评论
    content = []#不含有特殊字符的评论
    count_words={}  #词频统计结果
    lastId = 41040619521
    file_path ="data/baidu_stopwords.txt"  #停用词库地址
    jieba.load_userdict("data/add_words.txt")  #添加自定义分词典
    for i in range(0,50):  #控制评论数
        lastId = saveMovieInfoToFile(lastId,con)  #改变了con，即增加了评论内容
        time.sleep(0.25)  #缓冲
    print("共获取{:}条评论".format(len(con)))
    # print("净化后的评论：")
    for s in con:
        s = clear_special_char(s)
        if(len(s)==0):  #去除空字符串
            continue
        content.append(s)
    content = fenci(content)  #分词
    content = movestopwords(file_path,content,count_words)  #去除停用词,同时统计词频
    #print(count_words)
    drawcounts(count_words,10)
    drawcloud(count_words)

#敏感句子检测
text_detection(con)
```
#### 字体库
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428102748706.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### data 文件夹里面上传自己的敏感词汇或者其他添加的文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200428102748685.png)
#### 其中的图片形状可以自行选择，我使用的是五角星，但是一定要上传图片文件

### 总结
1. 整个的学习过程虽然不长，但是能够学习到一些之前没有接触过的知识
2. 虽然能够提交作业，但是发现最大的问题的是基础不牢，而且一些作业是看着视频或者别人的代码敲的，所以可能掌握的并不很好，特别是是第2天的爬虫作业，作为一个真正的小白，python都没有学习几天，就开始搞爬虫，有点不大现实，其实大部分的代码都给好了，只是是去找关键部分，而且对于爬虫对于HTML网页结构，如何获取数据其实不懂，视频中的部分还是很少的，这就有了以后学习的方向。
3. day4 的自制数据集，还是要靠各位大佬的提供的数据集，所以开源是个好东西
4. day5 综合性作业，没有提供代码，只提供一些简单的东西 需要了解的东西就更加多了


## 参考资料
1. Python小白逆袭大神课程链接<https://aistudio.baidu.com/aistudio/course/introduce/1224>
2. 百度AI-Studio学习平台<http://ai.baidu.com/>
3. 个人博客<https://lemonhubs.github.io/>
4. CSDN<https://blog.csdn.net/weixin_43599390>
5. 知乎<https://zhuanlan.zhihu.com/p/136879675>
 


    


