function s = ImportFile(filename, startRow, endRow)
%IMPORTFILE1 Import numeric data from a text file as a matrix.
%   S = IMPORTFILE1(FILENAME)
%   Reads data from text file FILENAME for the default selection.
%
%   S = IMPORTFILE1(FILENAME, STARTROW, ENDROW)
%   Reads data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   s = importfile1('s', 1, 99);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2022/04/08 16:12:08

%% Initialize variables.
if nargin<=2
    startRow = 1;
    endRow = 99;
end

%% Format for each line of text:
%   column1: text (%s)
%	column2: text (%s)
%   column3: text (%s)
%	column4: text (%s)
%   column5: text (%s)
%	column6: text (%s)
%   column7: text (%s)
%	column8: text (%s)
%   column9: text (%s)
%	column10: text (%s)
%   column11: text (%s)
%	column12: text (%s)
%   column13: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%6s%9s%9s%9s%9s%9s%12s%7s%8s%9s%9s%9s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this code. If an error occurs for a different file, try regenerating the code from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Remove white space around all cell columns.
dataArray{1} = strtrim(dataArray{1});
dataArray{2} = strtrim(dataArray{2});
dataArray{3} = strtrim(dataArray{3});
dataArray{4} = strtrim(dataArray{4});
dataArray{5} = strtrim(dataArray{5});
dataArray{6} = strtrim(dataArray{6});
dataArray{7} = strtrim(dataArray{7});
dataArray{8} = strtrim(dataArray{8});
dataArray{9} = strtrim(dataArray{9});
dataArray{10} = strtrim(dataArray{10});
dataArray{11} = strtrim(dataArray{11});
dataArray{12} = strtrim(dataArray{12});
dataArray{13} = strtrim(dataArray{13});

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post processing code is included. To generate code which works for unimportable data, select unimportable cells in a file and regenerate the script.

%% Create output variable
s = [dataArray{1:end-1}];

