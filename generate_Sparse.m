function [S_star,supp]=generate_Sparse(U0,V0,p,alpha,r)
[d1,d2]=size(U0*V0');
ncol = floor(p*d1);
n  = d2*ncol;
I0 = zeros(n,1);
J0 = zeros(n,1);
X0 = zeros(n,1);
%
S0 = zeros(n,1);
%
for j=1:d2

    I0(((j-1)*ncol+1):j*ncol) = sort(randsample(d1,ncol));
    J0(((j-1)*ncol+1):j*ncol) = j;
    X0(((j-1)*ncol+1):j*ncol) = U0(I0(((j-1)*ncol+1):j*ncol),:)*V0(j,:)';
    %
    temp=X0;
    %
    IS   = randsample((j-1)*ncol+1:j*ncol,floor(alpha*ncol));
    X0(IS) = (r/sqrt(d1*d2)) * (rand(numel(IS),1)*5) .* sign(randn(numel(IS),1));
    %
    S0(IS)=X0(IS)-temp(IS);
    %

end
%
Y0 = sparse(I0,J0,X0,d1,d2);
supp=full(Y0);
supp(supp~=0)=1;
S_star=full(sparse(I0,J0,S0,d1,d2));
%
fprintf('%d x %d, %d observed, %d corrupted, rank %d\n', d1, d2, n, floor(alpha*n), r);
end