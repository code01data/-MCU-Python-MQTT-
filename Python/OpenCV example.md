
---

categories:  #分类
    - Python
tags:   #标签
    - Python
    - OpenCV
---

# OpenCV Example 


<!-- more -->
## 环境配置
```bash
Vscode + Anconda + Python3.6
pip install opencv-python
pip install numpy
```
### 步骤
1. 将须处理图片或视频放入该文件夹
2. 重命名为 tey.jpg(mp4)
3. 运行生成代码将逐帧生成图片
4. 后运行合成视频将逐帧图片生成视频

# ![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9haS1zdHVkaW8tc3RhdGljLW9ubGluZS5jZG4uYmNlYm9zLmNvbS9mNGVkY2YyMzE5YjI0YjczOTQ0MTc1YWMyOGEzOWY0MzBjN2M4M2I2ZTdiYzQ5ODA4ZGQ4NDE4Yjk1ZDJkZTdi?x-oss-process=image/format,png)
# ![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9haS1zdHVkaW8tc3RhdGljLW9ubGluZS5jZG4uYmNlYm9zLmNvbS81MjUyMzJmNTkzYmQ0Nzg2OTc1MWRjZDhjZDdhYmM5ZmViMjFmNmY1MmU4NjRhMjI5ZWQ4ZWUxMGI5NjE3Y2Jj?x-oss-process=image/format,png)
# 
```python
#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# 查看当前挂载的数据集目录, 该目录下的变更重启环境后会自动还原
# View dataset directory. This directory will be recovered automatically after resetting environment. 
get_ipython().system('ls /home/aistudio/data')


# In[ ]:


# 查看工作区文件, 该目录下的变更将会持久保存. 请及时清理不必要的文件, 避免加载过慢.
# View personal work directory. All changes under this directory will be kept even after reset. Please clean unnecessary files in time to speed up environment loading.
get_ipython().system('ls /home/aistudio/work')


# In[ ]:


# 如果需要进行持久化安装, 需要使用持久化路径, 如下方代码示例:
# If a persistence installation is required, you need to use the persistence path as the following:
get_ipython().system('mkdir /home/aistudio/external-libraries')
get_ipython().system('pip install beautifulsoup4 -t /home/aistudio/external-libraries')


# In[ ]:


# 同时添加如下代码, 这样每次环境(kernel)启动的时候只要运行下方代码即可:
# Also add the following code, so that every time the environment (kernel) starts, just run the following code:
import sys
sys.path.append('/home/aistudio/external-libraries')


# 请点击[此处](https://ai.baidu.com/docs#/AIStudio_Project_Notebook/a38e5576)查看本环境基本用法.  <br>
# Please click [here ](https://ai.baidu.com/docs#/AIStudio_Project_Notebook/a38e5576) for more detailed instructions. 



# In[1]:


#-*- codeing = utf-8 -*-
#@Time : 2020/8/2 8:24
#@Author : dele
#@File : video.py
#@Software: PyCharm

import numpy as np
import cv2
cap = cv2.VideoCapture("data/tey.mp4")
i = 1
while(cap.isOpened):
    ret,img = cap.read()
    imgsize = img.shape
    height = imgsize[0]
    width = imgsize[1]
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    inv = np.zeros((height,width,1),np.uint8)
    for x in range(0,height):
        for y in range(0,width):
            gar = gray[x,y]
            inv[x,y] = 255 - gar
    blur = cv2.GaussianBlur(inv,(21,21),0)
    dst = cv2.addWeighted(gray,0.5,blur,0.5,0)
    a,dst1= cv2.threshold(dst,125,255,1)
    for x in range(0,height):
        for y in range(0,width):
            gar1 = dst1[x,y]
            dst1[x,y] = 255 - gar1
            if dst1[x,y] == 255:
                dst1[x,y] = 240
            if dst1[x,y] == 0:
                dst1[x,y] = 30
    dst1= cv2.GaussianBlur(dst1,(5,5),0)
    cv2.imwrite("%d.jpg"%i,dst1)
    print("第%d帧"%i)
    i+=1
cap.release()
print("ok")


# In[ ]:


import cv2

fps = 30
#填写原视频帧率
fourcc = cv2.VideoWriter_fourcc('M','J','P','G')
videoWriter = cv2.VideoWriter('dst.avi', fourcc, fps, (1920,1080))
#(640,360)为原视频宽高
for i in range(1,1249):
    img= cv2.imread('%d.jpg'%i)
    videoWriter.write(img)
videoWriter.release()


# In[ ]:


#-*- codeing = utf-8 -*-
#@Time : 2020/8/2 8:21
#@Author : dele
#@File : demo1.py
#@Software: PyCharm

import cv2
import numpy as np
img = cv2.imread("data/tey.jpg",1)
imgsize = img.shape
height = imgsize[0]
width = imgsize[1]
gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
inv = np.zeros((height,width,1),np.uint8)
for x in range(0,height):
    for y in range(0,width):
        gar = gray[x,y]
        inv[x,y] = 255 - gar
blur = cv2.GaussianBlur(inv,(21,21),0)
dst = cv2.addWeighted(gray,0.5,blur,0.5,0)
a,dst1= cv2.threshold(dst,125,255,1)
for x in range(0,height):
    for y in range(0,width):
        gar1 = dst1[x,y]
        dst1[x,y] = 255 - gar1
        if dst1[x,y] == 255:
            dst1[x,y] = 240
        if dst1[x,y] == 0:
            dst1[x,y] = 30

dst1= cv2.GaussianBlur(dst1,(5,5),0)
cv2.imshow("img",img)
cv2.imshow("gray",gray)
cv2.imshow("inv",inv)
cv2.imshow("blur",blur)
cv2.imshow("dst",dst)
cv2.imshow("dst1",dst1)
cv2.imwrite("dst.jpg",dst1)
cv2.waitKey(0)
cv2.destroyAllWindows()


```

