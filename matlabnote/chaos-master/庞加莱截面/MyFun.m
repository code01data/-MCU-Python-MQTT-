function f=MyFun(t,y)
    global a
    global b
    global c
    global d
    a=6;b=4;c=8;d=2;
    f=zeros(4,1);
    % f=zeros(3,1);
    f(1)=-a*y(1)+y(2)*y(3);
    f(2)=y(1)*y(3)-y(2)^3;
    f(3)=-b*y(1)*y(2)+c*y(3)+y(4);
    f(4)=y(2)-d*y(3);

end
