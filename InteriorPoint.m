function [ W,C,Ksi ] = InteriorPoint( Z_initial,x,y,lambda )
%initial t
t=10;
L=length(x(:,1));

%Normalize
x=x/20;

Z=Z_initial;
while t<1000000
Z=Newton(Z,lambda,t,x,y);
t=t*15;
end

W=Z(1:L,1);
C=Z(L+1,1);
Ksi=Z(L+2:end,1);


end

