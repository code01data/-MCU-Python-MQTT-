clear

format long

global a b c d

dt = 0.001;
tspan = (0:dt:50);
Y0 = [10 10 10 10];
for i=1:1:1001
    d = 0.08*(i-1);
    sol = ode45(@HyBaol,[tspan(1) tspan(end)],Y0);
    ss = deval(sol,tspan)';
    s = ss(20000:end,:);  
    aa =0;
    bb =0;
    cc =1;
    dd =0;
    p = -32;%平面方程aa*x+bb*y+cc*z+dd*u+p=0;
    
    
    func = ((aa*s(:,1))+(bb*s(:,2))+(cc*s(:,3))+(dd*s(:,4))+p) >0; %书上面的代码错误是aa 不是a
    func_n = (func(1:end-1)>0)&(xor(func(1:end-1),func(2:end)));
    m = find(func_n == 1);
    t_intsec = -(aa*s(m,1)+bb*s(m,2)+cc*s(m,3)+dd*s(m,4)+p)./(aa*(s(m+1,1)-s(m,1))+bb*(s(m+1,2)-s(m,2))+cc*(s(m+1,3)-s(m,3))+dd*(s(m+1,4)-s(m,4)));
    
    x_map = s(m,1)+(s(m+1,1)-s(m,1)).*t_intsec;
    y_map = s(m,2)+(s(m+1,2)-s(m,2)).*t_intsec;
    z_map = s(m,3)+(s(m+1,3)-s(m,3)).*t_intsec;
    w_map = s(m,4)+(s(m+1,4)-s(m,4)).*t_intsec;

    H = plot(d*ones(size(s(m,1))),x_map);
    set(H,'linestyle','none','marker','.','markersize',4)
    hold on
    drawnow
end
