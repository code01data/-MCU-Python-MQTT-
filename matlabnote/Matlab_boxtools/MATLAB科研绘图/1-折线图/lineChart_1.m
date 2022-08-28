clc;clear
%% Import data
data=xlsread("data.xlsx");
%% Plot
figure
hold on
for i=1:6
    plot(data(:,1),data(:,i+1))
end
legend('Group A','Group B','Group C','Group D','Group E','Group F','Location', 'eastoutside')