%p232task1
%混沌与分叉 利用迭代格式x(k+1)=λsin(pi*x(k))，做出相应的Feigenbaum图。
clc,clear
y=@(k,x)k*sin(pi*x);
x0=0.3;
for k=0.5:0.01:2
    for i=1:300
        x0=y(k,x0);
        if i>150
            plot(k,x0,'.r')
            hold on;
        end
   end
end
grid