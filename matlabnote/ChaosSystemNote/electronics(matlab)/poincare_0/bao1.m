%====包伯成三维连续混沌系统======
function dy=bao1(t,y)
dy=zeros(3,1);
%=====系统参数=======
global a;
global b;
global c;

a=20;% a=20;
b=0.1;% b=4;
c=32;% c=32; 
dy(1)=a*(y(1)-y(2));
dy(2)=y(1)*y(3)-c*y(2);
dy(3)=y(1)*y(1)-b*y(3);
end