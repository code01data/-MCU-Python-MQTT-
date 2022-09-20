format long

dt = 0.001;
tspan = (0:dt:1000);
Y0 = [10 10 10 10];

sol = ode45(@HyBaol,[tspan(1) tspan(end)],Y0);
ss = deval(sol,tspan)';
s = ss(10000:end,:);

%%画四维系统的庞加莱映射，可延伸到五维系统甚至高维系统
%%设有两点（x0，y0，z0，u0），（xl，yl，zl，ul），则有方向向量（al，b1，cl，dl）
%%al=x1-x0；bl=y1-y0；cl=21-z0；dl=ul-u0；此两点确定的直线可以表示为
%%参数形式：x=x0+al*t；y=y0+bl*t；z=20+cl*t；u=u0+dl*t；
%%将此点代入-个平面方程aa*x+bb*y+cc*z+dd*u+p=0;
%%求得交点 t=-（aa*x0+bb*y0+Cc*z0+dd*u0+p）/（aa*（x1-x0）+bb*（yl-y0）+cc*（21-20）+dd*（ul-u0））
%%title('poincare映射 x=0截面')
aa= 1;
bb =0;
cc =0;
dd =0;
p = 0;%平面方程aa*x+bb*y+cc*z+dd*u+p=0;


func = ((aa*s(:,1))+(bb*s(:,2))+(cc*s(:,3))+(dd*s(:,4))+p) >0; %书上面的代码错误是aa 不是a
func_n = (func(1:end-1)>0)&(xor(func(1:end-1),func(2:end)));
m = find(func_n == 1);
t_intsec = -(aa*s(m,1)+bb*s(m,2)+cc*s(m,3)+dd*s(m,4)+p)./(aa*(s(m+1,1)-s(m,1))+bb*(s(m+1,2)-s(m,2))+cc*(s(m+1,3)-s(m,3))+dd*(s(m+1,4)-s(m,4)));

x_map = s(m,1)+(s(m+1,1)-s(m,1)).*t_intsec;
y_map = s(m,2)+(s(m+1,2)-s(m,2)).*t_intsec;
z_map = s(m,3)+(s(m+1,3)-s(m,3)).*t_intsec;
w_map = s(m,4)+(s(m+1,4)-s(m,4)).*t_intsec;
H = plot(y_map,z_map);
set(H,'linestyle','none','marker','.','markersize',5)
hold on
title('poincare映射 x=0截面')
drawnow