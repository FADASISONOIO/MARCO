function [Pin , Peq] = ConstraintFunc(bezcurve)
len         = size(bezcurve,1);

xx          = bezcurve(:,1);
ch          = bezcurve(:,2);
yy          = bezcurve(:,3);
zz          = bezcurve(:,4);

% computing surface area
diffy       = ((yy(1:end-1) - yy(2:end)).^2 + (zz(1:end-1) - zz(2:end)).^2).^0.5;
sumc        = abs(ch(1:end-1) + ch(2:end));

area        = diffy' * sumc;

% this section is not necessary anymore
diffx       = min(xx(2:len) - xx(1:len-1));
diffc       = min(ch(1:len-1) - ch(2:len));

PP1         = -1 * diffx * (diffx < 0);
PP2         = -1 * diffc * (diffc < 0);
Pin         = [PP1^2
       PP2^2];
   
Peq         = 1000*((area - 72000)*(area - 91000) > 0);
end