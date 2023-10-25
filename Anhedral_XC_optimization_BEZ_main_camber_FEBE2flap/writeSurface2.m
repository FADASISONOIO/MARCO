function file = writeSurface2(x)
span = x(11)/2;
noppoints = 20;
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

file = [bezcurve(:,2) , chord ,  2.51*camb , 30./chord];
dlmwrite(['tabella.txt'] ,file , 'delimiter','\t','newline','pc','precision',13); 

for ii = 1:noppoints
    f = importfile1(['Foil_FEBE/f' num2str(ii) 'g.dat']);
    xvect = bezcurve(ii,1).*ones(size(f(:,1))) + chord(ii).*(f(:,1)+0.1*ones(size(f(:,1))));
    num = 0;
    for tt = 1:length(xvect)
        if num == 0 && xvect(tt)<0.1
            val = tt;
            num = 1;
        end
    end

    yvect = ones(size(f(:,2)))*bezcurve(ii,2);
    zvect = chord(ii).*(f(:,2)-ones(size(f(:,2)))*f(val,2));
    dlmwrite(['Foil_FEBE/CAD/spl' num2str(ii) '.txt'] , [xvect , yvect , zvect] , 'delimiter','\t','newline','pc','precision',13); 
end
for ii = 1:1
    f = importfile1(['Foil_FEBE/optfoil24.dat']);
    xvect = -96.*ones(size(f(:,1))) + 160.*(f(:,1));
    num = 0;
    for tt = 1:length(xvect)
        if num == 0 && xvect(tt)<0.1
            val = tt;
            num = 1;
        end
    end

    yvect = ones(size(f(:,2)))*bezcurve(ii,2);
    zvect = 160.*(f(:,2)-ones(size(f(:,2)))*f(val,2));
    dlmwrite(['Foil_FEBE/CAD/bulb' num2str(ii) '.txt'] , [xvect , yvect , zvect] , 'delimiter','\t','newline','pc','precision',13); 
end
    

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


for ii = 1:noppoints
    Camber_parametrization(camb(ii) , ii)
    fprintf(fid,'SECTION \n');
    fprintf(fid, [num2str(bezcurve(ii,1) + qrlc(ii)) ' ' num2str(bezcurve(ii,2)) ' 0 ' num2str(chord(ii)) ' 0 \n']); 
    fprintf(fid, ['AFILE\n main_' num2str(ii) '.dat\n\n']);
end

fclose(fid);
