clc;clear
%% Import data
data=xlsread('data.xlsx');
%% Parameter setting
myFileName='curveFit.tif';
xLabel='PI';
yLabel='Frequency';
xLim=[0,10];
yLim=[0,40];
fontSize=30;
lineWidth=2;
lineWidthBox=1.35;
pictureSize=[500 300 1000 700];
pictureResolution='-r300';
color=[[0 139 139]/255;[139 0 0]/255];
%% Fit curve
[fitData,gof,fitCoefficient] = createFit(data);
rSquare=gof.rsquare;
%% Plot
figure
hold on
box on
set(gca,'LineWidth',lineWidthBox)
scatter(data(:,1),data(:,2),70,color(1,:),'o','filled');
h = plot(fitData);
set(h,'Color',color(2,:),'LineWidth',lineWidth);
legend('Raw data','Fitted curve','location','south')
legend('boxoff')
set(gca,'XLim',xLim);
set(gca,'YLim',yLim);
xlabel(xLabel)
ylabel(yLabel)
set(gca,'FontName','Times New Roman','FontSize',fontSize)
set(gcf,'Position',pictureSize)
print('-djpeg',myFileName,pictureResolution);
