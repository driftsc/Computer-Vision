%% Load information
load warrior2.mat
load matrix2.mat

%% Define problem parameters

nCorners = 20;
smoothSTD = 1.4;
windowSize = 11;
R = (windowSize - 1)/2;
SSDth = 5;

%% Problem 6.1
 
corners1 = CornerDetect(warrior01,nCorners,smoothSTD,windowSize);
figure, subplot(1,2,1), imshow(rgb2gray(warrior01));
hold on
plot(corners1(:,2),corners1(:,1),'bo','MarkerSize',20, 'LineWidth',2);
hold off

corners2 = CornerDetect(warrior02,nCorners,smoothSTD,windowSize);
subplot(1,2,2), imshow(rgb2gray(warrior02));
hold on
plot(corners2(:,2),corners2(:,1),'bo','MarkerSize',20, 'LineWidth',2);
hold off


corners3 = CornerDetect(matrix01,nCorners,smoothSTD,windowSize);
figure, subplot(1,2,1), imshow(rgb2gray(matrix01));
hold on
plot(corners3(:,2),corners3(:,1),'bo','MarkerSize',20, 'LineWidth',2);
hold off

corners4 = CornerDetect(matrix02,nCorners,smoothSTD,windowSize);
subplot(1,2,2), imshow(rgb2gray(matrix02));
hold on
plot(corners4(:,2),corners4(:,1),'bo','MarkerSize',20, 'LineWidth',2);
hold off


%% Problem 6.2

%No Output required

%% Problem 6.3 

for k = 1:2
    if k==1
        I1 = warrior01;
        I2 = warrior02;
    else
        I1 = matrix01;
        I2 = matrix02;
        SSDth = 3;
    end

    for ncorners = 10:10:30
        corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
        corners2 = CornerDetect(I2, ncorners, smoothSTD, windowSize);
        [I, corsSSD] = naiveCorrespondanceMatching(I1,I2,corners1, corners2,R,SSDth);

        figure, imshow(I);
        hold on
        for i=1:size(corsSSD,1)
            plot([corsSSD(i,2), corsSSD(i,4) + size(I1,2)], [corsSSD(i,1), corsSSD(i,3)],'b-', 'LineWidth',2);
        end
        plot(corsSSD(:,2), corsSSD(:,1),'ro','MarkerSize',20, 'LineWidth',2);
        plot(corsSSD(:,4)+size(I1,2),corsSSD(:,3),'ro','MarkerSize',20, 'LineWidth',2);
        hold off

    end

end %end loop that picks if we are using matrix loop or warrior loop. 

%% Problem 6.4

load warrior2.mat;
F = fund(cor1,cor2);
cor1(:,3) = 1;%Add the Z coordinate because these are already normalized coordinates. 
cor2(:,3) = 1;
LineVector1 = (F'*(cor2'))';
LineVector2 = (F*(cor1'))';

%Normalize the line vectors. 
LineVector1 = LineVector1./LineVector1(:,3);
LineVector2 = LineVector2./LineVector2(:,3);

I1 = rgb2gray(warrior01);
I2 = rgb2gray(warrior02);
figure, subplot(1,2,1), imshow(I1);
hold on
for i=1:size(LineVector1,1)
    pts = linePts(LineVector1(i,:),[1, size(I1, 2)], [1, size(I1,1)]);
    plot(pts(:,1), pts(:,2),'b-', 'LineWidth',2);
end
plot(cor1(:,1), cor1(:,2),'bo','MarkerSize',20, 'LineWidth',2);
hold off

subplot(1,2,2), imshow(I2);
hold on
for i=1:size(LineVector2,1)
    pts = linePts(LineVector2(i,:),[1, size(I2, 2)], [1, size(I2,1)]);
    plot(pts(:,1), pts(:,2),'b-', 'LineWidth',2);
end
plot(cor2(:,1), cor2(:,2),'bo','MarkerSize',20, 'LineWidth',2);
hold off




load matrix2.mat;
F = fund(cor1,cor2);
cor1(:,3) = 1;%Add the Z coordinate because these are already normalized coordinates. 
cor2(:,3) = 1;
LineVector1 = (F'*(cor2'))';
LineVector2 = (F*(cor1'))';

%Normalize the line vectors. 
LineVector1 = LineVector1./LineVector1(:,3);
LineVector2 = LineVector2./LineVector2(:,3);

I1 = rgb2gray(matrix01);
I2 = rgb2gray(matrix02);
figure, subplot(1,2,1), imshow(I1);
hold on
for i=1:size(LineVector1,1)
    pts = round(linePts(LineVector1(i,:),[1, size(I1, 2)], [1, size(I1,1)]));
    plot(pts(:,1), pts(:,2),'b-', 'LineWidth',2);
end
plot(cor1(:,1), cor1(:,2),'bo','MarkerSize',20, 'LineWidth',2);
hold off

subplot(1,2,2), imshow(I2);
hold on
for i=1:size(LineVector2,1)
    pts = linePts(LineVector2(i,:),[1, size(I2, 2)], [1, size(I2,1)]);
    plot(pts(:,1), pts(:,2),'b-', 'LineWidth',2);
end
plot(cor2(:,1), cor2(:,2),'bo','MarkerSize',20, 'LineWidth',2);
hold off

%% Problem 6.5

% load dino2.mat
% I1 = dino01;
% I2 = dino02;

load warrior2.mat;
I1 = warrior01;
I2 = warrior02;

SSDth = 3.25;

I = zeros(max(size(I1,1),size(I2,1)), size(I1,2) + size(I2,2)); %Make new image size to contain both images. 
I(1:size(I1,1),1:size(I1,2),:) = rgb2gray(I1);%First image is on the left
I(1:size(I2,1), 1+size(I1,2):size(I1,2)+size(I2,2),:) = rgb2gray(I2);%Second image is on the right

ncorners = 10; 
F = fund(cor1,cor2);
corners1 = CornerDetect(I1,ncorners,smoothSTD,windowSize);
corsSSD = correspondanceMatchingLine(I1,I2,corners1,F,R,SSDth);

figure, imshow(I);
hold on
for i=1:size(corsSSD,1)
    plot([corsSSD(i,2), corsSSD(i,4) + size(I1,2)], [corsSSD(i,1), corsSSD(i,3)],'b-', 'LineWidth',2);
end
plot(corsSSD(:,2), corsSSD(:,1),'ro','MarkerSize',20, 'LineWidth',2);
plot(corsSSD(:,4)+size(I1,2),corsSSD(:,3),'ro','MarkerSize',20, 'LineWidth',2);
hold off






load matrix2.mat;
I1 = matrix01;
I2 = matrix02;

SSDth = 2.5;

I = zeros(max(size(I1,1),size(I2,1)), size(I1,2) + size(I2,2)); %Make new image size to contain both images. 
I(1:size(I1,1),1:size(I1,2),:) = rgb2gray(I1);%First image is on the left
I(1:size(I2,1), 1+size(I1,2):size(I1,2)+size(I2,2),:) = rgb2gray(I2);%Second image is on the right

ncorners = 10; 
F = fund(cor1,cor2);
corners1 = CornerDetect(I1,ncorners,smoothSTD,windowSize);
corsSSD = correspondanceMatchingLine(I1,I2,corners1,F,R,SSDth);

figure, imshow(I);
hold on
for i=1:size(corsSSD,1)
    plot([corsSSD(i,2), corsSSD(i,4) + size(I1,2)], [corsSSD(i,1), corsSSD(i,3)],'b-', 'LineWidth',2);
end
plot(corsSSD(:,2), corsSSD(:,1),'ro','MarkerSize',20, 'LineWidth',2);
plot(corsSSD(:,4)+size(I1,2),corsSSD(:,3),'ro','MarkerSize',20, 'LineWidth',2);
hold off


%% Problem 6.6

load warrior2.mat
I1 = warrior02;
I2 = warrior01;
P1 = proj_warrior01;
P2 = proj_warrior02;


outlierTH = 20;
F =fund(cor1, cor2);
ncorners = 50;
corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine(I1, I2, corners1, F, R, SSDth);
points3D = triangulate(corsSSD, P1, P2);
[inlier, outlier] = findOutliers(points3D, P2, outlierTH, corsSSD);

figure, imshow(rgb2gray(I2));
hold on
plot(corsSSD(:,4), corsSSD(:,3),'ko','MarkerSize',10, 'LineWidth',2);
plot(inlier(:,2), inlier(:,1), 'b+','MarkerSize',10, 'LineWidth',2);
plot(outlier(:,2), outlier(:,1), 'r+','MarkerSize',10, 'LineWidth',2);
hold off






load matrix2.mat
I1 = matrix02;
I2 = matrix01;
P1 = proj_matrix01;
P2 = proj_matrix02;


outlierTH = 20;
F =fund(cor1, cor2);
ncorners = 50;
corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine(I1, I2, corners1, F, R, SSDth);
points3D = triangulate(corsSSD, P1, P2);
[inlier, outlier] = findOutliers(points3D, P2, outlierTH, corsSSD);

figure, imshow(rgb2gray(I2));
hold on
plot(corsSSD(:,4), corsSSD(:,3),'ko','MarkerSize',10, 'LineWidth',2);
plot(inlier(:,2), inlier(:,1), 'b+','MarkerSize',10, 'LineWidth',2);
plot(outlier(:,2), outlier(:,1), 'r+','MarkerSize',10, 'LineWidth',2);
hold off

