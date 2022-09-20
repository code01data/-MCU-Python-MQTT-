function [Texp,Lexp]=lyapunov(n,rhs_ext_fcn,fcn_integrator,tstart,stept,tend,ystart,ioutp)
    %% ��΢�ַ���ϵͳ��Lyapunovָ������
    %% n=number of nonlinear odes n�Ƿ����ԵĽ���
    %% n2=n*(n+1)=total number of odes�����������Ӧ����������������Ľ���
    n1=n; n2=n1*(n1+1);
    %% Number of steps  round������������㷨��tend��tstart��stept�Ǹ��˵Ķ���
    nit = round((tend-tstart)/stept);
    %% Memory allocation �ڴ���䣬��y�����˶�һ��ĵط��������������cum����ͽ���һ���ĵط�
    y=zeros(n2,1); cum=zeros(n1,1); y0=y;%�������y��y0��ʵ���ģ��ǱȽϸ߽׵Ķ�������Ϊn2�ʹ�����Ƚϸ߽׵Ķ���
    gsc=cum; znorm=cum;
    %% Initial values�����ֵ�������еĳ�ֵ�����һ�ж�����y�ĵ�һ�У�������Ϊһ��ʱ��y��4��=1=y��8��=y��10��
    y(1:n)=ystart(:);
    for i=1:n1
        y((n1+1)*i)=1.0;
    end;
    t=tstart;%��t����һ����ʼֵ
    %% Main loop  ��ʱ��Ĵ��������iITERLYAP
    for ITERLYAP=1:nit
    %% Solution of extended ode system
        [T,Y] = feval(fcn_integrator,rhs_ext_fcn,[t t+stept],y);%��һ���Ǻ���ʹ�õ��㷨
        %�ڶ����Ǻ���
        %��������ʱ������
        %���ĸ���y��ֵ
        %֮��ͼ������һ��ʱ��ε�T,Y�Ľ����������Ӧ�ú�΢����ʽ�йأ�������LE�����
        t=t+stept;%t�ĳ�ʼֵ�Ӳ���
        y=Y(size(Y,1),:);%��y���¶���ΪY,size�Ƿ���Y�ĵ�һ�еĴ�С,
        %�ܵ���˵���ǽ�Y�����һ�и���y
        for i=1:n1%���ڽ���Ϊn1�Ķ���
            for j=1:n1%����һ��
                y0(n1*i+j)=y(n1*j+i);%��y��n1*n1����ֵ��2��n1*n1+1)����y0,ò���ǵߵ���һ��˳��
            end;
        end;
        %%  znorm��һ��n1��1�е������
        znorm(1)=0.0;%����znorm1Ϊ0��֮��znorm1����Ϊy0��ƽ��������˵���Ӧ����΢�ַ��̵ľ���ֵ��
        for j=1:n1
           znorm(1)=znorm(1)+y0(n1*j+1)^2;
        end;
        znorm(1)=sqrt(znorm(1));%ƽ��֮���ڽ��п����ǽ��п����Ĳ���
        for j=1:n1
           y0(n1*j+1)=y0(n1*j+1)/znorm(1);%ò�����ڽ��й�һ��
        end;
        for j=2:n1
            for k=1:(j-1)
                gsc(k)=0.0;
                for l=1:n1
                    gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k);
                end;
            end;
            for k=1:n1
                for l=1:(j-1)
                    y0(n1*k+j)=y0(n1*k+j)-gsc(l)*y0(n1*k+l);
                end;
            end;
            znorm(j)=0.0;
            for k=1:n1
                znorm(j)=znorm(j)+y0(n1*k+j)^2;
            end;
            znorm(j)=sqrt(znorm(j));
            for k=1:n1
                y0(n1*k+j)=y0(n1*k+j)/znorm(j);
            end;
        end;
        %% update running vector magnitudes
        for k=1:n1
           cum(k)=cum(k)+log(znorm(k));%������log�������ǲ���ģ�������һ���
        end;
        %% normalize exponent
        for k=1:n1
        lp(k)=cum(k)/(t-tstart);%�����Ӧ����cum������ֵ
        end;
        %% Output modification
        if ITERLYAP==1
            Lexp=lp;
            Texp=t;
        else
            Lexp=[Lexp; lp];
            Texp=[Texp; t];
        end;
        if (mod(ITERLYAP,ioutp)==0)
            fprintf('t=%6.4f',t);
            for k=1:n1
                fprintf(' %10.6f',lp(k));
            end;
            fprintf('\n');
        end;
        for i=1:n1
            for j=1:n1
                y(n1*j+i)=y0(n1*i+j);
            end;
        end;
    end;
end