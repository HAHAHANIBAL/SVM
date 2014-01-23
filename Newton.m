function [ Z ] = Newton( Z,lambda,t,x,y )
%Newton
flag=1;

while flag
[H,G]=costFcn(lambda,t,Z,x,y);
error=G'*inv(H)*G;
delta_Z=-inv(H)*G;

if abs((error/2))<0.000001
    flag=0;
else
    Z=Backline(Z,delta_Z,x,y);
end


end



end

