function [MINL,MINZ,RESULT,best_so_far]=Tabusearch(CS,MS,Z,NT,TL)
hwait = waitbar(0,'���ڳ�ʼ��>>>>');
pause(1);
%��Zת����q�����ѵ��λ��ת���ɵ�������Ȩֵ
q=[];
for ii=1:size(Z,2)
    q=[q;CS(Z(1,ii),:)];
end
%��ʼ�����ɱ�TA
TA=zeros(1,size(q,1));
TA(TA==0)=inf;
%��ʼ��ָ��ptr
ptr=1;
waitbar(1/100,hwait,'��ʼ����>>>>');
[bestF]=findL(q,MS);
result(ptr)=bestF;
%��ʼ����
while ptr<NT
    %����neighbor�����������
    %��ͨ��findL���������������д���L(i)
    [NEIBR]=neighbor(Z,CS);
    for i=1:size(NEIBR,3)
        Q=NEIBR(:,:,i);
        L(i)=findL(Q,MS);
    end
    %��L(i)���ҳ���С����m������������TI��TI��Ӧ�䶯�ĵ�
    m=min(L);
    [x,TI]=find(L==m);
    %if��else֮���ʾ����׼������
    if m<bestF
        bestF=m;
        sit=TI;
        TA=TA-1;
        TA(TA==0)=inf;
        TA(1,TI)=TL;        
    else%else֮���if��ʾTIδ�ڽ��ɱ��б��
        if TA(1,TI)==inf        
            bestF=m;
            TA=TA-1;
            TA(TA==0)=inf;
            TA(1,TI)=TL;
            sit=TI;
        else%else֮���ʾTI�ڽ��ɱ����б�ǣ�m������
            %ת����û�б���ǵ����ŵ�
            [x,ti]=find(TA==inf);
            %���tiΪ�գ��������������ǣ�ִֻ�н��ɱ�-1
            if  isempty(ti)
                TA=TA-1;
                TA(TA==0)=inf;
            else
                %���ti��Ϊ�գ����ҳ�δ���������е���С���۽�
                for j=1:size(ti)
                    mimi(j)=L(ti(j));
                end
                bestF=min(mimi);
                [x,t]=find(L==bestF);
                TA=TA-1;    
                TA(TA==0)=inf;
                TA(1,t)=TL;
                sit=t;
            end
        end
    end
    %qת����Z
    q=NEIBR(:,:,sit);
    for k=1:size(q,1)
        Z(k)=findrow(CS(:,1:2),q(k,1:2));
    end
    if ptr>0.5*NT
        mi=min(result);
        if mi==bestF
            MINZ=Z;
        end
    end
    %��¼��ptr������ʱ�ĵ�ǰ��С����
    best_so_far(ptr)=min(result);
    ptr=ptr+1;
    %��¼��ptr������ʱ��Ĵ���ֵ
    result(ptr)=bestF;
    str=['�������' num2str(((ptr-1)/NT)*100) '%...'];
    waitbar(ptr/NT,hwait,str);
end
best_so_far(ptr)=min(result);
RESULT=result;
MINL=min(result);
waitbar(99/100,hwait,'���ڻ�ͼ>>>>');
pause(1);
waitbar(100/100,hwait,'��ɣ���');
end


