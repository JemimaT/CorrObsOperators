function [R,m] =  blockReff(pvec,pdist,pcorr)

% Create a block R matrix
% pvec - vector with the size of the blocks (sum == p)
% pdistribution - select correlation function for each block (currently only
% random is option but could extend to spatial rather than pseudo IC)
% pcorr - strength of correlation in each block 

% Ordering of blocks: from left to right/top to bottom of above diagonal blocks
% Then symmetrise the matrix



pnum = length(pvec);
p = sum(pvec);
pstart = ones([1,pnum+1]);
pstart(2:end) = cumsum(pvec(1:end))+1;
% generate block diagonals
R= 2*makeRICeff(p,pvec);
%Rtemp = (R+R');
% Make off diagonal blocks
val = 1; 
for inc = 1:pnum-1
    for inc2 = inc+1:pnum
        if pdist(val) == 1
            R(pstart(inc):pstart(inc+1)-1,pstart(inc2):pstart(inc2+1)-1) = pcorr(val)*sprand(pvec(inc),pvec(inc2),0.3);
        elseif pdist(val) == 2
            
        else
        end
        val = val+1;
        
    end
end

% make symmetric
R = R+R';
m = eigs(R,1,'sr');
%check PD and if not bump up diagonal
if m<=0
   R = R+(abs(m)+1e-2)*speye(p);
   %Rtemp = Rtemp+(abs(m)+1e-2)*speye(p);
end

end
