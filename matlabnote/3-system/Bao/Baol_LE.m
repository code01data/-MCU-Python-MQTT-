function dX = Baol_LE(t,X)

global a b c

x = X(1); y=X(2);z=X(3);
Y = [ X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];

dX = zeros(9,1);
dX(1) = a*(x-y);
dX(2) = x*z-c*y;
dX(3) = x*x-b*z;


Jaco = [a -a 0;
        z -c x;
        2*x 0 -b];

dX(4:12) = Jaco*Y;
    
end