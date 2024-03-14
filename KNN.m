


domian=5;
s=load('matlab.mat');

data=zeros(domian,4);
dd=zeros(domian,1);
data1=s.u;
%%X=data1(:,[1,2,4]);

[a1,b1]=find(data1(:,3)==1);
[a2,b2]=find(data1(:,3)==5);
[a3,b3]=find(data1(:,3)==3);
data2=[a1;a2;a3];
X=data1(data2,[1,2,4]);
%X=corr(X')
Y=data1(data2,3);


num1=50;
Yind1=find(Y==1);
Yind2=find(Y==5);
Yind4=find(Y==3);
Y1=Y(Yind1(1:num1),:);
Y5=Y(Yind2(1:num1),:);
Y4=Y(Yind4(1:num1),:);

Y=Y([Yind1(1:num1);Yind2(1:num1);Yind4(1:num1)],:);

X=X([Yind1(1:num1);Yind2(1:num1);Yind4(1:num1)],:);

X=corr(X');

% 2 class 
Mdl = fitcknn(X,Y,'NumNeighbors',2);
rloss = resubLoss(Mdl)