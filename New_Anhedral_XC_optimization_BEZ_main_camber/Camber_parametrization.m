function  Camber_parametrization(fac , n)

warning off

load profilo.mat main2

filename = ['main_' num2str(n) '.dat'];


    
    fid = fopen(filename , 'w');
    fprintf(fid , [filename '\n']);
    
    for ii = 1:length(main2)
        fprintf(fid, [num2str(main2(ii,1)) '   ' num2str(fac.*main2(ii,2)) ' \n']);
    end

    % plot(XCL , flip(dorso) , XCL , ventre , cle(:,1) , cle(:,2) ,'o', cte(:,1) , cte(:,2),'o');
    fclose(fid);




