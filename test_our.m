addpath('./PROPACK') 
addpath('./MinMaxSelection')
%%step size, projection parameter
a=5;
k=0.8;
k1=1.5;
tol=1*10^(-3);
tol1=1*10^(-3);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%tuning parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params.T=1000;                              %Gradient iteration number                      
params.rd=1;                                %Initialization settings (ignore)
params.init=2;                              %Initialization choice:1.1step;2;ours;3.random
params.tau=1;                               %Initialization iteration number
params.ks=sum(sum(S_star~=0));              %Hard thresholding parameter
params.initeta=0.5;                         %Initialization step size for low rank
params.initeta1=0.5;                        %Initialization step size for sparse
params.eta=k/sigma1;                        %Gradient step size for low rank
params.eta1=k1/kappa^2;                     %Gradient step size for sparse
params.a=a;                                 %tuning parameter a
params.salpha=a*sqrt(max(max(abs(X_star))));%projection parameter in Gradient phase for low rank
params.ssalpha=1*max(max(abs(S_star)));     %projection parameter in Gradient phase for low rank
params.p=p;                                 %observation probability
params.r=r;                                 %rank
params.tol=tol1;                            %tolerance error
params.gamma=2;                             %corruption fraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X_hat1,S_hat,distX,distS,loss] = MC_PF(f_grad,Y,X_star,S_star,params);