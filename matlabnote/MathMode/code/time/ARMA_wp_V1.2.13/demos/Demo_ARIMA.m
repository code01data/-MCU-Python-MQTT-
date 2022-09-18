% 使用Fun_ARIMA_Forecast函数实现预测的公开版代码
% Fun_ARIMA_Forecast函数的测试文件
% 本代码地址及代码说明：http://www.khscience.cn/docs/index.php/2020/04/19/123/
%% 
close all
clear all
addpath ../funs %将funs文件夹添加进路径，如果已经执行install_funs，则该行代码可以删除
%% 1.导入数据
% 如果要分析自己的数据，在此处替换data数据
% 数据导入教程可参考：http://www.khscience.cn/docs/index.php/2020/05/17/loaddata/
load Data_EquityIdx   %纳斯达克综合指数
data = DataTable.NASDAQ(1:100); %如果要替换数据，将此处data替换即可。
%% 2.调用函数实现预测
step = 9; %预测步数
p_max = 3; %p上限
q_max = 3; %q上限
figflag = 'on'; %画图标志位，'on'为画图，'off'为不画
[forData1,lower1,upper1,aicorbic,res] = Fun_ARIMA_Forecast(data,step,p_max,q_max,figflag,'aic+bic'); %该函数的参数信息请在函数文件内查看
% 使用ARIMA进行预测的函数（使用n阶差分、不使用对数），可以直接调用，差分阶数自动确定。
% 输入：
% data为待预测数据，一维数据，最小11个数据。但是数据长度处于11~15时依旧可能出现报错的情况。
% step为拟预测步数
% max_ar 为最大p值
% max_ma 为最大q值
% figflag 为画图标志位，'on'为画图，'off'为不画
% criterion 为定阶准则，'aic'/'bic'/'aic+bic'三种选择，此变量可以不输入或者输入为[]，此时将使用默认'aic+bic'准则
% 输出：
% forData为预测结果，其长度等于step
% lower为预测结果的95%置信下限值
% upper为预测结果的95%置信上限值
% aicorbic为aic或bic或aic+bic准则在所有pq组合下的值，返回值为矩阵，
% 例如当设置max_ar= 1，max_ma=2时
% 则返回矩阵为： a b c
%               d e f
% a代表 p=0,q=0时的aic+bic的值，b代表p=0,q=1时的值，d代表p=1,q=0时的值，以此类推
% 矩阵中可能会存在NaN值，比如a必定为NaN，当p、q的阶数较高时，也会因为软件无法正确估计参数而产生NaN值
% res：拟合残差值

%% 关于完整版代码：
% 公开版代码的函数文件为p文件，可以被调用，但无法查看代码。
% 完整版代码中全部为m文件，m文件可以查看源码并自由修改，画图无水印
% 此外：
% 1.公开版代码仅可对长度100以内的数据建模；完整版无长度限制。
% 2.公开版代码预测步数限制为3~8步；完整版无限制。
% 3.公开版代码p、q上限设置受限（不能大于3）；完整版代码无限制。
% 4.公开版代码仅仅可使用“aic+bic”准则；完整版代码无限制，可以使用“aic”、“bic”、“aic+bic”三种。

% 如果需要封装好的函数的完整版源码，可在下述链接获取：
% http://www.khscience.cn/docs/index.php/2020/04/19/123/
% 编程不易，感谢支持~

%% 完整版代码重要更新：
% 20220123 加入了多步预测的训练集/测试集划分及预测对比（Fun_ARIMA_Forecast_MulComp函数和Demo_ARMA_MulComp文件）
% 20211114  改进一：现在可以指定定阶准则，'aic'/'bic'/'aic+bic'三种选择选其一；改进二：现在可以导出残差res值了（可以用于计算拟合结果）。
% 20210408 支持MATLAB2021
% 20210324 现在可以导出各p、q组合下对应的aic+bic值
% 20210206 加入了单步预测的封装函数Fun_ARIMA_Forecast_Onestep及其相关测试程序
% 20200805 解决了小概率出现的频繁弹窗报错的bug
% 20200526 优化了pq阶数选定算法
% 20200430 兼容了MATLAB2016
% 20200419 加入了工具箱快速安装/卸载函数，完善了函数参数说明
% 20200325 增加了在已经估计pq阶数后，再进行模型估计是无法正常估计的警告
% 20200313 修改了阶数选择的函数，在定阶时不会再因为阶数高而报错
% 20200309 加入了寿命预测相关函数和脚本
% 20200308 加入了单步预测的程序，修改了部分程序bug
% 20190920 更新了关于需要字符串标量或字符串向量形式的参数名称的问题说明
% 20190919 使用MATLAB内置函数作为定阶依据
% 20190130 创建ARMA时间序列的初始版本代码