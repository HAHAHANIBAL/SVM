load('feaSubEOvert.mat');
x=cat(2,class{1},class{2});
y=ones(1,240);
y(121:240)=-1;
lambda=getOptLamda(x,y);
[W,C,avg_accuracy,std_accuracy,accuracy]=final_calculation(x,y,lambda);
show_chanWeights(W);
clear;

load('feaSubEImg.mat');
x=cat(2,class{1},class{2});
y=ones(1,240);
y(121:240)=-1;
lambda=getOptLamda(x,y);
[W,C,avg_accuracy,std_accuracy,accuracy]=final_calculation(x,y,lambda);
show_chanWeights(W);
clear;
