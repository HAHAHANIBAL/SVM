function [ W_output,C_output,avg_accuracy,std_accuracy,accuracy_output ] = final_calculation( x,y,lambda )
N=length(y);
labels=[1 2 3 4 5 6];



for i=1:(N/6)-1
    labels=cat(2,labels,[1 2 3 4 5 6]);
end

combine_set=cat(1,labels,y,x);



    
for i=1:6
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
    [W_final,C_final,Ksi_final]=InteriorPoint(Z,x_train,y_train,lambda);
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

C_output=C_final;
accuracy_output=accuracy;
avg_accuracy=mean(accuracy);
std_accuracy=std(accuracy);
W_output=W_final;
    


end

