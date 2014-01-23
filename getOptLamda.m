function opt_lambda = getOptLamda(x,y)


N=length(y);
labels=[1 2 3 4 5 6];



for i=1:(N/6)-1
    labels=cat(2,labels,[1 2 3 4 5 6]);
end

combine_set=cat(1,labels,y,x);
combine_set=combine_set(:,(combine_set(1,1:end)~=6));

lambda=[0.01 1 100 10000];


for n=1:length(lambda)
    
for i=1:5


    x_train=combine_set(3:end,(combine_set(1,1:end)~=i));
    y_train=combine_set(2,(combine_set(1,1:end)~=i));
    x_test=combine_set(3:end,(combine_set(1,1:end)==i));
    y_test=combine_set(2,(combine_set(1,1:end)==i));
    W=0.5*ones(204,1);
    C=0.5;
    L=length(y_train);
    for j=1:L
        Ksi(j,1)=max(0,1-y_train(1,j)*(W'*x_train(:,j)+C))+0.001;
    end
    Z=cat(1,W,C,Ksi);
    [W_final,C_final,Ksi_final]=InteriorPoint(Z,x_train,y_train,lambda(1,n));
    y_pred=W_final'*x_test+C_final;
    for o=1:length(y_pred)
        if y_pred(1,o)>=0
            y_pred(1,o)=1;
        else
            y_pred(1,o)=-1;
        end
    end
    accuracy(1,i)=(length(y_pred)-sum(abs(y_pred-y_test))/2)/length(y_pred);
end

avg_accuracy(1,n)=mean(accuracy);
    
end

opt_lambda=lambda(1,find(max(avg_accuracy)));

end
    
    