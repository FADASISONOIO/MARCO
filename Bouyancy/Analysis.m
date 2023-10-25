cm  = [1990 1890 1790 1690 1590];
alpha = [-1.57 -1.064 -0.6180 -0.1735 0.2346];
hdisp = [-0.0087 0.0062 0.0189 0.0312 0.0427];
figure
plot(cm , alpha , 'linewidth' , 2)
xlabel('CM location [mm]' , 'interpreter', 'latex')
ylabel('Equilibrium pitch angle [Deg]' , 'interpreter', 'latex')
figure
plot(cm , hdisp ,'LineWidth', 2)
xlabel('CM location [mm]' , 'interpreter', 'latex')
ylabel('Lower transom point submergence [m]' , 'interpreter', 'latex')