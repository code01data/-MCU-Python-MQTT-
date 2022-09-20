format long
global a b c

dt = 0.001;
tspan = (0:dt:50);
Y0 = [10 10 10];
for i = 1:1:1001;
    b = 0.015*(i-1);
    sol = ode45(@Baol1,[tspan(1) tspan(end)],Y0);
    ss = deval(sol,tspan)';
    s = ss(20000:end,:);
    %aa = 0 ;%
    aa = 1;
    bb = 0;
    %cc = 1; 
    % 
    cc = 0;

    p = -32;
    func = ((aa*s(:,1))+(bb*s(:,2))+(cc*s(:,3))+p) >0;
    func_n = (func(1:end-1)>0)&(xor(func(1:end-1),func(2:end)));
    m = find(func_n == 1);
    t_intsec = -(aa*s(m,1)+bb*s(m,2)+cc*s(m,3)+p)./(aa*(s(m+1,1)-s(m,1))+bb*(s(m+1,2)-s(m,2))+cc*(s(m+1,3)-s(m,3)));

    x_map = s(m,1)+(s(m+1,1)-s(m,1)).*t_intsec;
    y_map = s(m,2)+(s(m+1,2)-s(m,2)).*t_intsec;
    z_map = s(m,3)+(s(m+1,3)-s(m,3)).*t_intsec;

    H = plot(b*ones(size(s(m,1))),x_map);
    set(H,'linestyle','none','marker','.','markersize',1)
    hold on
    drawnow
end