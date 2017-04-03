function [testlabels] = fisherTest(trainset, trainlabels, testset, W, mu, k)
for i=1:size(trainset,1)
    trainset(i,:)=trainset(i,:);
end
for i=1:size(testset,1)
    testset(i,:)=testset(i,:);
end
train=W(1:k,:)*trainset';
test=W(1:k,:)*testset';

testlabels=oneNN(train',trainlabels,test');
end