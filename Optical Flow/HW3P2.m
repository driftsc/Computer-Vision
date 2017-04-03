%Load all the files that we need. 
% 
% imageNum = 1;
% 
% %% Load the synthetic texture
% 
% cd data/synth/synth
% 
% synth = dir('*.png');
% for i = synth'
%     I{imageNum} = imread(i.name);
%     
%     imageNum = imageNum + 1;
% end
% 
% cd ..; cd ..; cd ..;
%  pause


%The following opens up the desired images, converts them to grayscale if
%required, converts them to double precision and then divides by 255 to map
%them to the range [0,1].

cd data/synth/synth
synth1 = double(imread('synth_000.png'))/255;
synth2 = double(imread('synth_001.png'))/255;
% synth3 = double(imread('synth_002.png'))/255;
% synth4 = double(imread('synth_003.png'))/255;
% synth5 = double(imread('synth_004.png'))/255;
% synth6 = double(imread('synth_005.png'))/255;
% synth7 = double(imread('synth_006.png'))/255;
% synth8 = double(imread('synth_007.png'))/255;
cd ..;cd ..;cd ..;

cd data/sphere/sphere
sphere1 = double(rgb2gray(imread('sphere.0.png')))/255;
sphere2 = double(rgb2gray(imread('sphere.1.png')))/255;
% sphere3 = double(rgb2gray(imread('sphere.2.png')))/255;
% sphere4 = double(rgb2gray(imread('sphere.3.png')))/255;
% sphere5 = double(rgb2gray(imread('sphere.4.png')))/255;
% sphere6 = double(rgb2gray(imread('sphere.5.png')))/255;
% sphere7 = double(rgb2gray(imread('sphere.6.png')))/255;
% sphere8 = double(rgb2gray(imread('sphere.7.png')))/255;
% sphere9 = double(rgb2gray(imread('sphere.8.png')))/255;
% sphere10 = double(rgb2gray(imread('sphere.9.png')))/255;
% sphere11 = double(rgb2gray(imread('sphere.10.png')))/255;
% sphere12 = double(rgb2gray(imread('sphere.11.png')))/255;
% sphere13 = double(rgb2gray(imread('sphere.12.png')))/255;
% sphere14 = double(rgb2gray(imread('sphere.13.png')))/255;
% sphere15 = double(rgb2gray(imread('sphere.14.png')))/255;
% sphere16 = double(rgb2gray(imread('sphere.15.png')))/255;
% sphere17 = double(rgb2gray(imread('sphere.16.png')))/255;
% sphere18 = double(rgb2gray(imread('sphere.17.png')))/255;
% sphere19 = double(rgb2gray(imread('sphere.18.png')))/255;
% sphere20 = double(rgb2gray(imread('sphere.19.png')))/255;
cd ..;cd ..;cd ..;

cd data/corridor/corridor
corridor1 = double(imread('bt.000.png'))/255;
corridor2 = double(imread('bt.001.png'))/255;
% corridor3 = double(imread('bt.002.png'))/255;
% corridor4 = double(imread('bt.003.png'))/255;
% corridor5 = double(imread('bt.004.png'))/255;
% corridor6 = double(imread('bt.005.png'))/255;
% corridor7 = double(imread('bt.006.png'))/255;
% corridor8 = double(imread('bt.007.png'))/255;
% corridor9 = double(imread('bt.008.png'))/255;
% corridor10 = double(imread('bt.009.png'))/255;
% corridor11 = double(imread('bt.010.png'))/255;
cd ..;cd ..;cd ..



%% Problem 2.1 - Dense Optical Flow using Lucas - Kanade optical flow algorithm. 

tau = 0.0025;
windowSize1 = 7;
windowSize2 = 15;
windowSize3 = 40;


[u, v, hitMap] = opticalFlow(synth1, synth2, windowSize1, tau);
figure, subplot(2,3,4), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize1)])

%Plot the Needle Maps
samplesize = ceil(size(synth1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(synth1,1),:);
u = u(:,1:samplesize:size(synth1,2));
v = v(1:samplesize:size(synth1,1),:);
v = v(:,1:samplesize:size(synth1,2));
subplot(2,3,1), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize1)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(synth1, synth2, windowSize2, tau);
subplot(2,3,5), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize2)])

%Plot the Needle Maps
samplesize = ceil(size(synth1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(synth1,1),:);
u = u(:,1:samplesize:size(synth1,2));
v = v(1:samplesize:size(synth1,1),:);
v = v(:,1:samplesize:size(synth1,2));
subplot(2,3,2), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize2)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(synth1, synth2, windowSize3, tau);
subplot(2,3,6), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize3)])


%Plot the Needle Maps
samplesize = ceil(size(synth1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(synth1,1),:);
u = u(:,1:samplesize:size(synth1,2));
v = v(1:samplesize:size(synth1,1),:);
v = v(:,1:samplesize:size(synth1,2));
subplot(2,3,3), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize3)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])
[u, v, hitMap] = opticalFlow(sphere1, sphere2, windowSize1, tau);




tau = 0.0015;
windowSize1 = 10;
windowSize2 = 20;
windowSize3 = 60;




figure, subplot(2,3,4), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize1)])

%Plot the Needle Maps
samplesize = ceil(size(sphere1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(sphere1,1),:);
u = u(:,1:samplesize:size(sphere1,2));
v = v(1:samplesize:size(sphere1,1),:);
v = v(:,1:samplesize:size(sphere1,2));
subplot(2,3,1), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize1)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(sphere1, sphere2, windowSize2, tau);
subplot(2,3,5), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize2)])

%Plot the Needle Maps
samplesize = ceil(size(sphere1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(sphere1,1),:);
u = u(:,1:samplesize:size(sphere1,2));
v = v(1:samplesize:size(sphere1,1),:);
v = v(:,1:samplesize:size(sphere1,2));
subplot(2,3,2), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize2)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(sphere1, sphere2, windowSize3, tau);
subplot(2,3,6), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize3)])


%Plot the Needle Maps
samplesize = ceil(size(sphere1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(sphere1,1),:);
u = u(:,1:samplesize:size(sphere1,2));
v = v(1:samplesize:size(sphere1,1),:);
v = v(:,1:samplesize:size(sphere1,2));
subplot(2,3,3), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize3)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])




tau = 0.008;
windowSize1 = 15;
windowSize2 = 30;
windowSize3 = 100;


[u, v, hitMap] = opticalFlow(corridor1, corridor2, windowSize1, tau);
figure, subplot(2,3,4), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize1)])

%Plot the Needle Maps
samplesize = ceil(size(corridor1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(corridor1,1),:);
u = u(:,1:samplesize:size(corridor1,2));
v = v(1:samplesize:size(corridor1,1),:);
v = v(:,1:samplesize:size(corridor1,2));
subplot(2,3,1), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize1)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(corridor1, corridor2, windowSize2, tau);
subplot(2,3,5), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize2)])

%Plot the Needle Maps
samplesize = ceil(size(corridor1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(corridor1,1),:);
u = u(:,1:samplesize:size(corridor1,2));
v = v(1:samplesize:size(corridor1,1),:);
v = v(:,1:samplesize:size(corridor1,2));
subplot(2,3,2), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize2)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])



[u, v, hitMap] = opticalFlow(corridor1, corridor2, windowSize3, tau);
subplot(2,3,6), imshow(hitMap)
title(['Valid area, windowsize: ' num2str(windowSize3)])


%Plot the Needle Maps
samplesize = ceil(size(corridor1,1)/20); % Sample so that there are 20 points across the image. 
u = u(1:samplesize:size(corridor1,1),:);
u = u(:,1:samplesize:size(corridor1,2));
v = v(1:samplesize:size(corridor1,1),:);
v = v(:,1:samplesize:size(corridor1,2));
subplot(2,3,3), quiver(flipud(u),flipud(-v)) %Flipping matrix and taking negative v direction to match the image plotting. 
title(['Needlemap, windowsize: ' num2str(windowSize3)])
xlim([0,20])
ylim([0,20])
xticks([5,10,15,20])
yticks([5,10,15,20])


%% Problem 2.2 - Corner Detection

%Set parameters
smoothSTD = 1;
nCorners = 50;
windowSize = 7;

%Calculate corners for each image
synthCorners = CornerDetect(synth1, nCorners, smoothSTD, windowSize);
sphereCorners = CornerDetect(sphere1, nCorners, smoothSTD, windowSize);
corridorCorners = CornerDetect(corridor1, nCorners, smoothSTD, windowSize);

%Plot results
figure, imshow(synth1);
hold on
plot(synthCorners(:,2),synthCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);
hold off

figure, imshow(sphere1);
hold on
plot(sphereCorners(:,2),sphereCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);
hold off

figure, imshow(corridor1);
hold on
plot(corridorCorners(:,2),corridorCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);
hold off



%% Problem 2.3 - Sparse Optical Flow


tau = 0.003;%Choose small threshold so that it is defined at all corners. 
windowSize1 = 15;


[u, v] = opticalFlow(synth1, synth2, windowSize1, tau);
figure, imshow(synth1);
hold on
plot(synthCorners(:,2),synthCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);%remember that corners have a different coordinate system
sparseFlowU = zeros(size(synth1));
sparseFlowV = zeros(size(synth1));
%Subsample the optical flow at each corner. 
for i=1:size(synthCorners,1)
    sparseFlowU(synthCorners(i,1),synthCorners(i,2)) = u(synthCorners(i,1),synthCorners(i,2));
    sparseFlowV(synthCorners(i,1),synthCorners(i,2)) = v(synthCorners(i,1),synthCorners(i,2));
end
quiver(sparseFlowU*10, sparseFlowV*10, 'AutoScale','Off','LineWidth',3) 
hold off





tau = 0.0015;%Choose small threshold so that it is defined at all corners. 
windowSize1 = 30;


[u, v] = opticalFlow(sphere1, sphere2, windowSize1, tau);
figure, imshow(sphere1);
hold on
plot(sphereCorners(:,2),sphereCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);%remember that corners have a different coordinate system
sparseFlowU = zeros(size(sphere1));
sparseFlowV = zeros(size(sphere1));
%Subsample the optical flow at each corner. 
for i=1:size(sphereCorners,1)
    sparseFlowU(sphereCorners(i,1),sphereCorners(i,2)) = u(sphereCorners(i,1),sphereCorners(i,2));
    sparseFlowV(sphereCorners(i,1),sphereCorners(i,2)) = v(sphereCorners(i,1),sphereCorners(i,2));
end
quiver(sparseFlowU*10, sparseFlowV*10, 'AutoScale','Off','LineWidth',3) 
hold off







tau = 0.002;%Choose small threshold so that it is defined at all corners. 
windowSize1 = 100;


[u, v] = opticalFlow(corridor1, corridor2, windowSize1, tau);
figure, imshow(corridor1);
hold on
plot(corridorCorners(:,2),corridorCorners(:,1),'ro','MarkerSize',6, 'LineWidth',1.5);%remember that corners have a different coordinate system
sparseFlowU = zeros(size(corridor1));
sparseFlowV = zeros(size(corridor1));
%Subsample the optical flow at each corner. 
for i=1:size(corridorCorners,1)
    sparseFlowU(corridorCorners(i,1),corridorCorners(i,2)) = u(corridorCorners(i,1),corridorCorners(i,2));
    sparseFlowV(corridorCorners(i,1),corridorCorners(i,2)) = v(corridorCorners(i,1),corridorCorners(i,2));
end
quiver(sparseFlowU*10, sparseFlowV*10, 'AutoScale','Off','LineWidth',3) 
plot(132,92,'gx','MarkerSize',10,'LineWidth',2);%Manually mark FOE
hold off

