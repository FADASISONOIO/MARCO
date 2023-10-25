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

Pcm    = 500*(cm - 0.9*0.00315)^2/(0.1*0.00315)^2*(cm > 0.9*0.00315 && cm < 0.00315) + 500*(cm>=0.00315);

CDind = 100 * rc.CDtot + P3 * Peq + Pcm;

end

