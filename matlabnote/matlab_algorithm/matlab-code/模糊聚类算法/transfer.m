function transfer(X)
% �˺���������ģ����������еĴ��ݷ���������
% �˺��������������ģ�����ƾ���X
Dimension=size(X);
n=Dimension(1);
m=Dimension(2);
% ��������������Ч��
if n~=m
    error('����ľ�������Ƿ���');
end
for i=1:(n-1)
    for j=(i+1):n
        if(X(i,j)~=X(j,i)|X(i,j)<0|X(i,j)>1)
            error('����ľ����������Գ��ԣ�����ģ�����ƾ���');
        end
    end 
end
for i=1:n
    if(X(i,i)~=1)
        error('����ľ�����������Է���');
    end
end
% ���ģ�����ƾ����еķ���ϵ������
numda(1)=1;
for i=1:(n-1)
    for j=(i+1):n
        flag=1;
        for k=1:length(numda)
            if X(i,j)==numda(k)
                flag=0;
                break;
            end
        end
        if flag==1
            numda(length(numda)+1)=X(i,j);
        end
    end
end
% ����������ڽ�����ϵ�������ɴ�С��������
t=1;
for i=1:length(numda)
    ordered_numda(t)=max(numda);
    t=t+1;
    index=find(numda==max(numda));
    numda(index)=[];
end
% ��ʼ�������
for i=1:n
    A(i)=i;
end
for i=1:length(ordered_numda)
    disp('������ϵ���ǣ�');
    disp(ordered_numda(i));
    aa=ordered_numda(i);
    AA=A;
    disp('����Ϊ��');
    loop1=1;
    loop2=1;
    while loop1
        if ~isempty(AA)
            xi=AA(1);
        end
        XX=[];
        Q=[];
        while loop2
            for j=1:n
                if(X(xi,j)>=aa)&isempty(intersect(XX,j))
                    XX=union(XX,j);
                    Q(length(Q)+1)=j;
                end
            end
            if isempty(Q)
                disp(XX);
                break;
            else
                xi=Q(1);
                Q(1)=[];
            end
        end
        AA=setdiff(AA,XX);
        if isempty(AA)
            break;
        end
    end
end