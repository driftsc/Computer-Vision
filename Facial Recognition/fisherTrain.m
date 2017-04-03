function [W,mu]= fisherTrain(trainset, trainlabels,c)
[x,y]=size(trainset);
mu=mean(trainset,1);
 
 for i=1:x
     trainset(i,:)=trainset(i,:)-mu; %Rename to keep original dataset intact. 
 end
 
%  [U D V]=svd(trainset');
%  WPCA=U(:,1:x-c)';
%  %WPCA=V';

%% Return to using Vignesh code. 
 [U D V]=svds(trainset,x-c);
 WPCA=V';
 %%
 


 projectedData = (WPCA*(trainset)')';% mu 
 meanProjectedData=mean(projectedData);
 
 samplesOfEachClass=x/c;
 
 meanOfEachClass= zeros(10, size(projectedData,2));
 
for i = 1:c
    %meanOfEachClass(i,:) = mean(projectedData(samplesOfEachClass*i:samplesOfEachClass*(i),:));
     meanOfEachClass(i,:) = mean(projectedData(trainlabels==i,:));
end
% Between class scatter
SB = zeros(size(meanOfEachClass,2),size(meanOfEachClass,2));
for i = 1:c
     %val=meanOfEachClass(i,:)-meanProjectedData;
     %samplesOfEachClass*(meanOfEachClass(i,:)' - meanProjectedData')*(meanOfEachClass(i,:)' - meanProjectedData')';
     SB=SB+(sum(trainlabels==i)*(meanOfEachClass(i,:) -meanProjectedData)'*(meanOfEachClass(i,:) -meanProjectedData));
end
% Within class scatter
SW = zeros(size(meanOfEachClass,2),size(meanOfEachClass,2));
for i = 1:c
     temp = projectedData(trainlabels==i,:)-repmat( meanOfEachClass(i,:),sum(trainlabels==i),1);
     %temp = sum(temp); %These should be vectors. Summing them makes them vectors. 
     SW=SW+temp'*temp;
     
end
 
[V,~]=eig(SB',SW);
WFLD = V(:,1:c-1);
W = WFLD'*WPCA;