function f= X_MLE(theta, Cst, data, xx, sr, sw) 
%   AEM 7500  PS #4 sub-program 2
%   This program/function is the obj funtion of the GMM which is called by 
%   the estimation function to compute the value of the obj function given
%   the value of the parameters.
N_ar= Cst.N_ar;
N_aw= Cst.N_aw;
a_r= Cst.a_r;
a_w= Cst.a_w;
T= Cst.T;

% theta(1): beta0
% theta(2): beta1r
% theta(3): beta2
% theta(4): beta3r
% theta(5): beta1w
% theta(6): beta3w
beta=[theta0(1) theta0(2) theta0(3) theta0(4) theta0(1) theta0(5) theta0(3) theta0(6)]';
zz= xx*beta;
tid= kron((1:length(zz)/N_ar)', ones(N_ar,1)); 
denom= accumarray(tid, exp(zz));
prob= exp(zz)./denom(tid);
prob_r= prob(1:T*3);
prob_w= prob(T*3+1:end);
sigma_r= reshape(prob_r, 3, T);
sigma_w= reshape(prob_w, 3, T);
sigma_hat=[sigma_r sigma_w];

y_r = ( ones(N_ar,1)*data(:,1)'== (a_r'*ones(1,T)) );
y_w = ( ones(N_aw,1)*data(:,2)'== (a_w'*ones(1,T)) );
y = [y_r y_w];


%% Part IV: Form likelihood function
f= -sum(log(prob).*y(:));
ttt = log(prob).*y(:);