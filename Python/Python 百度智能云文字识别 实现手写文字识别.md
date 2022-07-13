---
categories:  #分类
    - Python
    - 软件开发
    - 文字识别

tags:   #标签
    - 文字识别
    - python
    - 百度智能云
---

# Python  实现手写文字识别
<!-- more -->
## 简介
1. 百度智能云人工智能平台
2. 文字识别接口使用
3. 下载IP摄像头应用 调用手机摄像头，实现拍照实现文字识别
### Python 百度智能云人工智能文字识别接口 实现手写文字识别
### 百度智能云
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153209214.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 创建应用
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020042015322235.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153240863.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153254241.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153344552.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153357580.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 创建Python文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153413508.png#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420153908107.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
##### 注意：其中__init__.py,只需要建立一个，不需要添加东西在里面
#### 环境配置

```bash
Pycharm开发环境 
python 版本 python3.7
Anconda 集成开发环境
```
#### 第三方库安装
```bash
Python 环境
pip install opencv-python
pip install baidu-aip 

Anconda 环境
conda  install opencv-python
conda  install baidu-aip
```
#### Handwritten.py

```python
from aip import AipOcr  #pip install baidu-aip


config = {
    'appId':'',
    'apiKey':'',
    'secretKey':''
}
# appId apiKey  secretKey 三元组，添加自己的创建应用里面的

client = AipOcr(**config)

# 获取图像内容
def get_file_content(file):
    with open(file,'rb') as f:
        return f.read()

# 文字 to 字符
def img_to_str(image_path):
    image = get_file_content(image_path)
    result = client.handwriting(image)
    # print(result)
    if 'words_result' in result:
        return '\n'.join([w['words'] for w in result['words_result']])

```
#### ipdemo.py

```python
import  cv2  # pip install openv-python
from Handwritten import img_to_str # 导入 img_to_str


if __name__ == '__main__':
    # 创建一个窗口 1表示不能改变窗口大小
    cv2.namedWindow("camera",1)
    # 开启ip摄像头 
    # http://admin:admin@192.168.137.53:8081/video
    # 用户名/密码默认admin @ip地址 端口

    # video = 'http://admin:admin@IP地址:端口/video'
    # 开启摄像头
    capture = cv2.VideoCapture(video)
    # 按键处理
    while True:
        success,img = capture.read()
        cv2.imshow("camera",img)

        # 按键处理
        key = cv2.waitKey(10)
        # esc 退出
        if key == 27:
            print("esc break")
            break
        # 空格 保存图片
        if key ==32:
            filename = "filename.png"
            cv2.imwrite(filename,img)
            s = img_to_str(filename)
            print(s) #显示识别内容
    # 释放摄像头
    capture.release()
    #关闭窗口
    cv2.destroyWindow('camera')
```
### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200420154753558.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 博客地址<https://lemonhubs.github.io/>
#### 知乎<https://www.zhihu.com/people/bi-shi-san-2-81>
#### CSDN<https://blog.csdn.net/weixin_43599390>
