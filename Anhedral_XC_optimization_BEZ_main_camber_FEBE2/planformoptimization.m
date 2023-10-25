clc
clear
x = zeros(10,1);
z = linspace(0,9,10);
ii = 1;
cord = 200 * ones(10,1);
for k = 20:1:30
    x1 = x + k*z';
    CDind(ii) = InducedDrag(vertcat(x1 , cord));
    ii = ii+1;
end
%%
j = 20:1:30;
plot(j,CDind);
%%
k = 24;
x1 = x + k*z';
CDin = InducedDrag(vertcat(x1 , cord));

