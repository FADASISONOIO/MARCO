% Script to compute bouyancy parameters, x solution contains alpha and z
% information to determine the bouyancy line at any configuration of the
% hull. 

% create mesh from .stl file
model = createpde;
importGeometry(model , "scafo_sotto_v3_solid.STL")

% change mesh definition: results are almost indipendent from mesh quality
mesh = generateMesh(model , 'Hmax', 0.05);
pdemesh(mesh)

% Boat mass value [kg]
mass = 36.2;

% initialize alpha and h values
alfa = 0;
h = 0;
guess = [alfa h];

% Function to minimize to find solution
ObjectiveFunction   = @(x) Penaltyfcn(x , mesh , mass);

% Set lower and upper bound
LB = [-pi/6 ; -0.2];
UB = [pi/6 ; 0.3];

% particle swarm optimization options 
options             = optimoptions('particleswarm','InitialSwarmMatrix', guess , 'PlotFcn','pswplotbestf','MinNeighborsFraction',1);
options.SwarmSize   = 15;

% run particle swarm optimization to extract solution
x                   = particleswarm(ObjectiveFunction,2,LB,UB,options)

% to visualize the solution create a plane in solidworks with such
% parameters: inclination with respect to the horizon plane = x(1) [rad]
% displacement above the origin = x(2) [m]