
domian=5;
s=load('matlab.mat');

data=zeros(domian,4);
dd=zeros(domian,1);
data1=s.u;
%%X=data1(:,[1,2,4]);

[a1,b1]=find(data1(:,3)==1);
[a2,b2]=find(data1(:,3)==5);
data2=[a1;a2];
X=data1(data2,[1,2,4]);
%X=corr(X')
Y=data1(data2,3);


num1=500
Yind1=find(Y==1)
Yind2=find(Y==5)
Y1=Y(Yind1(1:num1),:)
Y5=Y(Yind2(1:num1),:)
Y=[Yind1(1:num1);Yind2(1:num1)]

X=X([Yind1(1:num1);Yind2(1:num1)],:);
X=normalize(X);
%Y=Y([1:50],:);
X=corr(X',X','Type','pearson','Rows','complete');



% X=X([1:50],:);
% Y=Y([1:50],:);
% X=corr(X',X','Type','pearson','Rows','complete')
net = patternnet(4);
[net,tr] = train(net,X,Y');

