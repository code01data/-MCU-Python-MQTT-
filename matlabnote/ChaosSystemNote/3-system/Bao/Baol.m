function dy=Baol(t,y)
dy=zeros (3,1); 
%a=20;b=4; c=32; %System parameters
a=20;b=1.4; c=32; %System parameters
%a=20;b=8; c=32; %System parameters
%a=20;b=8.9; c=32; %System parameters
%a=20;b=0.9; c=32; %System parameters
dy(1) =a*(y(1)-y(2)); 
dy(2) =y(1)*y(3)-c*y(2);
dy(3) =y(1)*y(1)-b*y(3);
end



