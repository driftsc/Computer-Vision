function [corsSSD] = correspondanceMatchingLine(I1,I2,corners1,F,R,SSDth)

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

NumMatches = 0;


corners1(:,3) = 1;
corners1 = [corners1(:,2), corners1(:,1),corners1(:,3)];
LineVector = (F*(corners1'))';
LineVector = LineVector./LineVector(:,3); %Make Homogeneous Coordinate


%For evey point, find a match. 
for i=1:size(LineVector,1)

    
    pts = linePts(LineVector(i,:),[1, size(I1, 2)], [1, size(I1,1)]);
    pts = sortrows(pts); %Make sure that the smaller x value is first. 
    slope = (pts(2,2)-pts(1,2))/(pts(2,1)-pts(1,1));%slope = (y2-y1)/(x2-x1)
    intercept = pts(1,2) - slope*pts(1,1);%b = y-mx
    
    SSDmin = SSDth; %initialize the SSD to be larger than acceptable. 
    
    for x=round(pts(1,1)):pts(2,1) %For full range of x values
        y = round(slope*x + intercept);%find corresponding y value. 
        
        %Make sure that you are sufficiently far from the image border
        if all([x>2*R, x<size(I2,2)-2*R, y>2*R, y<size(I2)-2*R])
            SSD = SSDmatch(I1,I2,[corners1(i,2), corners1(i,1)], [y,x],R); %SSDmatch uses different x and y axis
            if SSD<SSDmin
                location = [x,y];
                SSDmin = SSD;
            end
        end
    end
    if SSDmin<SSDth
        NumMatches = NumMatches+1;
        corsSSD(NumMatches,:) = [corners1(i,2), corners1(i,1), location(2), location(1)];
    end
   
end

corsSSD = corsSSD(1:NumMatches,:);


end

