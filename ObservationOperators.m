% generate simple observation operators 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% observation operators
% p = number of observations
% N = number of state variables

N = 1000;
p = 400;


%%% direct observations

%%% land-sea (first p states are observed)
H1 = eye([p,N]);

%%% random observations
vec=randperm(N);
vecsort = sort(vec(1:p));
H2 = sparse([1:p],vecsort,ones([1,p]),p,N);


%%% indirect observations (smoothed over multiple state variables)
% simple representation of weighting function type approach

%smoothed observations based on alternate state variables
vecsort = (1:2:N);
H3 = zeros([p,N]);
for i = 1:p
    
    j = vecsort(i)-2;
    if j<1
        H3(i,1:j+4) = 1/5*(ones([1,j+4]));
        H3(i,N+j:end) = 1/5*ones([1,1-j]);
    elseif j>N-5
        
        H3(i,j:end) = 1/5*ones([1,N-j+1]);
        H3(i,1:j+4-N) = 1/5*(ones([1,j+4-N]));
    else
        H3(i,j:j+4) = 1/5*ones([1,5]);
    end
    %H = sparse([1:p],vecsort,ones([1,p]),p,N);
end
% smoothed observations based on random state variables
vec=randperm(N); 
vecsort = sort(vec(1:p));

H4 = zeros([p,N]);
for i = 1:p
    
    j = vecsort(i)-2;
    if j<1
        H4(i,1:j+4) = 1/5*(ones([1,j+4]));
        H4(i,N+j:end) = 1/5*ones([1,1-j]);
    elseif j>N-5
        
        H4(i,j:end) = 1/5*ones([1,N-j+1]);
        H4(i,1:j+4-N) = 1/5*(ones([1,j+4-N]));
    else
        H4(i,j:j+4) = 1/5*ones([1,5]);
    end
    %H = sparse([1:p],vecsort,ones([1,p]),p,N);
end