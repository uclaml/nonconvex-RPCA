function [U0,V0,S0] = initialization_gdmc(f_grad,Y,limitX,limitS,p,r,tau,initialeta,rd,k,initialeta1)
[d1,d2] = size(Y);
if rd==0
X0=zeros(d1,d2);
S0=zeros(d1,d2);
end
if rd==1
[U0,V0] = initialization_mc(Y,p,r);
X0=U0*V0';
S0=Y-U0*V0';
end
%gd initialization
%step size
eta=initialeta;
eta1=initialeta1;
for t = 1:tau 
    % Calculate the gradient
    mat=f_grad(X0+S0);
    nablaX = mat;
    nabla_S=mat ;
    %update
    X0=projection(X0-eta*nablaX, limitX); 
    %S0=projection_S(S0 - eta1 * nabla_S, limitS);
    S0=S0 - eta1 * nabla_S;
    %Hardthreshold+T_ra
    %S0 = Tproj_partial(S0, 3*p*alpha, 3*p*alpha);
    %S0=full(S0);
    S0=HT(S0,k);
    %X0=X0-eta*nablaX; 
    %rank-r projection
   [U,Sigma,V] = svds(X0,r);
   Sigma = sqrt(Sigma);
   U0=U*Sigma;
   V0=V*Sigma;
   X0=U0*V0';
   %disp(norm(X0- X_star, 'fro'));
   %disp(norm(S0- S_star, 'fro'));
end

end