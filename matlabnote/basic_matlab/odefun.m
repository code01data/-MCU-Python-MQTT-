% ���΢�ַ�����[0,12]����Ľ�
function dy = odefun(t,y)
    dy = zeros(3,1); %eros(a,b)��ʾȫΪ0�ľ���a��ʾ�У�b��ʾ�С�
    dy(1) = y(2)*y(3);
    dy(2) = -y(1)*y(3);
    dy(3) = -0.51*y(1)*y(2);
end