function [ SSD ] = SSDmatch(Image1, Image2, point1, point2, R)
%Determine the SSD value for the window size to determine how well the
%points match. The smaller the SSD value, the better matched they are. 


%We have already determined that the points are sufficiently far from the
%border so that the window is entirely on the image. 

%Window must be odd. 
 

SSD = 0;

for i=-R:R
    for j=-R:R
        Delta = (Image1(point1(1) + i, point1(2) + j) - Image2(point2(1) + i, point2(2) + j))^2;
        SSD = SSD + Delta;
    end
end

end

