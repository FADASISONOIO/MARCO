function [startRow1 , endRow1] = StartEndRow(filename , nVortex)

file = ImportFile(filename);
i=1;
k = 0;
while i<length(file)
    str = char(file(i));
    header = regexpi(str, 'j');
    if(length(header)>0) && k == 0
        startRow1 = i+1;
        k = 1;
    elseif (length(header)>0) && k ~= 0
        startRow2 = i+1;
    end
    i = i+1;
end
endRow1 = startRow1 + nVortex -1;
