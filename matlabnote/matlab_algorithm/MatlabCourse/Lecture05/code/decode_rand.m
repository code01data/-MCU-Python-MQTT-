function message=decode_rand(coded_msg,coding_num,lower_limit,upper_limit)
    % �ó�����н��ܲ���
    % ���������coded_msg��ʾ�Ѽ��ܵ����ģ�coding_num��ʾ�����������ʹ�õ����ӣ�lower_limit��upper_limit��ʾ��ֵ������
    %����ֵ�ǽ��ܵ�����

    converted_array=coded_msg';
    difference = upper_limit - lower_limit;
    rng(coding_num);
    rand_num = lower_limit + difference*rand(size(coded_msg'));
    new_array=converted_array-rand_num;
    
    associated_array=new_array.^(1/pi);
    associated_array=round(associated_array);
    message=char(associated_array);
end