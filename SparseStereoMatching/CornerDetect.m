function [corners] = CornerDetect(Image, nCorners, smoothSTD, windowSize)

Image = rgb2gray(Image);

gaussFilt = fspecial('gaussian',[windowSize,windowSize],smoothSTD); %Create a gaussian filter kernel
smoothImage = conv2(Image,gaussFilt, 'same'); %Convolve image with filter and make sure output is the same size
gradientXImage = conv2(smoothImage,[-1/2;0;1/2], 'same'); %Choose X direction to be down, and take partial derivative. 
gradientYImage = conv2(smoothImage,[-1/2,0,1/2], 'same'); %Choose Y direction to be to the right, and take partial derivative. 

%Lets compute C for the entire matrix, then sort based on the value of C.
%Column1 = value, Column2 = m (row) and Column3 = n(column)
Ix2 = gradientXImage.*gradientXImage;
Ixy = gradientXImage.*gradientYImage;
Iy2 = gradientYImage.*gradientYImage;

%Use this to find values over the window
borderSize = (windowSize - 1)/2;

e = zeros(size(Image,1),size(Image,2));
corners = zeros(size(Image,1)*size(Image,2),3);

for i=1+borderSize:size(Image,1)-borderSize
    for j=1+borderSize:size(Image,2)-borderSize
        %We do this operation for all valid pixels
        
        %sum elements of each matrix over the window size
        Ix2Partial = sum(Ix2((i-borderSize):(i+borderSize),(j-borderSize):(j+borderSize)));
        Ix2Sum = sum(Ix2Partial);
        
        IxyPartial = sum(Ixy((i-borderSize):(i+borderSize),(j-borderSize):(j+borderSize)));
        IxySum = sum(IxyPartial);
        
        Iy2Partial = sum(Iy2((i-borderSize):(i+borderSize),(j-borderSize):(j+borderSize)));
        Iy2Sum = sum(Iy2Partial);
        
        c = [Ix2Sum, IxySum; IxySum, Iy2Sum];
        eigenValue = eig(c);
        e(i,j) = min(eigenValue(1), eigenValue(2));
        
    end
end

%Suppress anything that is not a local maximum. Store anything that is a
%local maximum into a vector (actually a matrix with coordinates, too)
cornersFound = 0;
for i=1+windowSize:size(Image,1)-windowSize %This needs to be larger than the border so that we don't accidentally catch the actual image corners. 
    for j=1+windowSize:size(Image,2)-windowSize
        ePartial = max(e((i-borderSize):(i+borderSize),(j-borderSize):(j+borderSize)));
        eMax = max(ePartial);
        if e(i,j)==eMax
            cornersFound = cornersFound + 1;
            corners(cornersFound,:) = [e(i,j),i,j];
        end
    end
end

%sort corners based on how strong they are.
corners = sortrows(corners);%These are in ascending order of how strong the corner is. 
corners = flipud(corners); %Now they are in descending order
corners = corners(1:nCorners,2:3);%Take the best corners from the top of the matrix. Only report the coordinates (i,j) 


end