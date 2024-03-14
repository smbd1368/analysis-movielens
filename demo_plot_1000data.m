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
num1=numel(X);
a=[1,5];
Y=randi(2,num1,1);
num1=numel(Y);


%%Y=data1(data2,3);  

rng(1); % For reproducibility


X=X([1:100],:);
Y=Y([1:100],:);
SVMModel = fitcsvm(X,Y);
sv = SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),Y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('RATE 1','RATE 5','Support Vector')
hold off

