v = [-0.0032    0.0679
    -0.5236    0.2935; 
    -0.0023    0.0428 ;
    -0.0040    0.0421;
    -0.0041    0.0428;
    ]
x = [0.24 0.2 0.1 0.07 0.04];
figure
plot(x , v(:,1) , x , v(:,2) ,'LineWidth', 2) 
hold on
plot(x , v(:,1) ,'*' ,x , v(:,2),'*')
xlabel('Maximum edge mesh length [m]' , 'interpreter', 'latex')
ylabel('Pitch [rad]  Transom submergence [m]' , 'interpreter', 'latex')
legend('Pitch' , 'Transom submergence')
