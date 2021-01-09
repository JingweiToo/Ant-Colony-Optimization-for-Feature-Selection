
function [sFeat,Nf,Sf,curve] = jACO(feat,label,N,max_Iter,tau,eta,...
  alpha,beta,rho,HO)

% Objective function
fun  = @jFitnessFunction; 
% Number of dimensions
dim  = size(feat,2); 
% Initial Tau & Eta 
tau  = tau * ones(dim,dim);
eta  = eta * ones(dim,dim);
% Pre
fitG = inf;
fit  = zeros(1,N);

curve = inf;
t = 1; 
%---Iterations start--------------------------------------------------
while t <= max_Iter
	% Reset ant
	X = zeros(N,dim); 
	for i = 1:N
    % Random number of features
    num_feat = randi([1,dim]);
    % Ant start with random position
    X(i,1)   = randi([1,dim]); 
    k        = [];
    if num_feat > 1
      for d = 2:num_feat
        % Start with previous tour
        k      = [k(1:end), X(i, d-1)];
        % Edge/Probability Selection 
        P      = (tau(k(end),:) .^ alpha) .* (eta(k(end),:) .^ beta); 
        % Set selected position = 0 probability 
        P(k)   = 0; 
        % Convert probability 
        prob   = P ./ sum(P(:)); 
        % Roulette Wheel selection
        route  = jRouletteWheelSelection(prob);
        % Store selected position to be next tour
        X(i,d) = route;
      end
    end
  end
  
  % Binary
  X_bin = zeros(N,dim);
  for i = 1:N
    % Binary form
    ind           = X(i,:); 
    ind(ind == 0) = []; 
    X_bin(i,ind)  = 1;
  end
  
  % Fitness 
  for i = 1:N
    fit(i) = fun(feat,label,X_bin(i,:),HO);
    % Global update
    if fit(i) < fitG
      Xgb  = X(i,:);
      fitG = fit(i);
    end
  end
  
%---// [Pheromone update rule on tauK] //
  tauK = zeros(dim,dim); 
  for i = 1:N
    % Update Phromones
    tour = X(i,:); 
    tour(tour == 0) = []; 
    % Number of features
    len_x = length(tour); 
    tour  = [tour(1:end), tour(1)];
    for d = 1:len_x
      % Feature selected on graph
      x = tour(d); 
      y = tour(d + 1);
      % Update delta tau k on graph 
      tauK(x,y) = tauK(x,y) + (1 / (1 + fit(i)));
    end
  end
  
%---// [Pheromone update rule on tauG] //
  tauG = zeros(dim,dim);
  tour = Xgb; 
  tour(tour == 0) = [];
  % Number of features 
  len_g = length(tour); 
  tour  = [tour(1:end), tour(1)];
  for d = 1:len_g
    % Feature selected on graph 
    x = tour(d); 
    y = tour(d + 1);
    % Update delta tau G on graph 
    tauG(x,y) = 1 / (1 + fitG); 
  end
  
%---// Evaporate pheromone // 
  tau = (1 - rho) * tau + tauK + tauG; 
  % Save
  curve(t) = fitG; 
  fprintf('\nIteration %d Best (ACO)= %f',t,curve(t))
  t = t + 1;
end
% Select features based on selected index
Sf    = Xgb; 
Sf(Sf == 0) = []; 
sFeat = feat(:,Sf); 
Nf    = length(Sf);
end


function Index = jRouletteWheelSelection(prob)
C = cumsum(prob);
P = rand();
for i = 1:length(C)
	if C(i) > P
    Index = i;
    break;
  end
end
end       

