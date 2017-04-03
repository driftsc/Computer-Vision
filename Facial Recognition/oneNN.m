function [testlabels] = oneNN(trainset, trainlabels, testset)


%% Compare each of the images in the new set to the ones in the training set. 
    
    Matches = 0;
    testlabels = zeros(size(testset,1),1);
    
    %Run for all faces in each set. 
    for faceNum=1:size(testset,1)
        minDist = Inf; %initalize the minimum distance for each face comparison. 
        index = 0; %initalize the index to be zero for each face comparison. 
        
        %Compare the face to each one in training set. 
        for i=1:size(trainlabels,1)
            sum = 0; %initalize the sum to be zero for each comparison. 
            
            for j = 1:size(trainset,2)
                sum = sum + ((testset(faceNum,j) - trainset(i,j)))^2;
            end 
            
            %Note that we ignore calculating the square root because it
            %does not affect our answer and it takes time. 
            
            if sum < minDist
                minDist = sum;
                index = i;
            end
            
        end
        
        testlabels(faceNum) = trainlabels(index);
        
    end
    
    
end
 