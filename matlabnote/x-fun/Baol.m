function dy=Baol(t,y)
    dy=zeros(3,1); 
    global a b c
    a=20;c=32; % b=1.4; %System parameters
    dy(1) =a*y(1)-a*y(2); 
    dy(2) =y(1)*y(3)-c*y(2);
    dy(3) =y(1)*y(1)-b*y(3);
end
    
    
    
    