clear all;clc;
load 'tu.mat';  %奇数行为a，偶数行为b，如tu{1,1}为000a，tu{2,1}为000b

for i = 1:418
    t5{i,1} = double(tu{i,1}); %转化为double型  
end

cell=t5;

for i=1:418
%level=graythresh(cell{i,1});
cell{i,1}=im2bw(cell{i,1},0);  %图像二值化处理
end

for i=1:418
    for j=1:180
        ge=sum(cell{i,1}(j,:));
        if(ge>65)
            cell{i,1}(j,:)=ones(1,72);
        end
    end
end

for i=1:418
    hang1(i,1)=0;
    for j=1:180
        ge=sum(cell{i,1}(j,:));
        if(ge==72)
            hang1(i,1)=1+hang1(i,1);
        else
            break;
        end
    end
    hang2(i,1)=0;
    for j=1:180
        ge=sum(cell{i,1}(181-j,:));
        if(ge==72)
            hang2(i,1)=1+hang2(i,1);
        else
            break;
        end
    end
end
 
for i=1:418
    hang3(i,1)=0;
    for j=1:180
        ge=sum(cell{i,1}(j,:));
        if(ge<72)
            hang3(i,1)=1+hang3(i,1);
        else
            break;
        end
    end
    hang4(i,1)=0;
    for j=1:180
        ge=sum(cell{i,1}(181-j,:));
        if(ge<72)
            hang4(i,1)=1+hang4(i,1);
        else
            break;
        end
    end
end

k=0;
for i=1:418
    b=0;
    for j=1:18
        b=b+sum(cell{i,1}(:,j));
    end
    if(b==180*18)
        k=k+1;
        left(k)=i;     %每行第一个
    end
end

k=0;
for i=1:418
    b=0;
    for j=1:18
        b=b+sum(cell{i,1}(:,j+54));
    end
    if(b==180*18)
        k=k+1;
        right(k)=i;     %每行最后一个
    end
end


