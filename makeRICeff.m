% create block R

function [R, Rinv] = makeRICeff(p,pvec,overlap)


if sum(pvec)>p
    % check overlap works
elseif sum(pvec)==p 
    % says where to start blocks
    overlap(1) = 1;
    for inc1 = 1:length(pvec)-1
        overlap(inc1+1) = overlap(inc1)+pvec(inc1);
    end
else
    %error because p<sum(pvec)
end

%generate random blocks
R = sparse(p,p);

for inc = 1:length(pvec)
    
    index = overlap(inc)+pvec(inc)-1;
    R(overlap(inc):index,overlap(inc):index) =...
        speye(pvec(inc))+5*sprand(pvec(inc),pvec(inc),0.8).*SOAReff_2_mono(pvec(inc),0.3,1,min(pvec(inc),200),1,0);   
    
   
end

%R = R+R';
% also generate inverse?


end
