% HW4 Problem 3

% Load all of the necessary information. 

[trainSet, trainLabel] = loadSubset(0);
[set{1}, setLabel{1}] = loadSubset(1);
[set{2}, setLabel{2}] = loadSubset(2);
[set{3}, setLabel{3}] = loadSubset(3);
[set{4}, setLabel{4}] = loadSubset(4);


for p=1:3
    
        disp(' ')
        disp(' ')
    if p == 1
        disp('L1 Norm')
    else
        if p==2
            disp('Euclidian Norm')
    else
            disp('L3 Norm')
        end
    end



for k = 1:2:5 % How Many Nearest Neighbors? 
Nearest = zeros(k,2); %forst entry is the value, second entry is the position.
Threshold = ceil(k/2);
candidates = zeros(k,3); %column 1 = # class matches, 2 = class, 3 = distance

disp(' ')

disp([num2str(k) ' Nearest Neighbors'])

%% Compare each of the images in the new set to the ones in the training set. 

numSets = 4; %How many subsets are there? Ignore the training set. 
for setNum=1:numSets
    
    Matches = 0;

    
    %Run for all faces in each set. 
    for faceNum=1:size(setLabel{setNum})
        Nearest(:,1) = Inf;
        Nearest(:,2) = 0;
        index = 0; %initalize the index to be zero for each face comparison. 
        
        %Compare the face to each one in training set. 
        for i=1:size(trainLabel,1)
            sum = 0; %initalize the sum to be zero for each comparison. 
            
            for j = 1:size(trainSet,2)
                sum = sum + abs((set{setNum}(faceNum,j) - trainSet(i,j)))^p;
            end 
            
            %Note that we ignore calculating the square root because it
            %does not affect our answer and it takes time. 
            
            
            if sum < Nearest(k,1)
                Nearest(k,1) = sum;
                Nearest(k,2) = i;
                Nearest = sortrows(Nearest);%sort so that the worst match is in the last postition. 
            end
            
        end
        
 
        
        
        
   %% kNN Logic    
        
        
       for element=1:k
           %Sort so that the class number is in column 2, and the distance
           %is in column 3. 
           candidates(element,2) = trainLabel(Nearest(element,2));
           candidates(element,3) = Nearest(element,1);
       end
       
       %Find out how many repeated values there are for each class, store
       %in column 1. 
       for element=1:k
           for m=1:k
               if candidates(m,2) == candidates(element,2)
                   candidates(element,1) = candidates(element,1) + 1;
               end
           end
       end
       
       
       %Find the class(es) with the most matches. If tied, use the shortest
       %distance as the tiebreaker. If not tied, then sorting by distance
       %won't affect the output. 
       maxNum = max(candidates(:,1));
       distance = Inf;
       for element = 1:k
           if candidates(element,1) == maxNum
               if candidates(element,3) < distance
                   distance = candidates(element,3);
                   index = candidates(element,2);
               end
           end
       end
   

%% Old criteria for Knn that needed a majority vote. 
%         for element=1:k
%             RepeatNum = trainLabel(Nearest(element,2));
%             NumRepeats = 0;
%             
%             for m = 1:k
%                 if trainLabel(Nearest(m,2)) == RepeatNum
%                     NumRepeats = NumRepeats + 1;
%                 end
%                 
%             end
%                 
%             if NumRepeats>=Threshold
%                     index = RepeatNum;
%             end
%                           
%         end
                
  %%          
        
        if index>0 && index == setLabel{setNum}(faceNum)
            Matches = Matches+1;
            subsetMatch{setNum}(Matches,1) = index;
            subsetMatch{setNum}(Matches,2) = faceNum;
        else
            subsetMiss{setNum}(faceNum - Matches,1) = index;
            subsetMiss{setNum}(faceNum - Matches,2) = faceNum;
        end
        
    end
    
    
%     disp(['Data for Subset ' num2str(setNum) '. Matches = ' num2str(Matches) ', MisMatches = ' num2str(size(setLabel{setNum},1) - Matches) '. Percentage missed = ' num2str(round(100*((size(setLabel{setNum},1) - Matches)/size(setLabel{setNum},1)),2))]);
      disp([num2str(round(100*((size(setLabel{setNum},1) - Matches)/size(setLabel{setNum},1)),2)) '% Miss for Subset ' num2str(setNum) ' (' num2str(Matches) ' Match, ' num2str(size(setLabel{setNum},1) - Matches) ' Miss)' ]);
                 
            
            
    
end

end

end
