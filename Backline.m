function [ Z ] = Backline( Z,delta_Z,x,y )
%calculate backline search
flag=1;
s=1;
Z_backup=Z;
N=length(x(:,1));

while flag
    Z=Z_backup;
    Z=Z+s*delta_Z;
    W_new=Z(1:N,1);
    C_new=Z(N+1,1);
    Ksi_new=Z(N+2:end,1);
    if min(Ksi_new)>=0 && min(W_new'*x.*y+C_new*y+Ksi_new'-1)>=0
        flag=0;
    end
    s=0.5*s;
end


end

