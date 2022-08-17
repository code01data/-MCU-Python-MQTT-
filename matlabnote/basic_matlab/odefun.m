% 求解微分方程在[0,12]上面的解
function dy = odefun(t,y)
    dy = zeros(3,1); %eros(a,b)表示全为0的矩阵，a表示行，b表示列。
    dy(1) = y(2)*y(3);
    dy(2) = -y(1)*y(3);
    dy(3) = -0.51*y(1)*y(2);
end