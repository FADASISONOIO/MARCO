% planform optimization setup
% for reproducibility
rng default

% set number of optimization points (half-wing)
n                   = 10;

% set penalties values: P1, P2 chord decreasing and swept back wing
% solution. P3 wing planform inside surface tolerance
P1                  = 1000;
P2                  = 1000;
P3                  = 1000;

% function to minimize
ObjectiveFunction   = @(x) InducedDrag(x , P1 , P2 , P3);

% lower and upper bounds for optimization variables
nvars               = n;    % Number of variables
LB                  = [65  50   40   20  30     0    0       0  -2 -3];
UB                  = [110 100 90 30  80        0   0    0      0 0];
guess               = [90  80  60  22  50        0    0     0   -1 -2];

% % genetic algorithm optimization options
% opts              = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping});
% opts.PopulationSize = 5;
% % run genetic algorith optimization 
% [x,fval]          = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ...
%     [],opts)

% particle swarm optimization options 
options             = optimoptions('particleswarm','InitialSwarmMatrix', guess , 'PlotFcn','pswplotbestf','MinNeighborsFraction',1);
options.SwarmSize   = 15;

% run particle swarm optimization 
x                   = particleswarm(ObjectiveFunction,nvars,LB,UB,options)