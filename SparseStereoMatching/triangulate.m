function [points3D] = triangulate (corsSSD , P1, P2) 
col = size (corsSSD ,1); 
a = ones (3 , col ); 
b = ones (3 , col ); 
points3D = zeros (col,4); 

r = zeros (4 ,4); 

a(1,:)=corsSSD(:,2)';
a(2,:)=corsSSD(:,1)';
b(1,:)=corsSSD(:,4)';
b(2,:)=corsSSD(:,3)';

for i=1:col
    skew1=[0 -a(3,i) a(2,i) ; a(3,i) 0 -a(1,i) ; -a(2,i) a(1,i) 0];
    skew2=[0 -b(3,i) b(2,i) ; b(3,i) 0 -b(1,i) ; -b(2,i) b(1,i) 0];    
    
    r1=skew1*P1;
    r2=skew2*P2;
    
    r(1,:)=r1(1,:);
    r(2,:)=r1(2,:);
    r(3,:)=r2(1,:);
    r(4,:)=r2(2,:);
    
    [u s v]=svd(r);
    
    points3D(i,:)=v(:,4)';
    
    points3D(i,:)=points3D(i,:)./points3D(i,4);
end

end
