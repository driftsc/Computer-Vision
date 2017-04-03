function [u, v, hitMap] = opticalFlow(I1, I2, windowSize, tau)
%Choose X direction to be down, Y direction to be to the right. 

smoothSTD = 1.4;
smoothWindow = 5; %apply the smothing window separately.

 
gaussFilt = fspecial('gaussian',[smoothWindow,smoothWindow],smoothSTD); %Create a gaussian filter kernel
smoothImage = conv2(I1,gaussFilt, 'same'); %Convolve image with filter and make sure output is the same size
gradientXImage = conv2(smoothImage,[-1/2,0,1/2], 'same'); %Choose X direction to be to the right, and take partial derivative. 
gradientYImage = conv2(smoothImage,[-1/2;0;1/2], 'same'); %Choose Y direction to be down, and take partial derivative. 
gradientIImage = conv2(I2, gaussFilt, 'same') - smoothImage;%find temporal differences by subtracting smoothed images. 

%Lets compute C for the entire matrix, then sort based on the value of C.
%Column1 = value, Column2 = m (row) and Column3 = n(column)
Ix2 = gradientXImage.*gradientXImage;
Ixy = gradientXImage.*gradientYImage;
Iy2 = gradientYImage.*gradientYImage;
Ixt = gradientXImage.*gradientIImage;
Iyt = gradientYImage.*gradientIImage;

% Create kernel that will average over the window size. 
avgKernel = ones(windowSize, windowSize)/(windowSize*windowSize);

% Calculate parts of the matrix for each pixel. 
Ix2Sum = conv2(Ix2, avgKernel, 'same');
IxySum = conv2(Ixy, avgKernel, 'same');
Iy2Sum = conv2(Iy2, avgKernel, 'same');
IxtSum = conv2(Ixt, avgKernel, 'same');
IytSum = conv2(Iyt, avgKernel, 'same');

%for every pixel, calculate u and v. Remember directions of u and v. 
hitMap = zeros(size(I1,1),size(I1,2));
u = zeros(size(I1,1),size(I1,2));
v = zeros(size(I1,1),size(I1,2));

for i=1:size(I1,1)
    for j=1:size(I1,2)
        m = [Ix2Sum(i,j), IxySum(i,j); IxySum(i,j), Iy2Sum(i,j)];
        b = [IxtSum(i,j); IytSum(i,j)];
        
        
        eigenValue = eig(m); %hard code an adjustment factor to decrease tau. (match results in problem description)
        
        if min(eigenValue(1), eigenValue(2)) > tau
            hitMap(i,j) = 1;
            
            direction = m\b;
            u(i,j) = direction(1);
            v(i,j) = direction(2);
        end
    end
end


end