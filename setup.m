close all;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%load underlying matrix X_star%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1=1000;d2=1000;
r  = 20;  % rank
alpha = 0.1; % sparsity of S* (expected)
N=1;
load(['./Data/U_' num2str(N) '_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '.mat']);
load(['./Data/V_' num2str(N) '_d1_' num2str(d1) '_d2_' num2str(d2) '_r_' num2str(r) '.mat']);
X_star=U0*V0';
% Calculate the incoherence and spectral norm of X_star
[mu,sigma1,kappa] = calc_para(X_star,r);
%get the support
p=1;%observation probability
%%%%%%%%%%%%%%%%%%%%%%%%generate underlying matrix S_star%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[S_star,supp]=generate_Sparse(U0,V0,p,alpha,r);
%%%%%%%%%Define measurement handle function%%%%%%%%%%%
A_id = @(z) Ai(z,supp);
%%%%%%%%%%%%%%%%%%%%%%%%set Obervation matrix%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%noise
%nu=1/sqrt(d1*d2);
%E=normrnd(0,nu,d1,d2).*supp;
Y=A_id(X_star+S_star);
%%%%%%%%%%Define gradient function and loss function for matrix completion%%%%%%%%%%%%%%%
f_grad = @(x) -1/p*(Y - A_id(x));
%%%%%%%%%%%%%%%%%%