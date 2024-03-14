domian=5;
s=load('matlab.mat');
data=zeros(domian,4);
dd=zeros(domian,1);
data1=s.u;
%%X=data1(:,[1,2,4]); 
%%CVSVMModel = fitcsvm(X,Y,'OptimizeHyperparameters','auto','@kernel','gaussian');
[a1,b1]=find(data1(:,3)==1);
[a2,b2]=find(data1(:,3)==5);
data2=[a1;a2];
X=data1(data2,[1,2,4]);
Y=data1(data2,3);
X=X([6000:7000],:);
Y=Y([6000:7000],:);
rng(1); % For reproducibility




rng default % For reproducibility
grnpop = mvnrnd([1,0],eye(2),10);
redpop = mvnrnd([0,1],eye(2),10);


redpts = zeros(100,2);grnpts = redpts;
for i = 1:100
    grnpts(i,:) = mvnrnd(grnpop(randi(10),:),eye(2)*0.02);
    redpts(i,:) = mvnrnd(redpop(randi(10),:),eye(2)*0.02);
end




cdata = [grnpts;redpts];
grp = ones(200,1);
% Green label 1, red label -1
grp(101:200) = -1;

c = cvpartition(200,'KFold',10);

%30 iteration--  randomsearch : bayesopt

opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
    'AcquisitionFunctionName','expected-improvement-plus');
svmmod = fitcsvm(cdata,grp,'KernelFunction','gaussian',...
    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)



lossnew = kfoldLoss(fitcsvm(cdata,grp,'CVPartition',c,'KernelFunction','r',...
    'BoxConstraint',svmmod.HyperparameterOptimizationResults.XAtMinObjective.BoxConstraint,...
    'KernelScale',svmmod.HyperparameterOptimizationResults.XAtMinObjective.KernelScale))


lossnew = kfoldLoss(fitcsvm(cdata,grp,'CVPartition',c,'KernelFunction','linear',...
    'BoxConstraint',svmmod.HyperparameterOptimizationResults.XAtMinObjective.BoxConstraint,...
    'KernelScale',svmmod.HyperparameterOptimizationResults.XAtMinObjective.KernelScale))



% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(cdata(:,1)):d:max(cdata(:,1)),...
%     min(cdata(:,2)):d:max(cdata(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];
% [~,scores] = predict(svmmod,xGrid);
% figure;
% h = nan(3,1); % Preallocation
% h(1:2) = gscatter(cdata(:,1),cdata(:,2),grp,'rg','+*');
% hold on
% h(3) = plot(cdata(svmmod.IsSupportVector,1),...
%     cdata(svmmod.IsSupportVector,2),'ko');
% contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
% legend(h,{'-1','+1','Support Vectors'},'Location','Southeast');
% axis equal
% hold off
% 
