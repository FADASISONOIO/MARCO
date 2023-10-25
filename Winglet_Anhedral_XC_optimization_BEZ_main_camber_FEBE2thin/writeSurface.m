function file = writeSurface(span,x)
noppoints = 14;
P = [-x(1) 0; -x(1) x(2) ; -x(5) 1/2*span ; -x(3) 0.75*span ; -0.7*x(4) span];
[bezcurve, ~] = bezier_(P, noppoints , [] );
% P2 = [0 0; 0.85*span x(6); 0.95*span x(11) ;span x(7)];
% [~ , intcurveyy] = bezier_(P2, noppoints , bezcurve(:,2));


P3 = [0 0; 0.2*span 0; 0.5*span -x(6); 0.7*span -x(7) ; span -x(8)];
[~ , qrlc] = bezier_(P3, noppoints , bezcurve(:,2));
P2 = [0 x(9);span/3 x(9) ; 0.7*span x(10) ;span 0.8 ];
[~ , camb] = bezier_(P2 , noppoints , bezcurve(:,2));
chord = -1/0.7 * bezcurve(:,1);
% chord = 70.*(1-bezcurve(:,2).^2./span^2).^0.5;
% bezcurve(:,1) = -1*chord;
% for ii = 1:length(intcurveyy)
%     intcurveyy(ii) = 0;
% %     qrlc(ii) = 0;
% end
intcurveyy = zeros(size(bezcurve(:,2)));

file = [bezcurve(:,1) + qrlc , chord , bezcurve(:,2) , intcurveyy];



filename = 'optsurface.avl';
if isfile('forces')
    delete('forces');
end
if isfile(filename)
    delete(filename);
end
fid = fopen(filename , 'w');
fprintf(fid,'Planform\n#Mach\n0\n\n0 0 0\n\n0.072 0.0685 1.05\n\n0.0 0.0 0.0\n\nSURFACE\nMain\n10 -2 35 -2.8\n\nCOMPONENT\n1\n\nYDUPLICATE\n0.0\n\nSCALE\n0.001 0.001 0.001\n\nTRANSLATE\n0.0 0.0 0.0\n\nANGLE\n0\n\nCDCL\n-0.35 0.013 0.35 0.011 0.7 0.013\n\n');



for ii = 1:noppoints
    Camber_parametrization(camb(ii) , ii)
    fprintf(fid,'SECTION \n');
    fprintf(fid, [num2str(bezcurve(ii,1) + qrlc(ii)) ' ' num2str(bezcurve(ii,2)) ' 0 ' num2str(chord(ii)) ' 0 \n']); 
    fprintf(fid, ['AFILE\n main_' num2str(ii) '.dat\n\n']);
end
    fprintf(fid,'SECTION \n');
    fprintf(fid, [num2str(bezcurve(ii,1) + qrlc(ii)) ' ' num2str(bezcurve(ii,2)+15) ' 30 ' num2str(chord(ii)*0.5) ' 0 \n']); 
    fprintf(fid, ['AFILE\n main_' num2str(ii) '.dat\n\n']);
fclose(fid);
