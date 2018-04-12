%why dont they make it?
clear all; close all; clc;
p = 24;
r = 33;
%% what path an row are we checkng?
readlocation = 'C:\Users\coss.31\Documents\Work\Utility\Multi_temporal_river_widths\Raw\Mississippi\Mississippi_unziped'
%% read in
data = dir(readlocation);
keep = [];
for i = 1:length(data);
    if data(i).bytes > 0;
    if str2double(data(i).name(4:6)) == p && str2double(data(i).name(7:9))== r
        keep(length(keep)+1) = i;
    end
    end
end
M = []
dlmwrite('whatswrong.txt',M);

for i = 1:length(keep);
    M = []
    i
    [Extracted] = TWidesheetimporter (readlocation,data(keep(i)).name);%read sheet
        [ValidExtracted] = IsItValid(Extracted);%check valid ==1
        M(:,1)= ValidExtracted.lat;
         M(:,2)= ValidExtracted.lon;
         dlmwrite('whatswrong.txt',M,'-append');
end