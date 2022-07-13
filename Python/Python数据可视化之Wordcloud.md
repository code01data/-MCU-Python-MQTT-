---
categories:  #分类
    - Python
    - 软件开发
    - wordcloud词云

tags:   #标签
    - 数据可视化
    - python
    - wordcloud词云
---

# Python wordcloud
<!-- more -->
## 环境配置
### 安装所需的Python第三方模块

```python
pip install numpy matplotlib pillow wordcloud imageio jieba snownlp itchat -i https://pypi.tuna.tsinghua.edu.cn/simple
```
## 案例分析
### 案例1

```python
import wordcloud

w = wordcloud.WordCloud()

w.generate('and that government of the people, by the people, for the people, shall not perish from the earth.')

w.to_file('output1.png')
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041114122811.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 案例2

```python
import wordcloud

# 构建词云对象w，设置词云图片宽、高、字体、背景颜色等参数
w = wordcloud.WordCloud(width=1000,height=700,background_color='white',font_path='msyh.ttc')

# 调用词云对象的generate方法，将文本传入
w.generate('深度学习 人工智能 神经网络 物联网 5G AI  机器学习 PYTHON')

# 将生成的词云保存为output2-poem.png图片文件，保存到当前文件夹中
w.to_file('output2-poem.png')
```


![在这里插入图片描述](https://img-blog.csdnimg.cn/202004111416442.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 案例3

```python

import wordcloud

# 从外部.txt文件中读取大段文本，存入变量txt中
f = open('deep learning.txt',encoding='utf-8')
txt = f.read()

# 构建词云对象w，设置词云图片宽、高、字体、背景颜色等参数
w = wordcloud.WordCloud(width=1000,
                        height=700,
                        background_color='white',
                        font_path='msyh.ttc')

# 将txt变量传入w的generate()方法，给词云输入文字
w.generate(txt)

# 将词云图片导出到当前文件夹
w.to_file('output3-sentence.png')

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020041114182315.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 案例4

```python
# 导入词云制作库wordcloud和中文分词库jieba
import jieba
import wordcloud
# 构建并配置词云对象w
w = wordcloud.WordCloud(width=1000,
                        height=700,
                        background_color='white',
                        font_path='msyh.ttc')

# 调用jieba的lcut()方法对原始文本进行中文分词，得到string
txt = '人工智能（Artificial Intelligence），英文缩写为AI。它是研究、开发用于模拟、延伸和扩展人的智能的理论、方法、技术及应用系统的一门新的技术科学。人工智能是计算机科学的一个分支，它企图了解智能的实质，并生产出一种新的能以人类智能相似的方式做出反应的智能机器，该领域的研究包括机器人、语言识别、图像识别、自然语言处理和专家系统等。人工智能从诞生以来，理论和技术日益成熟，应用领域也不断扩大，可以设想，未来人工智能带来的科技产品，将会是人类智慧的“容器”。人工智能可以对人的意识、思维的信息过程的模拟。人工智能不是人的智能，但能像人那样思考、也可能超过人的智能。人工智能是一门极富挑战性的科学，从事这项工作的人必须懂得计算机知识，心理学和哲学。人工智能是包括十分广泛的科学，它由不同的领域组成，如机器学习，计算机视觉等等，总的说来，人工智能研究的一个主要目标是使机器能够胜任一些通常需要人类智能才能完成的复杂工作。但不同的时代、不同的人对这种“复杂工作”的理解是不同的。 [1]  2017年12月，人工智能入选“2017年度中国媒体十大流行语'
txtlist = jieba.lcut(txt)
string = " ".join(txtlist)

# 将string变量传入w的generate()方法，给词云输入文字
w.generate(string)

# 将词云图片导出到当前文件夹
w.to_file('output4-tongji.png')

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411142111833.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 案例5

```python
# 导入词云制作库wordcloud和中文分词库jieba
import jieba
import wordcloud

# 构建并配置词云对象w
w = wordcloud.WordCloud(width=1000,
                        height=700,
                        background_color='white',
                        font_path='msyh.ttc')

# 对来自外部文件的文本进行中文分词，得到string
f = open('deep learning.txt',encoding='utf-8')
txt = f.read()
txtlist = jieba.lcut(txt)
string = " ".join(txtlist)

# 将string变量传入w的generate()方法，给词云输入文字
w.generate(string)

# 将词云图片导出到当前文件夹
w.to_file('output5-village.png')

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411142149173.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

### 案例6

```python
# 导入词云制作库wordcloud和中文分词库jieba
import jieba
import wordcloud

# 导入imageio库中的imread函数，并用这个函数读取本地图片，作为词云形状图片
import imageio
mk = imageio.imread("E:/opencv face/wordcloud/wujiaoxing.png")
w = wordcloud.WordCloud(mask=mk)

# 构建并配置词云对象w，注意要加scale参数，提高清晰度
w = wordcloud.WordCloud(width=1000,
                        height=700,
                        background_color='white',
                        font_path='msyh.ttc',
                        mask=mk,
                        scale=15)

# 对来自外部文件的文本进行中文分词，得到string
f = open('deep learning.txt',encoding='utf-8')
txt = f.read()
txtlist = jieba.lcut(txt)
string = " ".join(txtlist)

# 将string变量传入w的generate()方法，给词云输入文字
w.generate(string)

# 将词云图片导出到当前文件夹
w.to_file('output6-village.png')

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411142217713.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### 案例7

```python
# 导入词云制作库wordcloud和中文分词库jieba
import jieba
import wordcloud

# 导入imageio库中的imread函数，并用这个函数读取本地图片，作为词云形状图片
import imageio
mk = imageio.imread("chinamap.png")
w = wordcloud.WordCloud(mask=mk)

# 构建并配置词云对象w，注意要加scale参数，提高清晰度
w = wordcloud.WordCloud(width=1000,
                        height=700,
                        background_color='white',
                        font_path='msyh.ttc',
                        mask=mk,
                        scale=15)

# 对来自外部文件的文本进行中文分词，得到string
f = open('deep learning.txt',encoding='utf-8')
txt = f.read()
txtlist = jieba.lcut(txt)
string = " ".join(txtlist)

# 将string变量传入w的generate()方法，给词云输入文字
w.generate(string)

# 将词云图片导出到当前文件夹
w.to_file('output7-chinamap.png')

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411142302619.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411142526311.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 后面继续增加案例
######  白嫖真的舒服
### 参考资料
1. 同济子号兄<https://github.com/TommyZihao>
2. CSDN<https://blog.csdn.net/weixin_43599390/article/details/105451858>
3. 知乎<https://zhuanlan.zhihu.com/p/128987132>