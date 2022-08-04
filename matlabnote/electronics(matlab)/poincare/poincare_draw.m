% global delt r b; 
% delt=10;
% b=8/3;
% r=20
close all;
clear;
global a;
global b;
global c;
global d;
global kn;
global kp;
global shitf_n;
global shitf_p;

b=0.25;
a=0.3;
c=0.3;
d=0.05;
kn=3;
kp=3;
lya_pu=[];
tic
x0=0.1;y0=0.1;z0=0.1;
y0=[0.1 0.1 0.1];
tspan=0:(1*10^(-2)):200;
[t,x]=ODE45('Jerk_Multiscroll',tspan,y0);
% sim('lorenz_sim.mdl',1000)

data_x=x(10000:end,1);
data_y=x(10000:end,2);
data_z=x(10000:end,3);

figure
plot3(data_x,data_y,data_z);
xlabel('x')
ylabel('y')
zlabel('z')

x=[data_x,data_y,data_z];

z0=0; % 选择z0=0这个截面 
% z0=23.09;
j = 0;
X1=[];
X2=[];
for k = 1:length(x(:,3))-1
d1 = x(k,3)-z0;
d2 = x(k+1,3)-z0;

if abs(d1)<1e-8
j = j+1;
X1(j) = x(k,1);
X2(j) = x(k,2);
continue;
end

if sign(d1)*sign(d2)<0
j = j+1;
Q=polyfit([x(k,3),x(k+1,3)],[x(k,1),x(k+1,1)],1); 
X1(j)=polyval(Q,z0); 
Q=polyfit([x(k,3),x(k+1,3)],[x(k,2),x(k+1,2)],1); 
X2(j)=polyval(Q,z0);
end
end
figure
plot(X1,X2,'.'); 
xlabel('x','fontsize',2); 
ylabel('y','fontsize',2);
