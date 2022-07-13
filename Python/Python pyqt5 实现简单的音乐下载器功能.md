---
categories:  #分类
    - Python
    - 软件开发
    - Pyqt5
tags:   #标签
    - 爬虫
    - pyqt5
    - python
---

# Python pyqt5 实现简单的音乐下载器功能
<!-- more -->
##### 界面比较糟糕，开始学习不会设计，UI以后应该会改
### 1. 环境配置
```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
安装 Pyqt5-tools工具，Qt designer设计工具
pip install pyqt5_tools
```
### 模块导入

```python
import requests
from urllib.request import urlretrieve
import jsonpath
import json
import re

import sys
from PyQt5 import QtCore, QtGui, QtWidgets

## 安装速度慢时，使用 pip install pyqt5_tools -i https://pypi.tuna.tsinghua.edu.cn/simple
```
### 网页分析
#### 某音乐平台
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020051322303626.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### 搜索你需要听的音乐名称，F12检查，查找网页内容
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223035973.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223035980.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### 复制你搜索的歌曲的播放页面的Url地址
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223035846.png)

#### 某音乐jx平台
<http://www.douqq.com/qqmusic/>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223035818.png)
#### 把你复制的音乐播放链接地址放入解析搜索栏中
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020051322330422.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
#### 进行进行F12检查，获得一些重要的参数
##### 例如接口，请求头
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223303987.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
### 代码分析
####  pyqt5 ui 文件 生成py文件
##### 由于pyqt5 ui保存的文件格式是ui文件，需要处理一下
```python
### 进入这个ui文件的位置 cmd cd 操作
 pyuic5 -o demo.py test01.ui
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223735847.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70)
##### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513223735801.png)
#### 界面代码

```python
import sys
from PyQt5 import QtCore, QtGui, QtWidgets
# 界面设计
class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 600)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(260, 380, 121, 61))
        self.pushButton.setObjectName("pushButton")
        self.lineEdit = QtWidgets.QLineEdit(self.centralwidget)
        self.lineEdit.setGeometry(QtCore.QRect(180, 190, 331, 31))
        self.lineEdit.setObjectName("lineEdit")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 23))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
		# 按键绑定，监视(实现按键操作，进行下载)
        self.pushButton.clicked.connect(self.download_mp3)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "QQ Music Download"))
        self.pushButton.setText(_translate("MainWindow", "download"))
        self.lineEdit.setPlaceholderText(_translate("MainWindow", "Please enter a song name"))
```

#### python 爬虫代码
##### def 定义了一个类里面的方法
```python
 def download_mp3(self):
        # 搜索链接
        keyword =self.lineEdit.text()
        url = 'https://c.y.qq.com/soso/fcgi-bin/client_search_cp?ct=24&qqmusic_ver=1298&new_json=1&remoteplace=txt.yqq.song&searchid=65868335786339164&t=0&aggr=1&cr=1&catZhida=1&lossless=0&flag_qc=0&p=1&n=10&w={}&g_tk_new_20200303=498689185&g_tk=498689185&loginUin=1057527027&hostUin=0&format=json&inCharset=utf8&outCharset=utf-8&notice=0&platform=yqq.json&needNewCode=0'.format(keyword)
        resp = requests.get(url)  # 获取url内容
        # print(resp.text) # 打印网页源代码
        html_doc = resp.json()
        mids = jsonpath.jsonpath(html_doc, "$..mid")
        print(mids)
        # 接口
        # headers 请求头 模拟浏览器登录
        headers = {
            'Accept': 'application/json, text/javascript, */*; q=0.01',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'zh,zh-CN;q=0.9',
            'Connection': 'keep-alive',
            'Content-Length': '65',
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Host': 'www.douqq.com',
            'Origin': 'http://www.douqq.com',
            'Referer': 'http://www.douqq.com/qqmusic/',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36129 Safari/537.36',
            'X-Requested-With': 'XMLHttpRequest',
        }
        link = 'http://www.douqq.com/qqmusic/qqapi.php'
        data = {'mid': 'https://y.qq.com/n/yqq/song/{}.html'.format(mids[0])}
        req = requests.post(url=link, data=data, headers=headers).text
        # print(req)

        req = json.loads(req)
        req = req.replace('\/', '/')  # 正则表达式，替换url下载链接
        # print(req)

        # 正则表达式
        res = re.compile('"m4a":"(.*?)",')
        rs = re.findall(res, req)
        # print(rs)
        mp3 = rs[0]  # 取列表第一个元素
        urlretrieve(mp3, keyword + '.mp3')
```


## 完整代码

```python
#-*- codeing = utf-8 -*-
#@Time : 2020/5/13 20:20
#@Author : dele
#@File : music.py
#@Software: PyCharm

# 功能实现
# 搜索 https://y.qq.com/portal/search.html#page=1&searchid=1&remoteplace=txt.yqq.top&t=song&w=lemon
# 歌曲ID https://y.qq.com/n/yqq/song/000akynZ2Rbro5.html
# 解析 http://www.douqq.com/qqmusic/qqapi.php

import requests
from urllib.request import urlretrieve
import jsonpath
import json
import re

import sys
from PyQt5 import QtCore, QtGui, QtWidgets
# 界面设计
class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 600)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(260, 380, 121, 61))
        self.pushButton.setObjectName("pushButton")
        self.lineEdit = QtWidgets.QLineEdit(self.centralwidget)
        self.lineEdit.setGeometry(QtCore.QRect(180, 190, 331, 31))
        self.lineEdit.setObjectName("lineEdit")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 23))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

        self.pushButton.clicked.connect(self.download_mp3)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "QQ Music Download"))
        self.pushButton.setText(_translate("MainWindow", "download"))
        self.lineEdit.setPlaceholderText(_translate("MainWindow", "Please enter a song name"))

    def download_mp3(self):
        # 搜索链接
        keyword =self.lineEdit.text()
        url = 'https://c.y.qq.com/soso/fcgi-bin/client_search_cp?ct=24&qqmusic_ver=1298&new_json=1&remoteplace=txt.yqq.song&searchid=65868335786339164&t=0&aggr=1&cr=1&catZhida=1&lossless=0&flag_qc=0&p=1&n=10&w={}&g_tk_new_20200303=498689185&g_tk=498689185&loginUin=1057527027&hostUin=0&format=json&inCharset=utf8&outCharset=utf-8&notice=0&platform=yqq.json&needNewCode=0'.format(keyword)
        resp = requests.get(url)  # 获取url内容
        # print(resp.text) # 打印网页源代码
        html_doc = resp.json()
        mids = jsonpath.jsonpath(html_doc, "$..mid")
        print(mids)
        # 接口
        # headers 请求头 模拟浏览器登录
        headers = {
            'Accept': 'application/json, text/javascript, */*; q=0.01',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'zh,zh-CN;q=0.9',
            'Connection': 'keep-alive',
            'Content-Length': '65',
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Host': 'www.douqq.com',
            'Origin': 'http://www.douqq.com',
            'Referer': 'http://www.douqq.com/qqmusic/',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36129 Safari/537.36',
            'X-Requested-With': 'XMLHttpRequest',
        }
        link = 'http://www.douqq.com/qqmusic/qqapi.php'
        data = {'mid': 'https://y.qq.com/n/yqq/song/{}.html'.format(mids[0])}
        req = requests.post(url=link, data=data, headers=headers).text
        # print(req)

        req = json.loads(req)
        req = req.replace('\/', '/')  # 正则表达式，替换url下载链接
        # print(req)

        # 正则表达式
        res = re.compile('"m4a":"(.*?)",')
        rs = re.findall(res, req)
        # print(rs)
        mp3 = rs[0]  # 取列表第一个元素
        urlretrieve(mp3, keyword + '.mp3')


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)

    MainWindow.show()
    sys.exit(app.exec())

```
### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020051322475626.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513224807845.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513224822208.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513224841155.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
##### 博客地址<https://www.delehub.top/>
##### CSDN<https://blog.csdn.net/weixin_43599390/article/details/106108189>
##### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
