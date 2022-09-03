clc;clear
%% Import data
data2D=xlsread('data2D.xlsx');
%% Parameters
lineWidth=1;
fontSize=28;
fileName='histogram2D';
pictureSize=[200,200,800,650];
pictureResolution='-r300';
%% Plot
histogram(data2D,10,'FaceColor',[0 0.5 0.5],'LineWidth',lineWidth)
box on
%% Seeting
set(gca,'LineWidth',lineWidth)
xlabel('Force [N]');
ylabel('Frequency');
set(gca,'FontSize',fontSize,'Fontname', 'Times New Roman');
set(gca,'XLim',[-3,3],'YLim',[0,25]);
set(gcf,'Position',pictureSize)
print(fileName,'-dtiff',pictureResolution);



