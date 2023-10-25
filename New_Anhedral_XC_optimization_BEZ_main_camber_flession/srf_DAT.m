function srf_DAT(x)
span = 310;
noppoints = 200;

P = [-x(1) 0; -x(1) x(2) ; -x(5) 1/2*span ; -x(3) span ; -0.9*x(4) span];
[bezcurve, ~] = bezier_(P, noppoints , [] );
P2 = [0 0; 0.85*span x(6); 0.95*span x(11) ;span x(7)];
[~ , intcurveyy] = bezier_(P2, noppoints , bezcurve(:,2));

P3 = [0 0; 0.5*span 0; 0.85*span -x(8); 0.95*span -x(9) ; span -x(10)];
[~ , qrlc] = bezier_(P3, noppoints , bezcurve(:,2));
% P3 = [0 x(8) ; span/2 x(8) ; span x(9)];
% [~ , twist] = bezier_(P3 , noppoints , bezcurve(:,2));
chord = -1/0.9 * bezcurve(:,1);

% for ii = 1:length(intcurveyy)
%     intcurveyy(ii) = 0;
% %     qrlc(ii) = 0;
% end

file = [bezcurve(:,1) + qrlc , chord , bezcurve(:,2) , intcurveyy];



leading = 'leading_edge.txt';
trailing = 'trailing_edge.txt';

if isfile(leading)
    delete(leading);
end
if isfile(trailing)
    delete(trailing);
end

fidle = fopen(leading , 'w');
for ii = 1:noppoints
    fprintf(fidle, [num2str(bezcurve(ii,1) + qrlc(ii)) ' ' num2str(bezcurve(ii,2)) ' ' num2str(intcurveyy(ii)) ' \n']);
end
fclose(fidle);

fidte = fopen(trailing , 'w');
for ii = 1:noppoints
    fprintf(fidte, [num2str(bezcurve(ii,1) + qrlc(ii) + chord(ii)) ' ' num2str(bezcurve(ii,2)) ' ' num2str(intcurveyy(ii)) ' \n']);
end
fclose(fidte);
