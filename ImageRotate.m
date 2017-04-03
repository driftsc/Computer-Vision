function ImageRotate(image)
OriginalImage = imread(image); %read the image into a matrix

%Find some critical parameters like width and height
ImageSize = size(OriginalImage);
HalfWidth = (ImageSize(2)+1)/2; %we have to get back to the origin, but matlab starts the indexes at 1.
HalfHeight = (ImageSize(1)+1)/2;
OldLocation = zeros(3,1);
OldLocation(3) = 1;


for i = 0:3 %Automatically handle the 4 cases of rotation desired from the function. 

    %Construct the rotation matrix
    Angle = pi*i/2;
    Transformation = [cos(Angle), -sin(Angle), HalfHeight;
        sin(Angle), cos(Angle), HalfWidth;
        0,0,1];
    %note that we are adding the second translation vector to the transformation
    %matrix to return the image to a useable state. 
    
    Translation = [-HalfHeight; -HalfWidth; 0];
    
    %Let us figure out the dimensions of our new image. 
    NewSize = Transformation*([ImageSize(1);ImageSize(2);1] + Translation);
    
    
    %Create a new vector of all zeros. Don't worry about the point that we
    %just calculated yet. We use int64 type for the input to ensure
    %integers for the zeros function.
    NewImage = zeros(int64(NewSize(1)), int64(NewSize(2)), ImageSize(3), 'like', OriginalImage);
    
    
    %Now we can iterate over all of the pixels of the image. 
    for j = 1:ImageSize(1)
        OldLocation(1) = j;
        for k = 1:ImageSize(2)
            OldLocation(2) = k;
            NewLocation = (Transformation*(OldLocation + Translation));
            NewImage(int64(NewLocation(1)),int64(NewLocation(2)),:) = OriginalImage(j,k,:);
            %Again we use int64 type to make sure that the new matrix has
            %integer inputs. We are copying the color data from the old
            %pixel location to the new location in the new image. 
        end
    end
    
    figure,imshow(NewImage);
    %print the pictures.
end
