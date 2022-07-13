---
title: OpenCV example 素描
date: 2020-8-016 12:01:24
comments: true #是否可评论
toc: true #是否显示文章目录
categories:  #分类
    - Python
    - OpenCV 
    - 人脸识别
tags:   #标签
    - Python
    - OpenCV
    - 人脸识别
---

# 基于Python--opencv的人脸识别
<!-- more -->
## 环境配置
1. 安装python3.7 配置pip 下载环境
2. 安装第三方包
	1. opencv -python的安装，输入：
```
pip install opencv-python
```
 	2. pillow的安装，输入： 
```
pip install pillow
```
	3. contrib的安装
```
pip install opencv-contrib-python
```

3. 建立一个文件夹，保存一些东西
4. 需要保存 haarcascade_frontalface_default.xml
5. 需要保存 haarcascade_eye.xml  （这两个文件很重要）
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200410082912256.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

## 软件代码分析
### FaceDetection 人脸检测

```
import numpy as np
import cv2

# 人脸识别分类器 //填入的路径为你建立的新的文件夹的路径
faceCascade = cv2.CascadeClassifier(r'E:\cv\face\haarcascade_frontalface_default.xml')

# 识别眼睛的分类器
eyeCascade = cv2.CascadeClassifier(r'E:\cv\face\haarcascade_eye.xml')

# 开启摄像头
cap = cv2.VideoCapture(0)
ok = True

while ok:
    # 读取摄像头中的图像，ok为是否读取成功的判断参数
    ok, img = cap.read()
    # 转换成灰度图像
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # 人脸检测
    faces = faceCascade.detectMultiScale(
        gray,     
        scaleFactor=1.2,
        minNeighbors=5,     
        minSize=(32, 32)
    )

    # 在检测人脸的基础上检测眼睛
    for (x, y, w, h) in faces:
        fac_gray = gray[y: (y+h), x: (x+w)]
        result = []
        eyes = eyeCascade.detectMultiScale(fac_gray, 1.3, 2)

        # 眼睛坐标的换算，将相对位置换成绝对位置
        for (ex, ey, ew, eh) in eyes:
            result.append((x+ex, y+ey, ew, eh))

    # 画矩形
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)

    for (ex, ey, ew, eh) in result:
        cv2.rectangle(img, (ex, ey), (ex+ew, ey+eh), (0, 255, 0), 2)
 
    cv2.imshow('video', img)

    k = cv2.waitKey(1)
    if k == 27:    # press 'ESC' to quit
        break
 
cap.release()
cv2.destroyAllWindows()

```
### FaceDataCollect 人脸数据收集

```
import cv2
import os
# 调用笔记本内置摄像头，所以参数为0，如果有其他的摄像头可以调整参数为1，2

cap = cv2.VideoCapture(0)

face_detector = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

face_id = input('\n enter user id:')

print('\n Initializing face capture. Look at the camera and wait ...')

count = 0

while True:

    # 从摄像头读取图片

    sucess, img = cap.read()

    # 转为灰度图片

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # 检测人脸

    faces = face_detector.detectMultiScale(gray, 1.3, 5)

    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+w), (255, 0, 0))
        count += 1

        # 保存图像
        cv2.imwrite("Facedata/User." + str(face_id) + '.' + str(count) + '.jpg', gray[y: y + h, x: x + w])

        cv2.imshow('image', img)

    # 保持画面的持续。

    k = cv2.waitKey(1)

    if k == 27:   # 通过esc键退出摄像
        break

    elif count >= 1000:  # 得到1000个样本后退出摄像
        break

# 关闭摄像头
cap.release()
cv2.destroyAllWindows()
```
#### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200410083235380.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)

#### 注意点
1. 请先创建一个Facedata文件夹并和你的程序放在一个文件夹下。
2. 请将程序和文件打包放在一个叫人脸识别的文件夹下。可以把分类器也放入其中。
3. 程序运行过程中，会提示你输入id，请从0开始输入，即第一个人的脸的数据id为0，第二个人的脸的数据id为1，运行一次可收集一张人脸的数据。
4. 程序运行时间可能会比较长，可能会有几分钟，如果嫌长，可以将     #得到1000个样本后退出摄像      这个注释前的1000，改为100。
5. 如果实在等不及，可按esc退出，但可能会导致数据不够模型精度下降。

 
### face_training 人脸数据训练

```
import numpy as np
from PIL import Image
import os
import cv2
# 人脸数据路径
path = 'Facedata'

recognizer = cv2.face.LBPHFaceRecognizer_create()
detector = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

def getImagesAndLabels(path):
    imagePaths = [os.path.join(path, f) for f in os.listdir(path)]  # join函数的作用？
    faceSamples = []
    ids = []
    for imagePath in imagePaths:
        PIL_img = Image.open(imagePath).convert('L')   # convert it to grayscale
        img_numpy = np.array(PIL_img, 'uint8')
        id = int(os.path.split(imagePath)[-1].split(".")[1])
        faces = detector.detectMultiScale(img_numpy)
        for (x, y, w, h) in faces:
            faceSamples.append(img_numpy[y:y + h, x: x + w])
            ids.append(id)
    return faceSamples, ids


print('Training faces. It will take a few seconds. Wait ...')
faces, ids = getImagesAndLabels(path)
recognizer.train(faces, np.array(ids))

recognizer.write(r'face_trainer\trainer.yml')
print("{0} faces trained. Exiting Program".format(len(np.unique(ids))))
```
#### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200410083333132.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
### face_recognition 人脸检测

```
import cv2

recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read('face_trainer/trainer.yml')
cascadePath = "haarcascade_frontalface_default.xml"
faceCascade = cv2.CascadeClassifier(cascadePath)
font = cv2.FONT_HERSHEY_SIMPLEX

idnum = 0

names = ['wanzixuan', 'Bob']

cam = cv2.VideoCapture(0)
minW = 0.1*cam.get(3)
minH = 0.1*cam.get(4)

while True:
    ret, img = cam.read()
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.2,
        minNeighbors=5,
        minSize=(int(minW), int(minH))
    )

    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
        idnum, confidence = recognizer.predict(gray[y:y+h, x:x+w])

        if confidence < 100:
            idnum = names[idnum]
            confidence = "{0}%".format(round(100 - confidence))
        else:
            idnum = "unknown"
            confidence = "{0}%".format(round(100 - confidence))

        cv2.putText(img, str(idnum), (x+5, y-5), font, 1, (0, 0, 255), 1)
        cv2.putText(img, str(confidence), (x+5, y+h-5), font, 1, (0, 0, 0), 1)

    cv2.imshow('camera', img)
    k = cv2.waitKey(10)
    if k == 27:
        break

cam.release()
cv2.destroyAllWindows()
```
### 效果
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200410083632262.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
#### 注：四个python代码具体分析，以后更新
## 参考资料
1. 基于Python3.7和opencv的人脸识别（含数据收集，模型训练） <https://www.cnblogs.com/xp12345/p/9818435.html>
2.  opencv 官网<https://opencv.org/> 
3. 基于Opencv快速实现人脸识别（完整版）<https://blog.csdn.net/beyond9305/article/details/93724948>
4. OpenCV计算机视觉实战<https://www.bilibili.com/video/BV1b741117vN?p=21>
5. CSDN博客<https://blog.csdn.net/weixin_43599390/article/details/105425237>
