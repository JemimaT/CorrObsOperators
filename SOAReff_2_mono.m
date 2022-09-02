
%Define a function to construct a SOAR matrix:
function [C]=SOAReff_2_mono(n,L,a,maxval,multval,ridgeval,checkval)
%Variables:
%n=number of points on the circle - I have been using 100 and 200
%L - lengthscale
%a - dimension of circle about which points are distributed
%maxval - bandwidth given by 2*(maxval-1)
%multval - multiplication factor applied to SOAR component
%ridgeval - additive inflation of diagonal
%checkval - if equal to 1 inflates matrix to guarantee positive
%definiteness (warning, this can be costly for large N as the smallest
%eigenvalue must be computed)


theta=pi/(maxval); %calculates the angle between each adjacent point on the 
% circle for the value of n specified
%2*pi/n*(abs(i-l))
v = sparse(1,n);
vtemp = zeros([1,maxval]);
for l=1:maxval
    %calculates the 'great circle' distance between the two points we
    %are looking at
    thetaj=theta*(abs(1-l));
    %calculates the matrix entry using the formula for a SOAR function
    vtemp(l)=multval*((1+abs(2*a*sin(thetaj/2))/L)*exp(-abs(2*a*sin(thetaj/2))/L));
end
vtemp(1) = vtemp(1)+ridgeval;
v(1:maxval) = vtemp;
v(end:-1:end-maxval+2) = vtemp(2:end);

%C = gallery('circul',v);
C =  sptoeplitz([v(1) fliplr(v(2:end))], v);
if C(1,2)-C(2,1)~=0
    C = C+C';
end
%
if checkval ==1 
    cval = eigs(C,1,'sm');
    cval = min(eig(full(C)));
    
    if cval<0
        C = C+(abs(cval)+0.5*rand)*speye(n);
    end
end
end
