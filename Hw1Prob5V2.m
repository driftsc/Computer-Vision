load synthetic_data.mat;
%assume l1 through l4 are the vectors in cartesian coordinates that point
%towards the light source. 
%im1 through im4 are the images of the surface
imagesize = size(im1);

%make two matrices, one for 3 images, and one for 4 images, for
%the light sources
light3 = double([-l1',-l2',-l4']);
light4 = double([-l1',-l2',-l3',-l4']);

%calculate the inverse matrix once. 
s3inv = inv(light3);

%initalize matrices
b = zeros(3, 'double');
normal3image = zeros(imagesize(1), imagesize(2), 3, 'double');
gradient3image = zeros(imagesize(1), imagesize(2), 3, 'double');

%use a loop to integrate over all possible pixels
for i=1:imagesize(1)
    for j=1:imagesize(2)
        b = s3inv'*[double(im1(i,j));double(im2(i,j));double(im4(i,j))];
        albedo3image(i,j) = norm(b);
        normal3image(i,j,:) = b/norm(b);
        gradient3image(i,j,1) = -1*normal3image(i,j,1)/normal3image(i,j,3);
        gradient3image(i,j,2) = -1*normal3image(i,j,2)/normal3image(i,j,3);
        gradient3image(i,j,3) = 1;
    end
end

albedo3image = uint8(albedo3image);


%reconstruct the height map using the naive method. Initialize the first
%point to be 0 height and keep track of minimum value. 

%We look along a row of x first (down the first column) and then integrate
%across the rows in the y direction.
offset = 0;
surface3image(1,1) = 0;
for i=1:(imagesize(1)-1) %integrate down the first column looking at p gradeint. 
    surface3image(i+1,1) = surface3image(i,1) + gradient3image(i,1,2); %We want the p gradient (pointing down the matrix) (:,:,2) for the given xy coordinate.
    if surface3image(i+1,1) < offset
        offset = surface3image(i+1,1);
    end
end

%Continue the integration across each of the rows. 
for i=1:imagesize(1)
    for j=1:(imagesize(2)-1)%integrate now using the q value (:,:,1) of pq space. 
        surface3image(i,j+1) = surface3image(i,j) + gradient3image(i,j,1);
        if surface3image(i,j+1) < offset
            offset = surface3image(i,j+1);
        end
    end
end
surface3image = surface3image - offset;%Make the lowest point = 0. 




%Repeat for the 4 light source model with some modifications. 

%calculate the Pseudo-inverse matrix once. 
s4inv = (light4*light4')\light4; %(Note that the light sources are already transposed)


%initalize matrices

normal4image = zeros(imagesize(1), imagesize(2), 3, 'double');
gradient4image = zeros(imagesize(1), imagesize(2), 3, 'double');

%use a loop to integrate over all possible pixels
for i=1:imagesize(1)
    for j=1:imagesize(2)
        b = s4inv*[double(im1(i,j));double(im2(i,j));double(im3(i,j));double(im4(i,j))];
        albedo4image(i,j) = norm(b);
        normal4image(i,j,:) = b/norm(b);
        gradient4image(i,j,1) = -1*normal4image(i,j,1)/normal4image(i,j,3);
        gradient4image(i,j,2) = -1*normal4image(i,j,2)/normal4image(i,j,3);
        gradient4image(i,j,3) = 1;
    end
end

albedo4image = uint8(albedo4image);


%reconstruct the height map using the naive method. Initialize the first
%point to be 0 height and keep track of minimum value. 

%We look along a row of x first (down the first column) and then integrate
%across the rows in the y direction.
offset = 0;
surface4image(1,1) = 0;
for i=1:(imagesize(1)-1) %integrate down the first column looking at p gradeint. 
    surface4image(i+1,1) = surface4image(i,1) + gradient4image(i,1,2); %We want the p gradient (pointing down the matrix) (:,:,2) for the given xy coordinate.
    if surface4image(i+1,1) < offset
        offset = surface4image(i+1,1);
    end
end

%Continue the integration across each of the rows. 
for i=1:imagesize(1)
    for j=1:(imagesize(2)-1)%integrate now using the q value (:,:,1) of pq space. 
        surface4image(i,j+1) = surface4image(i,j) + gradient4image(i,j,1);
        if surface4image(i,j+1) < offset
            offset = surface4image(i,j+1);
        end
    end
end
surface4image = surface4image - offset;%Make the lowest point = 0. 



%Time for Horn Integration
mask = ones(imagesize(1), imagesize(2));
horn3 = integrate_horn2(gradient3image(:,:,1),gradient3image(:,:,2),mask,5000,0);
horn4 = integrate_horn2(gradient4image(:,:,1),gradient4image(:,:,2),mask,5000,0);





%plot the various figures. Start with Albedo. 
figure, subplot(1,2,1), imshow(albedo3image); title('3 Image Albedo');
subplot (1,2,2), imshow(albedo4image); title('4 Image Albedo');

figure, subplot(1,2,1), imagesc(albedo3image); title('3 Image Albedo');
subplot (1,2,2), imagesc(albedo4image); title('4 Image Albedo');


%Plot the Needle Maps
samplesize = 5;
[x,y] = meshgrid(1:samplesize:imagesize(1), 1:samplesize:imagesize(2));
normal3image2 = normal3image(1:samplesize:imagesize(1),:,:);
normal3image2 = normal3image2(:,1:samplesize:imagesize(2),:);
surface3image2 = surface3image(1:samplesize:imagesize(1),:);
surface3image2 = surface3image2(:,1:samplesize:imagesize(2));
figure, subplot(1,2,1), quiver3(x,y,surface3image2,normal3image2(:,:,1),normal3image2(:,:,2),normal3image2(:,:,3));
title('3 Image Needle Map'); 

%hold on 
%mesh(x(1,:),y(:,1),surface4image2)
%hold off

normal4image2 = normal4image(1:samplesize:imagesize(1),:,:);
normal4image2 = normal4image2(:,1:samplesize:imagesize(2),:);
surface4image2 = surface4image(1:samplesize:imagesize(1),:);
surface4image2 = surface4image2(:,1:samplesize:imagesize(2));
subplot(1,2,2), quiver3(x,y,surface4image2,normal4image2(:,:,1),normal4image2(:,:,2),normal4image2(:,:,3));
title('4 Image Needle Map');

%hold on 
%mesh(x(1,:),y(:,1),surface4image2)
%hold off

%Top Down View
figure, subplot(1,2,1), quiver3(x,y,surface3image2,normal3image2(:,:,1),normal3image2(:,:,2),normal3image2(:,:,3));
title('3 Image Needle Map'); 
view(2); 
subplot(1,2,2), quiver3(x,y,surface4image2,normal4image2(:,:,1),normal4image2(:,:,2),normal4image2(:,:,3));
title('4 Image Needle Map');
view(2);



%Plot Wireframe/height Maps
figure, subplot(1,2,1), surf(surface3image); title('3 Image Height Map, Naive Method');
subplot(1,2,2), surf(surface4image); title('4 Image Height Map, Naive Method');


%Plot the Horn Integration Results
figure, subplot(1,2,1), surf(horn3); title('3 Image Height Map, Horn Integration');
subplot(1,2,2), surf(horn4); title('4 Image Height Map, Horn Integration');