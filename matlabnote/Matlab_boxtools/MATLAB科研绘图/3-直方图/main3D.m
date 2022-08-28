clc;clear
%% Import data
data3D=xlsread('data3D.xlsx');
%% Parameters
lineWidth=1;
fontSize=28;
fileName='histogram3D';
pictureSize=[200,200,900,750];
pictureResolution='-r300';
%% Plot
hist3(data3D,'Nbins',[9 9],'CDataMode','auto','FaceColor','interp')
box on
%% Seeting
set(gca,'LineWidth',lineWidth)
xlabel('Force [N]');
ylabel('Velocity [m/s]');
zlabel('Frequency');
set(gca,'FontSize',fontSize,'Fontname', 'Times New Roman');
set(gca,'XLim',[-3,3],'YLim',[-3,3],'ZLim',[0,8]);
set(gca,'xtick',[-3:1:3],'ytick',[-3:1:3],'ztick',[0:2:8]);
set(gcf,'Position',pictureSize)
print(fileName,'-dtiff',pictureResolution);