function [F , M , V] = FMV_Bouyancy(mesh , mass , alfa , h)

% Extract nodes and nodes identification matrix from imported mesh
Nodes = mesh.Nodes;
Elements = mesh.Elements;

% Initialize Volume, Force and Moment
V = 0;
F = [0 0 0]';
M = [0 0 0]';

% water density and g value
rho = 998.8;
g = 9.81;

% bouyancy and gravity forces directions
Fdir = [-sin(alfa) 0   cos(alfa)]';
gdir = [ sin(alfa)  0 -cos(alfa)]';

% Location of the center of mass of the geometry
cm = 1e-3*[1590.97 -0.71 56.62]';

% Find the resultant bouyancy force as a sum of infinitesimate forces for
% each volume element of the mesh
for ii = 1 : size(Elements,2)

    % extract vertices coordinates for each thetraedra
    element = Elements( 1:4 , ii );
    points = Nodes(: , element);
    
    p1 = points(:,1);
    p2 = points(:,2);
    p3 = points(:,3);
    p4 = points(:,4);

    % Find location of the center of the thetraedra
    sum = (p1 + p2 + p3 + p4)/4;
    centroid = [sum(1,:) ; sum(2,:) ; sum(3,:)];
    
    % Compute Volume , Force and moment contribution only if the
    % infinitesimate volume is submerged 
    if centroid(3) < tan(alfa) * centroid(1) + h
        
        % Vectors representing the sides of each thetraedra
        l1 = p2 - p1;
        l2 = p3 - p1;
        l3 = p4 - p1;
        
        % Compute the volume of each thetraedra through mixed product
        Mat = [l1 l2 l3]';
        dV = abs(det(Mat))/6;

        % Infinitesimate force contribution
        dF  = (rho * g * dV) * Fdir;

        % Force application distance from center of mass
        b   = centroid - cm;
        
        % Infinitesimate moment contribution
        dM = cross(b , dF);

        % Integration to find submerged Volume, Force and cm Moment
        V = V + dV;
        F = F + dF;
        M = M + dM;
    end
    
end
F = F + g * mass * gdir;

