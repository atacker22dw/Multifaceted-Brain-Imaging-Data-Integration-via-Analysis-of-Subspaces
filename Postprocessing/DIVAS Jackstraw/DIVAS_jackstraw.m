function [F_feature,F_n,P] = DIVAS_jackstraw(Y,x,k,D,nran, nsim,ti);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APPROXIMATE ALGORITHM with diagnositic graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Y       datablock m*n
%  x       concatenated CNS for all subspaces including datablock Y
%          should be sum_pi x n dimensional 
%  k       number of component can be 1:k
%  D       rank of subspace in DIVAS
%  nran    number of random chosen row for each permutation
%  nsim    number of permutated satistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Y=D{1};x=outstruct.BSSindiv{1};
for i=1:length(x(:,1))
    x(i,:)=x(i,:)/norm(x(i,:));
end
n=length(Y(1,:));d=length(Y(:,1));
if length(nran)==0
nran=round(d/20);
end
if length(nsim)==0
nsim=500*d;
end
%B here is the loadings
B_1 = Y*x';
%this was sum p_i's in jans notation.  
p=length(x(:,1));
y_hat_1=B_1*x;
B_0 = B_1;
B_0(:, k)=[];
x_0 = x;
x_0(k, :)=[];
y_hat_0 = B_0*x_0;
%y_bar=mean(Y);
%sum across each row
SSE_1=sum((Y-y_hat_1).^2, 2);
SSE_0=sum((Y- y_hat_0).^2, 2);  
%this should be 1xd not 1xn
F_feature=((SSE_0-SSE_1)/(D))./ (SSE_1/(n-p)); 
%%%% F_n %%%%%
F_n=[];
%set a seed for paper reproducibility
%rng(4) 
rng(5)
for i=1:round(nsim/nran)
    %permute rows - features
    Y_per = Y;
    %Y_per=Y';
    index=randsample(d,nran);
   for j=1:length(index)
       Y_per(index(j),:)=Y_per(index(j), randperm(n));
       %Y_per(:,index(j))=Y_per(randperm(n),index(j));
 %%%% FULL ALGORITHM %%%%%%%%
 % 1. run AJIVE here using Y_per instead of original Y
 % 2. get the new CNS/BSS as x and recalculate X      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%           
   end
   B_1 = Y_per(index,:)*x';
   %B_1=Y_per(:,index)*x';
   y_hat_1=B_1*x;
   B_0 = B_1;
   B_0(:, k)=[];
   x_0 = x;
   x_0(k, :)=[];
   y_hat_0 = B_0*x_0;

%sum across each row
SSE_1=sum((Y_per(index,:)-y_hat_1).^2, 2);
SSE_0=sum((Y_per(index,:)-y_hat_0).^2, 2);  

F_n=[F_n ((SSE_0-SSE_1)/(D))./ (SSE_1/(n-p))];    
end
P=[];
for i=1:d
P=[P mean(F_feature(i)<F_n)];
end
%%%%%%%%%%%%%%%%%% draw pic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% draw pic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




