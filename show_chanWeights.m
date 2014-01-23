function show_chanWeights(chanVal)
% This function shows the location of one channel on head.
%
% INPUTS: 
%   chanVal is a vector with the weight of the channels to be plotted.
%
% @ 2010 Jinyin Zhang -- jinyinz@andrew.cmu.edu

selNum=1:306;
cortIX=find(mod(selNum,3)~=0);
selNum=selNum(cortIX);


resolution = 200;

% Load sensor location
load sensors102.mat
x = c102(:,2);
y = c102(:,3);
xlin = linspace(min(x),max(x)+35,resolution);
ylin = linspace(min(y),max(y),resolution);
r = 5;


MinChanVal=min(chanVal);
z=ones(length(x),1)*MinChanVal;

selSen=ceil(selNum/3);

maxSen=max(selSen);
for senIX=1:maxSen
    currVal=zeros(2,1);
    for chanIX=1:2
        chanInd=(senIX-1)*3+chanIX;
        tmp=find(selNum==chanInd);
        if (length(tmp)~=0)
            currVal(chanIX)=chanVal(tmp);
        end
    end
    z(senIX)=max(currVal);
end

[X, Y] = meshgrid(xlin, ylin);
Z = griddata(x, y, z, X, Y, 'cubic');
hold on
pcolor(X, Y, Z);
axis equal
set(gca, 'Color', 'w')
axis off
shading interp

colorbar('location','East');

return
