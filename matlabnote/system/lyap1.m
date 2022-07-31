format long

global a b c 
a =20; c=32;
for i= 1:1:501
    b = 0.03*(i-1);
    [T,Res] = lyapunov(3,@Baol_LE,@ode45,0,0.001,500,[10 10 10],0);
    %plot(T,Res);
Lyapunov1(i) = Res(end,1);
Lyapunov2(i) = Res(end,2);
Lyapunov3(i) = Res(end,3);
end

cc_val = 0.03*([1:1:501]-1)
plot(cc_val,Lyapunov1(:));hold on
plot(cc_val,Lyapunov2(:));hold on
plot(cc_val,Lyapunov3(:));hold on


title('随b变化的Lyapunov指数谱')