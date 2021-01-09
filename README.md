# Ant Colony Optimization for Feature Selection

![Wheel](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/ee9f059d-357b-4a8c-9fe0-c9d1bae01afc/403e87d0-5cb1-4e33-a883-e099809f938a/images/1600411474.JPG)

## Introduction
* This toolbox offers ant colony optimization method ( ACO )  
* The < Main.m file > illustrates the example of how ACO can solve the feature selection problem using benchmark data-set


## Input
* *feat*     : feature vector ( Instances *x* Features )
* *label*    : label vector ( Instances *x* 1 )
* *N*        : number of ants
* *max_Iter* : maximum number of iterations
* *alpha*    : coefficient control tau
* *beta*     : coefficient control eta
* *tau*      : initial tau
* *eta*      : initial eta
* *rho*      : pheromone


## Output
* *sFeat*    : selected features
* *Sf*       : selected feature index
* *Nf*       : number of selected features
* *curve*    : convergence curve


### Example
```code
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
```


## Requirement
* MATLAB 2014 or above
* Statistics and Machine Learning Toolbox

