% planform optimization setup
% for reproducibility
rng default

% set number of optimization points (half-wing)
n                   = 5;

% set penalties values: P1, P2 chord decreasing and swept back wing
% solution. P3 wing planform inside surface tolerance
P1                  = 1000;
P2                  = 1000;
P3                  = 1000;

% function to minimize
ObjectiveFunction   = @(x) InducedDrag(x , P1 , P2 , P3);

% lower and upper bounds for optimization variables
nvars               = 2*n;    % Number of variables
lbx                 = zeros(n,1);
ubx                 = 100*ones(n,1);
%lbc                = linspace(150 , 0 , n)';
lbc                 = 10*ones(n,1);
ubc                 = 130*ones(n,1);
x0                  = vertcat(lbx , ubc);

% strcat of lower and upper bounds
LB                  = vertcat(lbx , lbc);
UB                  = vertcat(ubx , ubc);

% genetic algorithm optimization options
% opts              = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
% opts.PopulationSize = 5;
% run genetic algorith optimization 
% [x,fval]          = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ...
%     [],opts)

% particle swarm optimization options 
options             = optimoptions('particleswarm','PlotFcn','pswplotbestf','MinNeighborsFraction',1);
options.SwarmSize   = 15;

% run particle swarm optimization 
x                   = particleswarm(ObjectiveFunction,nvars,LB,UB,options)