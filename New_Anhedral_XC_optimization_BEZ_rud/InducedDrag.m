function CDind = InducedDrag(x , P1 , P2 , P3)
span = 620;

bezcurve = writeSurface(span/2 , x);
[status,result] = dos('avl.exe < optimization');
rc = parseRunCaseHeader('forces');
[~ , Peq] = ConstraintFunc(bezcurve);
CDind = 100 * rc.CDtot + P3 * Peq;

end

