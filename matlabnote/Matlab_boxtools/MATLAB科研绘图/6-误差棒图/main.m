clc;clear
%% Import data
% data-1
dataAll1=importdata('data1.xlsx');
dataX1=dataAll1.data(:,1);
dataY1=dataAll1.data(:,2:end);
dataMax1=max(dataY1,[],2);
dataMean1=mean(dataY1,2);
dataMin1=min(dataY1,[],2);
errorUp1=dataMax1-dataMean1;
errorDown1=dataMin1-dataMean1;
% data-2
dataAll2=importdata('data2.xlsx');
dataX2=dataAll2.data(:,1);
dataY2=dataAll2.data(:,2:end);
dataMax2=max(dataY2,[],2);
dataMean2=mean(dataY2,2);
dataMin2=min(dataY2,[],2);
errorUp2=dataMax2-dataMean2;
errorDown2=dataMin2-dataMean2;
%% Setting
lineWidth=1.5;
lineWidthBox=1.3;
markerSize=5;
fontSize=22;
xLim=[0,1];
yLim=[2,12];
color=[[0 139 139]/255;[0 0 128]/255];
pictureSize=[200,200,800,650];
pictureResolution='-r300';
fileName='errorbar';
%% Plot
figure
hold on
box on
set(gca,'LineWidth',lineWidthBox)
%data-1
errorbar(dataX1,dataMean1,errorUp1,errorDown1,'-o','Color',color(1,:),'LineWidth',lineWidth,'MarkerSize',markerSize, 'MarkerEdgeColor',color(1,:),'MarkerFaceColor',color(1,:))
%data-2
errorbar(dataX2,dataMean2,errorUp2,errorDown2,'-^','Color',color(2,:),'LineWidth',lineWidth,'MarkerSize',markerSize, 'MarkerEdgeColor',color(2,:),'MarkerFaceColor',color(2,:))
h=legend('Group A','Group B','location','northwest');
%set(h,'box','off')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
set(gca,'FontName','Times New Roman','FontSize',fontSize)
set(gca,'XLim',xLim);
set(gca,'YLim',yLim);
set(gcf,'Position',pictureSize)
print(fileName,'-dtiff',pictureResolution);