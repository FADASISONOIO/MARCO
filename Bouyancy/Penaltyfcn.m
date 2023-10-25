function P = Penaltyfcn(x , mesh , mass)

[F , M , V] = FMV_Bouyancy(mesh , mass , x(1) , x(2));

P = norm(F)^2 + norm(M)^2;
end
