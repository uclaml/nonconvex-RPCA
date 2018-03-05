function [X_hat,S_hat,distX,distS,objloss] = MC_PF(f_grad,Y,X_star,S_star,params)
[d1,d2]=size(Y);
%%%given parameters
salpha=params.salpha;
ssalpha=params.ssalpha;
p=params.p;
r=params.r;
T=params.T;
eta=params.eta;
eta1=params.eta1;
k=params.ks;
limitX=(salpha/params.a)^2;
limitS=ssalpha;
tau=params.tau;initialeta=params.initeta;initialeta1=params.initeta1;
rd=params.rd;
init=params.init;
tol=params.tol;
alpha=params.alpha;
gamma=params.gamma;
%%%%%
limit=[salpha,salpha];
%%Initialization
% Initialization1
if init==1
[U0,V0] = initialization_mc(Y,p,r,alpha,gamma);
U = projection(U0,limit(1));
V = projection(V0,limit(2));
S=projection_S(Y-U*V',ssalpha);
end
if init==2
% Initialization2
[U0,V0,S0] = initialization_gdmc(f_grad,Y,limitX,limitS,p,r,tau,initialeta,rd,k,initialeta1);
U = projection(U0,limit(1));
V = projection(V0,limit(2));
S=projection_S(S0,ssalpha);
end
distX = zeros(T,1);
distS= zeros(T,1);
objloss=zeros(T,1);
% Projected GD
for t = 1:T 
    % Calculate the gradient
    mat=f_grad(U*V'+S);
    nabla_U = mat * V + 0.5*U*(U'*U - V'*V);
    nabla_V = mat' * U + 0.5*V*(V'*V - U'*U);
    nabla_S=mat ;
    % Update
    U = projection(U - eta * nabla_U, limit(1)); 
    V = projection(V - eta * nabla_V, limit(2));
    S=projection_S(S - eta1 * nabla_S, ssalpha);
    S = Tproj_partial(S, gamma*p*alpha, gamma*p*alpha);
    S=full(S); 
    S=HT(S,k);
    distX(t) = norm(U*V'- X_star, 'fro')/sqrt(d1*d2);
    distS(t) = norm(S- S_star, 'fro')/sqrt(d1*d2);
    disp(distX(t));
    if(distX(t)<=tol)
        break;
    end
end
disp(t);
X_hat=U*V';
S_hat=S;