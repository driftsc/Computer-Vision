 function [W, mu] = eigenTrain(trainset, k)
 [x,y]=size(trainset);
 mu=mean(trainset,1);
 
 for i=1:x
     trainset(i,:)=trainset(i,:)-mu;
 end
 
 [U D V]=svds(trainset,k);
 W=V';
 %W=U;
 
 end
 