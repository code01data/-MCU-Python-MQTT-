clc;clear
data=importdata('data.xlsx');
zData=data(2:end,2:end);
[xData,yData] = meshgrid(1:1:5,1:1:5);
%% Plot
%surf(xData,yData,zData)

step=0.05;
[xi,yi]=meshgrid(1:step:5,1:step:5);
zi=interp2(xData,yData,zData,xi,yi,'cubic');
surf(xi,yi,zi)
shading interp
colorbar()
xlabel('x');ylabel('y');zlabel('z')
set(gca,'FontName','Times New Roman','FontSize',26)