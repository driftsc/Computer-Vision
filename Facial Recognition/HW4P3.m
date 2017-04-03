% HW4 Problem 3

% Load all of the necessary information. 

[trainSet, trainLabel] = loadSubset(0);
[set{1}, setLabel{1}] = loadSubset(1);
[set{2}, setLabel{2}] = loadSubset(2);
[set{3}, setLabel{3}] = loadSubset(3);
[set{4}, setLabel{4}] = loadSubset(4);

%% Compare each of the images in the new set to the ones in the training set. 
for p=1:3
    disp(' ')
    if p == 1
        disp('L1 Norm')
    else if p==2
            disp('Euclidian Norm')
    else
            disp('L3 Norm')
        end
    end
    
    
    
numSets = 4; %How many subsets are there? Ignore the training set. 
for setNum=1:numSets
    
    Matches = 0;

    
    %Run for all faces in each set. 
    for faceNum=1:size(setLabel{setNum})
        minDist = Inf; %initalize the minimum distance for each face comparison. 
        index = 0; %initalize the index to be zero for each face comparison. 
        
        %Compare the face to each one in training set. 
        for i=1:size(trainLabel,1)
            sum = 0; %initalize the sum to be zero for each comparison. 
            
            for j = 1:size(trainSet,2)
                sum = sum + abs((set{setNum}(faceNum,j) - trainSet(i,j)))^p;
            end 
            
            %Note that we ignore calculating the square root because it
            %does not affect our answer and it takes time. 
            
            if sum < minDist
                minDist = sum;
                index = i;
            end
            
        end
        
        if index>0 && trainLabel(index) == setLabel{setNum}(faceNum)
            Matches = Matches+1;
            subsetMatch{setNum}(Matches,1) = index;
            subsetMatch{setNum}(Matches,2) = faceNum;
        else
            subsetMiss{setNum}(faceNum - Matches,1) = index;
            subsetMiss{setNum}(faceNum - Matches,2) = faceNum;
        end
        
    end
    
   
  %    disp(['Data for Subset ' num2str(setNum) '. Matches = ' num2str(Matches) ', MisMatches = ' num2str(size(setLabel{setNum},1) - Matches) '. Percentage missed = ' num2str(round(100*((size(setLabel{setNum},1) - Matches)/size(setLabel{setNum},1)),2))]);
      disp([num2str(round(100*((size(setLabel{setNum},1) - Matches)/size(setLabel{setNum},1)),2)) '% Miss for Subset ' num2str(setNum) ' (' num2str(Matches) ' Match, ' num2str(size(setLabel{setNum},1) - Matches) ' Miss)' ]);
                 
            
            
    
end

% if p==2
%     for i=1:size(subsetMatch{2}, 1)
% a = subsetMatch{1}(i,1);
% b = subsetMatch{1}(i,2);
% training = trainSet(a,:);
% match = set{1}(b,:);
% comparison = [training;match];
% imshow(drawFaces(comparison, 2));
% i
% pause
% end
% 
% 
% for i=1:size(subsetMiss{3}, 1)
% a = subsetMiss{3}(i,1);
% b = subsetMiss{3}(i,2);
% training = trainSet(a,:);
% match = set{3}(b,:);
% comparison = [training;match];
% imshow(drawFaces(comparison, 2));
% i
% pause
% end
end



%%

