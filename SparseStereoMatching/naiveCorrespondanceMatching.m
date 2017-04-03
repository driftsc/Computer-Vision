function [I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth)
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

I = zeros(max(size(I1,1),size(I2,1)), size(I1,2) + size(I2,2)); %Make new image size to contain both images. 
I(1:size(I1,1),1:size(I1,2),:) = I1;%First image is on the left
I(1:size(I2,1), 1+size(I1,2):size(I1,2)+size(I2,2),:) = I2;%Second image is on the right
NumMatches = 0;

for i=1:size(corners1,1) %Run matching for each corner in image 1
    SSDmin = SSDth; %Initialize SSDmin to an unacceptably large value. 
    for j=1:size(corners2,1) %Compare each point in image 1 to every corner in image 2
        SSD = SSDmatch(I1, I2, corners1(i,:), corners2(j,:), R);
        if SSD<SSDmin
            location = corners2(j,:);
            SSDmin = SSD;
        end

    end
    if SSDmin<SSDth %Discard initial case of SSDmin = SSDth
       NumMatches = NumMatches+1;
       corsSSD(NumMatches,:) = [corners1(i,:), location]; %Build matrix where first two columns are for point in first image, second two columns are for second image. 
    end

end

corsSSD = corsSSD(1:NumMatches,:); %Number of columns should be 4. 

end