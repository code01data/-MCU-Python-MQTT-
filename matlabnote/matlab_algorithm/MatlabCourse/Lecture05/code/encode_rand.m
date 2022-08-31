function [Coded_message,lower_limit,upper_limit] = encode_rand(original_message,coding_integer)
    % �ó�����л�������
    % ���������original_message����ԭ�ģ�coding_integer�����������ܵ����������������
    %����ֵ��Coded_message��ʾ���ܵ����ģ�lower_limit��upper_limit��ʾ��ֵ������

    % �ַ�תΪ����
    associated_array 	= double(original_message);
    %����pi��������
    new_array        	= associated_array.^(pi);
    %����С���ֵ
    min_new_array    	= min(min(new_array));
    max_new_array	= max(max(new_array));
    %�����������޺Ͳ�ֵ
    lower_limit      	= round(min_new_array);
    upper_limit      	= round(max_new_array);
    difference        	= upper_limit - lower_limit;
    %ʹ����������������������
    rng(coding_integer)
    random_numbers	= lower_limit + difference*rand(size(original_message));
    %��������
    converted_array  	= new_array + random_numbers;
    %��ü�������
    Coded_message  	= converted_array';
end