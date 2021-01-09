%---------------------------------------------------------------------%
%  Ant Colony Optimization (ACO) source codes demo version            %
%---------------------------------------------------------------------%


%---Inputs-------------------------------------------------------------
% feat     : feature vector (instances x features)
% label    : label vector (instances x 1)
% N        : Number of ants
% max_Iter : Maximum number of iterations
% alpha    : Coefficient control tau
% beta     : Coefficient control eta
% tau      : Initial tau
% eta      : Initial eta
% rho      : Pheromone

%---Outputs------------------------------------------------------------
% sFeat    : Selected features
% Sf       : Selected feature index
% Nf       : Number of selected features
% curve    : Convergence curve
%----------------------------------------------------------------------


%% Ant Colony Optimization 
clc, clear, close 
% Benchmark data set 
load ionosphere.mat; 

% Set 20% data as validation set
ho = 0.2; 
% Hold-out method
HO = cvpartition(label,'HoldOut',ho);

% Parameter setting
N        = 10; 
max_Iter = 100;
tau      = 1;
alpha    = 1; 
rho      = 0.2;
beta     = 0.1; 
eta      = 1;

% Ant Colony Optimization 
[sFeat,Nf,Sf,curve] = jACO(feat,label,N,max_Iter,tau,eta,alpha,beta,rho,HO);

% Plot convergence curve
plot(1:max_Iter,curve);
xlabel('Number of Iterations');
ylabel('Fitness Value'); 
title('ACO'); grid on;





