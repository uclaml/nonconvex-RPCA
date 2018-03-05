function [U0,V0] = initialization_mc(Y,p,r,alpha,gamma)

% [A,Sigma,B] = svds(Y/p,r);
% Sigma = sqrt(Sigma);
% 
% U0=A*Sigma;
% V0=B*Sigma;
% Initial sparse projection

[U,Sig,V] = lansvd(Y/p,r,'L');
U0 = U(:,1:r) * sqrt(Sig(1:r,1:r));
V0 = V(:,1:r) * sqrt(Sig(1:r,1:r));


end

