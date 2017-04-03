NaiveFacialRecognition.m uses a naive approach to facial recognition. 

KnnFacialRecognition.m uses a similar approach, but compares it to the K nearest neighbors rather than simply the nearest neighbor. 

The method is as follows: 
Load a training set of (cropped) faces and identifiers so that the program has a reference of what each person should look like. 
Load a new set of (cropped) faces, and compare each pixel of the noew image to the pixel in the same location in each of the 
training images. Sum up the error across all pixels in the image. The training image with the least error is selected as the best match. 
For the K Nearest Neighbors, the K lowest error images are considered. The neighbor with the most votes out of these K matches is 
declared the winner. If some neighbors have the same number of votes, then the lowest error is used as a tie-breaker. 

Eigenfaces and Fisherfaces are calculated in the EigenTrain and EigenTest and FisherTrain and FisherTest programs. The Train programs take
the training faces as an input, and the Test programs compare the test set to the training set. These methods have higher accuracy,
especially as the angle of light increases. High angles of light have large shadows that are hard to recognize, but these algorithms 
work well. 
