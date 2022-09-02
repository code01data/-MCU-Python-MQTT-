x = load('1.txt')
x_sort = sort(x)

%{
dlmwrite(filename,M);      %注锟斤拷锟斤拷锟斤拷锟揭�锟斤拷锟斤拷锟斤拷
dlmwrite(filename,M,'-append');       %锟斤拷锟侥硷拷末尾追锟斤拷 
dlmwrite(filename,M,delimiter);锟斤拷锟斤拷锟斤拷锟斤拷%锟斤拷锟斤拷delimiter锟街革拷锟斤拷默锟较分革拷锟斤拷为锟街号ｏ拷
dlmwrite(__,'newline','pc')           %锟斤拷txt锟侥硷拷锟斤拷实锟街伙拷锟斤拷   
%}

dlmwrite('2.txt',x_sort)%  把变量写入到txt文件