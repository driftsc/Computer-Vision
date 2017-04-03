function [largestEigenVec] = eigenSort(eigenVector, eigenValue, k)
%Sort the eigenvectos based on the largest eigenvalues. 

length = size(eigenValue, 1);
order = zeros(length,2);

%Find diagonal values of eigenmatrix, and order them in column 2
for i = 1:length
    order(i,1) = eigenValue(i,i);
    order(i,2) = i;
end

%Sort them based on size of eigenvalue, then put the largest one on top. 
order = sortrows(order);
order = flipud(order);

%reorder the eigenvectors based on the eigenvalue size
eigenVector = eigenVector(:,order(:,2));

%Take the largest K eigenvectors. Return as column vectors. 
largestEigenVec = zeros(length, k);
largestEigenVec = eigenVector(:,1:k);

end

