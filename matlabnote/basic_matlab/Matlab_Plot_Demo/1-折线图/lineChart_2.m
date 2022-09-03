clc
clear
%% Import data
data=xlsread("data.xlsx");
%% Parameter setting
fontSize=28;
lineWidthBox=1.5;
lineWidth=2.5;
symbol=['o','s','d','^','v','>','<'];
markerSize=7;
pictureSize=[200,200,950,650];
fileName="figure2.tif";
pictureResolution='-r800';
color=[[0 0 139]/255;[0 139 139]/255;[105 105 105]/255;[192 0 0]/255;[255 140 0]/255;[0 191 255]/255];
coordinateRange=[[0 50];[0 4]];
xLabel='Time [s]';  
yLabel='Velocity [m/s]';
%% Plot
figure
hold on
box on
set(gca,'LineWidth',lineWidthBox)
for i=1:6
    plot(data(:,1),data(:,i+1),'.-','Color',color(i,:),'LineWidth',lineWidth,'Marker',symbol(1,i),'MarkerSize',markerSize,'MarkerFaceColor',color(i,:))
end
legend('Group A','Group B','Group C','Group D','Group E','Group F','Location', 'eastoutside')
legend('boxoff')
set(gca,'XLim',coordinateRange(1,:),'YLim',coordinateRange(2,:));
xlabel(xLabel)
ylabel(yLabel)
set(gca,'FontName','Times New Roman','FontSize',fontSize)
%% Output
set(gcf,'Position',pictureSize)
print('-djpeg',fileName,pictureResolution);