function [inlier, outlier] = findOutliers(points3D, P2, outlierTH, corsSSD)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

NumOutlier = 0;
NumInlier = 0;

for i=1:size(corsSSD,1)
    x = P2 * points3D(i,:)';
    x = x/x(3);
    distance = sqrt((corsSSD(i,3) - x(2))^2 + (corsSSD(i,4) - x(1))^2);%distance is the root of the sum of the swuareds. Y coordinate first, then x coordinate. 
    if distance<outlierTH
        NumInlier = NumInlier+1;
        inlier(NumInlier, :) = [x(2), x(1)]; %Revert back to our coordinate system rather than the one given. 
    else
        NumOutlier = NumOutlier + 1;
        outlier(NumOutlier,:) = [x(2), x(1)];
    end
            
end

