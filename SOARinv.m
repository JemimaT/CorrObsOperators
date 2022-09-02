
%Define a function to construct a SOAR matrix:
function [C]=SOARinv(n,L,a)
%,Cinv,evecs,evals
%Variables:
%n=number of points on the circle - I have been using 100 and 200
%theta=360/n; angle between each of the points
%L=lengthscale - typical values range between 0.1 and 0.5
%a=radius of circle -- good default value is 1

theta=2*pi/n; %calculates the angle between each adjacent point on the 
% circle for the value of n specified
%2*pi/n*(abs(i-l))
C=zeros(n,n);
for i=1:n
    for l=1:n
        %calculates the 'great circle' distance between the two points we
        %are looking at
        thetaj=theta*(abs(i-l));
        %calculates the matrix entry using the formula for a SOAR function
        C(i,l)=(1+abs(2*a*sin(thetaj/2))/L)*exp(-abs(2*a*sin(thetaj/2))/L);
    end
end

% This just calculates the eigenvalues using the definition for a circulant
% matrix - lambda is the matrix of eigenvalues
% For any nxn circulant matrix, the eigenvectors are the same, so I
% calculate these too - evecs is the matrix of eigenvectors. Note that it
% doesn't depend on the values in C!
cs=C(1,:); lambda=zeros([1,n]);evecs =zeros([n,n]);

for m=0:n-1
    for k=0:n-1
        lambda(m+1)=lambda(m+1)+cs(k+1)*exp(-2*pi*1i*m*k/n);
        evecs(m+1,k+1)=(((exp(-2*pi*1i*m*k/n))/sqrt(n)));
    end
end

end
