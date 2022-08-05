# matlab概念

### 知识点1 标准差 方差
![标准差.png](https://img1.imgtp.com/2022/08/05/hnKgo6Zr.png)
```matlab
%标准差std std(A,falg,dim) 默认flag=0,dim=1
std_B = std(mean_X,0,1) 
std_C = std(mean_A,0,1)   
std_D = std(mean_A,0,2)  
%方差var = std^2
var_B = var(mean_X,0,1)  
var_C = var(mean_A,0,1)  
var_D = var(mean_A,0,2) 
```


### 知识点2 累加和  累加积
![累加.png](https://img1.imgtp.com/2022/08/05/fbJ6NFkc.png)
```matlab
%累加和
% cumsum(mean_X) 返回向量的累加和向量
% cumsum(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,1))返回一个矩阵，其中第i列是第i列的累加和向量 (返回每列的累加和向量)
% cumsum(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加和向量 (返回每行的累加和向量)
%累加积
% cumprod(mean_X) 返回向量的累加积向量
% cumprod(mean_A) 返回一个矩阵，其中第i个元素是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,1))返回一个矩阵，其中第i列是第i列的累加积向量 (返回每列的累加积向量)
% cumprod(mean_A,2) 返回一个矩阵，其中第i行是第i行的累加积向量 (返回每行的累加积向量)
cumsum_B = cumsum(mean_X) 
cumsum_C = cumsum(mean_A)   
cumsum_D = cumsum(mean_A,2)  
cumprod_B = cumprod(mean_X)  
cumprod_C = cumprod(mean_A)  
cumprod_D = cumprod(mean_A,2) 

```
### 知识点3 相关系数
![相关系数.png](https://img1.imgtp.com/2022/08/05/fuTpqXHt.png)