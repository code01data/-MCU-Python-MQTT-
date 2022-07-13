---
categories:  #分类
    - Python
    - 软件开发
    - 手势识别
    - 百度AIstudio
    - paddlepaddle

tags:   #标签
    - 手势识别
    - python
    - 百度智能云
    - 百度AIstudio
    - 百度飞桨 paddlepaddle
---

# 百度AI 深度学习 CV 训练营  手势识别
<!-- more -->
## 深度学习
深度学习(DL, Deep Learning)是机器学习(ML, Machine Learning)领域中一个新的研究方向，它被引入机器学习使其更接近于最初的目标——人工智能(AI, Artificial Intelligence)。 
深度学习是学习样本数据的内在规律和表示层次，这些学习过程中获得的信息对诸如文字，图像和声音等数据的解释有很大的帮助。它的最终目标是让机器能够像人一样具有分析学习能力，能够识别文字、图像和声音等数据。 深度学习是一个复杂的机器学习算法，在语音和图像识别方面取得的效果，远远超过先前相关技术。
深度学习在搜索技术，数据挖掘，机器学习，机器翻译，自然语言处理，多媒体学习，语音，推荐和个性化技术，以及其他相关领域都取得了很多成果。深度学习使机器模仿视听和思考等人类的活动，解决了很多复杂的模式识别难题，使得人工智能相关技术取得了很大进步。
## 理论知识
Paddlepadddle零基础深度学习7日入门-CV疫情特辑学习笔记
<https://blog.csdn.net/claychenlei/article/details/105271658>
##### 我觉得这个这个总结的挺好的
## 环境搭建
一般采用百度AI官方的教程
我个人选择的是电脑本地开发
1. 安装Anaconda详细安装及使用教程（带图文）（非常详细）
<https://blog.csdn.net/ITLearnHall/article/details/81708148>
2. 安装python运行环境  Pycharm
3. 安装paddlepaddle 教程非常详细
<https://www.paddlepaddle.org.cn/install/quick>
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411135229304.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411135312290.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200411135621778.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzU5OTM5MA==,size_16,color_FFFFFF,t_70#pic_center)
## 代码

```python
import os
import time
import random
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import paddle
import paddle.fluid as fluid
import paddle.fluid.layers as layers
from multiprocessing import cpu_count

from PIL._imaging import display
from paddle.fluid.dygraph import Pool2D,Conv2D
from paddle.fluid.dygraph import Linear

# 生成图像列表
data_path = 'data/Dataset'
character_folders = os.listdir(data_path)
# print(character_folders)
if (os.path.exists('./train_data.list')):
    os.remove('./train_data.list')
if (os.path.exists('./test_data.list')):
    os.remove('./test_data.list')

for character_folder in character_folders:

    with open('./train_data.list', 'a') as f_train:
        with open('./test_data.list', 'a') as f_test:
            if character_folder == '.DS_Store':
                continue
            character_imgs = os.listdir(os.path.join(data_path, character_folder))
            count = 0
            for img in character_imgs:
                if img == '.DS_Store':
                    continue
                if count % 10 == 0:
                    f_test.write(os.path.join(data_path, character_folder, img) + '\t' + character_folder + '\n')
                else:
                    f_train.write(os.path.join(data_path, character_folder, img) + '\t' + character_folder + '\n')
                count += 1
print('列表已生成')

#%%

# 定义训练集和测试集的reader
def data_mapper(sample):
    img, label = sample
    img = Image.open(img)
    img = img.resize((100, 100), Image.ANTIALIAS)
    img = np.array(img).astype('float32')
    img = img.transpose((2, 0, 1))#对图片做了转置，
    img = img/255.0
    return img, label

#定义数据读取器
def data_reader(data_list_path):
    def reader():
        with open(data_list_path, 'r') as f:
            lines = f.readlines()
            for line in lines:
                img, label = line.split('\t')
                yield img, int(label)
    return paddle.reader.xmap_readers(data_mapper, reader, cpu_count(), 512)
    #语法不懂

# 用于训练的数据提供器
train_reader = paddle.batch(reader=paddle.reader.shuffle(reader=data_reader('./train_data.list'), buf_size=256), batch_size=32)
# 用于测试的数据提供器
test_reader = paddle.batch(reader=data_reader('./test_data.list'), batch_size=32)


# 定义DNN网络
class MyDNN(fluid.dygraph.Layer):
    def __init__(self):
        super(MyDNN, self).__init__()
        self.hidden1 = Linear(100,100,act='relu')
        self.hidden2 = Linear(100,100,act='relu')
        self.hidden3 = Linear(100,100,act='relu')
        self.hidden4 = Linear(3*100*100,100,act='softmax')#输出层

    def forward(self, input):
        x = self.hidden1(input)#输入层
        x = self.hidden2(x)
        x = self.hidden3(x)
        x=fluid.layers.reshape(x,shape=[-1,3*100*100])
        y = self.hidden4(x)  #输出层
        return y
#分段运行
#%%

# 用动态图进行训练
with fluid.dygraph.guard():
    model = MyDNN()  # 模型实例化
    model.train()  # 训练模式
    opt = fluid.optimizer.SGDOptimizer(learning_rate=0.001,
                                       parameter_list=model.parameters())  # 优化器选用SGD随机梯度下降，学习率为0.001.

#学习率和迭代次数优化，优化器可以选择

    epochs_num = 10  # 迭代次数

    for pass_num in range(epochs_num):

        for batch_id, data in enumerate(train_reader()):

            images = np.array([x[0].reshape(3, 100, 100) for x in data], np.float32)

            labels = np.array([x[1] for x in data]).astype('int64')
            labels = labels[:, np.newaxis]
            # print(images.shape)
            #将lable和image转化为变量对象，以便投入模型
            image = fluid.dygraph.to_variable(images)
            label = fluid.dygraph.to_variable(labels)
            predict = model(image)  # 预测，即训练
            # print(predict)
            loss = fluid.layers.cross_entropy(predict, label)
            avg_loss = fluid.layers.mean(loss)  # 获取loss值

            acc = fluid.layers.accuracy(predict, label)  # 计算精度

            if batch_id != 0 and batch_id % 50 == 0:
                print(
                    "train_pass:{},batch_id:{},train_loss:{},train_acc:{}".format(pass_num, batch_id, avg_loss.numpy(),
                                                                                  acc.numpy()))
                 #打印训练集数据，不代表测试集数据

            avg_loss.backward() #反向传播算法，帮助反向计算梯度
            opt.minimize(avg_loss)  #调用定义的优化器对象的minimize()方法进行参数更新
            model.clear_gradients()  #每一轮参数更新完成后，调用clear_gradients()方法来重置梯度，以保证下一轮的正确性

    fluid.save_dygraph(model.state_dict(), 'MyDNN')  # 保存模型

#%%

# 模型校验
with fluid.dygraph.guard():
    accs = []
    model_dict, _ = fluid.load_dygraph('MyDNN')
    model = MyDNN()
    model.load_dict(model_dict)  # 加载模型参数
    model.eval()  # 训练模式
    for batch_id, data in enumerate(test_reader()):  # 测试集
        images = np.array([x[0].reshape(3, 100, 100) for x in data], np.float32)
        labels = np.array([x[1] for x in data]).astype('int64')
        labels = labels[:, np.newaxis]

        image = fluid.dygraph.to_variable(images)
        label = fluid.dygraph.to_variable(labels)

        predict = model(image)
        acc = fluid.layers.accuracy(predict, label)
        accs.append(acc.numpy()[0])
        avg_acc = np.mean(accs)
    print(avg_acc)#测试集 准确率

#%%

#读取预测图像，进行预测

def load_image(path):
    img = Image.open(path)
    img = img.resize((100, 100), Image.ANTIALIAS)
    img = np.array(img).astype('float32')
    img = img.transpose((2, 0, 1))
    img = img/255.0
    print(img.shape)
    return img

#构建预测动态图过程
with fluid.dygraph.guard():
    infer_path = '手势.JPG'
    model=MyDNN()#模型实例化
    model_dict,_=fluid.load_dygraph('MyDNN')
    model.load_dict(model_dict)#加载模型参数
    model.eval()#评估模式
    infer_img = load_image(infer_path)
    infer_img=np.array(infer_img).astype('float32')
    infer_img=infer_img[np.newaxis,:, : ,:]
    infer_img = fluid.dygraph.to_variable(infer_img)
    result=model(infer_img)
    print(np.argmax(result.numpy()))

img = Image.open('手势.JPG')
plt.imshow(img)   #根据数组绘制图像
plt.show()        #显示图像

# display(Image.open('手势.JPG'))

```
### 参考资料
1. 百度paddlepaddle官方开发文档<https://www.paddlepaddle.org.cn/documentation/docs/zh/beginners_guide/index_cn.html>
2. paddlepadddle零基础深度学习7日入门-CV疫情特辑学习笔记（三）DAY02 手势识别 <https://blog.csdn.net/claychenlei/article/details/105271658>
3. CSDN<https://blog.csdn.net/weixin_43599390/article/details/105451481>
4. 知乎<https://zhuanlan.zhihu.com/p/128989891>

