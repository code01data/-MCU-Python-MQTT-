% clear;
% close all;
% format long
% global a;
% global b;
% a=1;
% c=5;
% b=0.25;
% d=0;
% i=0;
% for x=-15:0.01:15
%  i=i+1;   
% if x>10
%     ffx(i)=(b*pi/2*a)*(x-2*a*c);
% elseif x<-10
%     ffx(i)=(b*pi/2*a)*(x+2*a*c);  
% else
%    ffx(i)=-b*sin(pi*x/(2*a)+d); 
% end      
% end
% x=-15:0.01:15;
% plot(x,ffx,'black');
% xlabel('x');
% ylabel('h(x)');

clear;
close all;
format long
global a;
global b;
a=10.814;
b=14;
%======================================
a2=1.3;
b2=0.11;
c2=3; %ÎÐ¾í¸öÊýn=c2+1
d2=0;
y=-10:0.01:10;
Gx=(b2*pi)*(y-2*a2*c2)/(2*a2);
if y>2*a2*c2
    Gx=(b2*pi)*(y-2*a2*c2)/(2*a2);
elseif y<-(2*a2*c2)
     Gx=(b2*pi)*(y+2*a2*c2)/(2*a2);
 else
     Gx=-b2*sin(pi*y/(2*a2)+d2);
else
    Gx=0;
 end   
  plot(y,Gx);