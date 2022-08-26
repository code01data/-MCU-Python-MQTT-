format long

global a b c d
    a =20; c=32;b =4;d=4;
    [T,Res] = lyapunov(4,@HyBaol_LE,@ode45,0,0.01,10,[10 10 10 10],0);
plot(T,Res);
title('d=4时的Lyapunov指数');