function CDind = InducedDrag(x , P1 , P2 , P3)
span = x(11);

bezcurve = writeSurface(span/2 , x);

delete forces
delete StripForces

[status,result] = dos('avl.exe < optimization');
rc = parseRunCaseHeader('forces');
[~ , Peq] = ConstraintFunc(bezcurve);

[startRow1 ,endRow1] = StartEndRow('StripForces' , 35);
            
LUT = StripForces('StripForces' , startRow1 , endRow1);
            
cm     = sum((LUT.Area).*(LUT.cl).*(LUT.Yle));

cmlim = 1/0.9*150* 0.072*0.36/1300;

Pcm    = 500*(cm - 0.9*cmlim)^2/(0.1*cmlim)^2*(cm > 0.9*cmlim && cm < cmlim) + 500*(cm>=cmlim);

CDind = 100 * rc.CDtot + P3 * Peq + Pcm;

end

