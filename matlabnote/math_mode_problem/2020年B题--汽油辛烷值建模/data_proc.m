clear
close all
clc

%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: 附件一：325个样本数据剔除异常指标_procced_20200918.xlsx
%    工作表: Sheet1
%
% 由 MATLAB 于 2020-09-18 20:09:14 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 354);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "C5:MR329";

% 指定列名称和类型
opts.VariableNames = ["x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "y", "x9", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28", "x29", "x30", "x31", "x32", "x33", "x34", "x35", "x36", "x37", "x38", "x39", "x40", "x41", "x42", "x43", "x44", "x45", "x46", "x47", "x48", "x49", "x50", "x51", "x52", "x53", "x54", "x55", "x56", "x57", "x58", "x59", "x60", "x61", "x62", "x63", "x64", "x65", "x66", "x67", "x68", "x69", "x70", "x71", "x72", "x73", "x74", "x75", "x76", "x77", "x78", "x79", "x80", "x81", "x82", "x83", "x84", "x85", "x86", "x87", "x88", "x89", "x90", "x91", "x92", "x93", "x94", "x95", "x96", "x97", "x98", "x99", "x100", "x101", "x102", "x103", "x104", "x105", "x106", "x107", "x108", "x109", "x110", "x111", "x112", "x113", "x114", "x115", "x116", "x117", "x118", "x119", "x120", "x121", "x122", "x123", "x124", "x125", "x126", "x127", "x128", "x129", "x130", "x131", "x132", "x133", "x134", "x135", "x136", "x137", "x138", "x139", "x140", "x141", "x142", "x143", "x144", "x145", "x146", "x147", "x148", "x149", "x150", "x151", "x152", "x153", "x154", "x155", "x156", "x157", "x158", "x159", "x160", "x161", "x162", "x163", "x164", "x165", "x166", "x167", "x168", "x169", "x170", "x171", "x172", "x173", "x174", "x175", "x176", "x177", "x178", "x179", "x180", "x181", "x182", "x183", "x184", "x185", "x186", "x187", "x188", "x189", "x190", "x191", "x192", "x193", "x194", "x195", "x196", "x197", "x198", "x199", "x200", "x201", "x202", "x203", "x204", "x205", "x206", "x207", "x208", "x209", "x210", "x211", "x212", "x213", "x214", "x215", "x216", "x217", "x218", "x219", "x220", "x221", "x222", "x223", "x224", "x225", "x226", "x227", "x228", "x229", "x230", "x231", "x232", "x233", "x234", "x235", "x236", "x237", "x238", "x239", "x240", "x241", "x242", "x243", "x244", "x245", "x246", "x247", "x248", "x249", "x250", "x251", "x252", "x253", "x254", "x255", "x256", "x257", "x258", "x259", "x260", "x261", "x262", "x263", "x264", "x265", "x266", "x267", "x268", "x269", "x270", "x271", "x272", "x273", "x274", "x275", "x276", "x277", "x278", "x279", "x280", "x281", "x282", "x283", "x284", "x285", "x286", "x287", "x288", "x289", "x290", "x291", "x292", "x293", "x294", "x295", "x296", "x297", "x298", "x299", "x300", "x301", "x302", "x303", "x304", "x305", "x306", "x307", "x308", "x309", "x310", "x311", "x312", "x313", "x314", "x315", "x316", "x317", "x318", "x319", "x320", "x321", "x322", "x323", "x324", "x325", "x326", "x327", "x328", "x329", "x330", "x331", "x332", "x333", "x334", "x335", "x336", "x337", "x338", "x339", "x340", "x341", "x342", "x343", "x344", "x345", "x346", "x347", "x348", "x349", "x350", "x351", "x352", "x353"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 导入数据
dataabstract = readtable("附件一：325个样本数据剔除异常指标_procced_20200918.xlsx", opts, "UseExcel", false);


%% 清除临时变量
clear opts

y = dataabstract.y;
x = table2array(dataabstract(:,[1:8,10:end]));
var_nums = size(x,2);

corr_coef = zeros(var_nums, 3);
corr_coef(:,1) = (1:var_nums)';
pval = 0 * corr_coef;

%% 计算 y(x0), x1, x2, ...., x353 之间的线性相关系数（找自变量的共线性）
var_nums_include_y = var_nums + 1;
[Rho,Pval] = corr([y x]);
corr_coef_all = zeros(var_nums_include_y, 3*var_nums_include_y);
var_id_include_y = (0:var_nums)';
corr_coef_max_unsorted = zeros(var_nums_include_y,5);
for i=1:var_nums+1
    column_id_begin = (i-1) * 3 + 1;
    column_id_end = i * 3;
    column_id_range = (column_id_begin : column_id_end);
    
    var_xx_id_include_y = (i-1)*1000 + 9000000 + var_id_include_y;
    corr_abs_coef_var_xx_include_y_unsorted = [var_id_include_y+1 abs(Rho(:,i)) Pval(:,i)];
    corr_abs_coef_var_xx_include_y_sorted = sortrows(corr_abs_coef_var_xx_include_y_unsorted, -2);
    sorted_id = corr_abs_coef_var_xx_include_y_sorted(:,1);
    
    corr_coef_var_xx_include_y_unsorted = [var_xx_id_include_y Rho(:,i) Pval(:,i)]; 
    corr_coef_var_xx_include_y_sorted = corr_coef_var_xx_include_y_unsorted(sorted_id,:);
    
    corr_coef_all(:, column_id_range) = corr_coef_var_xx_include_y_sorted;
    
    xx_id_all = corr_coef_var_xx_include_y_sorted(2,1);
    xx_id(1) = round((xx_id_all-9000000)/1000);
    xx_id(2) = xx_id_all-9000000 - xx_id(1)*1000; 
    
    corr_coef_max_unsorted(i,:) = [corr_coef_var_xx_include_y_sorted(2,:) xx_id];
end
corr_coef_max_abs_unsorted = [var_id_include_y+1 abs(corr_coef_max_unsorted(:,2))];
corr_coef_max_abs_sorted = sortrows(corr_coef_max_abs_unsorted, -2); % 按相关性降序排列
corr_coef_max_sorted = corr_coef_max_unsorted(corr_coef_max_abs_sorted(:,1),:);

%% 计算y与x(1,2,...,353)的线性相关性
for i=1:var_nums
    disp(num2str(i));
    
    xy_unsorted = [x(:,i) y];
    [rho,pval] = corr(xy_unsorted);
    corr_coef(i,2) = rho(2);
    corr_coef(i,3) = pval(2);
    xy_sorted = sortrows(xy_unsorted,1);
    
    str_x = ['x' num2str(i) ' corr ' num2str(corr_coef(i,2)) ' pval ' num2str(corr_coef(i,3))];
    
    set(0,'DefaultFigureVisible', 'off');
    figure;
    plot(xy_sorted(:,1), xy_sorted(:,2), '-k.');
    title(str_x);
    
    saveas(gcf, ['img\' str_x '.png']);
    close;
    
end
