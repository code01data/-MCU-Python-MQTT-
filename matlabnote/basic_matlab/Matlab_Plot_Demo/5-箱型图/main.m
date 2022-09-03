clc;clear
%% Import data
dataAll=importdata('data.xlsx');
dataY=dataAll.data(:,2:end);
%% Plot
figure
hold on
box on
set(gca,'LineWidth',1.3)
boxplot(dataY','labels',{'0','0.2','0.4','0.6','0.8','1.0'});
xlabel('Time [s]')
ylabel('Velocity [m/s]')
set(gca,'FontName','Times New Roman','FontSize',22)
set(gca,'XLim',[0.5,6.5]);
set(gca,'YLim',[0,10]);
%% Patch
h = findobj(gca,'Tag','Box');
colorList={[0 0 255]/255;[0 128 0]/255;[255 0 0]/255;[0 139 139]/255;[0 0 128]/255;[255 165 0]/255;[139 0 139]/255};
for j=1:length(h) 
    patch(get(h(j),'XData'),get(h(j),'YData'),colorList{j,1},'FaceAlpha',1);
end