function [H,G] = costFcn(lambda,t,Z,x,y)
%y is label
%x is features
%t is constant scalar
L=length(x(:,1));
W=Z(1:L,1);
C=Z(L+1,1);
Epsilon=Z(L+2:end,1);
Epsilon=Epsilon';
N=length(Z);
H=[];
n=1;
m=1;
o=1;


%Construct Hessian Matrix
for i=1:N
    %for variable W
    if i<L+1
        H(i,i)=2*lambda+1/t*sum(((x(i,:).*y).^2)./((W'*x.*y+C*y+(Epsilon-1)).^2));
        for j=i+1:N
            if j<L+1
            H(i,j)=1/t*sum((x(i,:).*y.*(x(j,:)).*y)./((W'*x.*y+C*y+(Epsilon-1)).^2));
            elseif j==L+1
            H(i,j)=1/t*sum((x(i,:).*y.*y)./((W'*x.*y+C*y+(Epsilon-1)).^2));
            else
            H(i,j)=1/t*(x(i,o)*y(1,o))/((W'*x(:,o)*y(1,o)+C*y(1,o)+Epsilon(1,o)-1)^2);
            o=o+1;
            end
        end
    o=1;
    %for variable C
    elseif i==L+1
        H(i,i)=1/t*sum((y.^2)./((W'*x.*y+C*y+(Epsilon-1)).^2));
        for j=i+1:N
            H(i,j)=1/t*(y(1,n))/((W'*x(:,n)*y(1,n)+C*y(1,n)+Epsilon(1,n)-1)^2);
            n=n+1;
        end
    %for variable Epsilon
    else
        H(i,i)=1/t*1/(Epsilon(1,m)^2)+1/t*1/((W'*x(:,m)*y(1,m)+C*y(1,m)+Epsilon(1,m)-1)^2);
        m=m+1;
    end
end

%Should be symmetric
for i=1:N
    for j=i+1:N
    H(j,i)=H(i,j);
    end
end


%Construct Gradient
n=1;
G=[];
for i=1:N
    if i<L+1
        G(i,1)=2*lambda*W(i,1)-1/t*sum((x(i,:).*y)./(W'*x.*y+C*y+(Epsilon-1)));
    elseif i==L+1
        G(i,1)=-1/t*sum((y)./(W'*x.*y+C*y+(Epsilon-1)));
    else
        G(i,1)=1-1/t*1/Epsilon(1,n)-1/t*1/(W'*x(:,n)*y(1,n)+C*y(1,n)+Epsilon(1,n)-1);
        n=n+1;
    end
end

end

    
        
        
        

