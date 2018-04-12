%ingest raw Riv_width data and convert to time location matrix of widths
clear all; close all; clc
%% user inputs
read = 0;
proxC =1;
% point to directory with width files
River = 'Mississippi';
readlocation = 'C:\Users\coss.31\Documents\Work\Utility\Multi_temporal_river_widths\Raw\Mississippi\Mississippi_unziped'
%% read in
if read
Data = dir(readlocation);
for i = 1:length(Data);
    
    if Data(i).bytes > 0;
        [Extracted] = TWidesheetimporter (readlocation,Data(i).name);%read sheet
        [ValidExtracted] = IsItValid(Extracted);%check valid ==1
         [Widths(i).data]= widthpull(ValidExtracted);
         
    end
end
%% create one set of Width data
 Widths = [Widths(1:end).data];
%% package into matrix
[Widths] = Wstruct_to_dlm( Widths);   
%% write filtered concatinated widths
fname = strcat(River,'_','WidthData.txt');
dlmwrite(fname,Widths);
else
fname = strcat(River,'_','WidthData.txt');
Widths = dlmread(fname,',');
end
%% pull in Centerline, Check for proximity then add Flow D to proximal points
if proxC
 [CL] = centerlinepull(River);
 tic
 [Wfinal] = ProxCheckE(CL,Widths);
 toc
 %%save with dlmwrite for speed
 fname2 = strcat(River,'_','WidthDataFD');
 dlmwrite(fname2,Wfinal);
else
 fname2 = strcat(River,'_','WidthDataFD');
Wfinal = dlmread(fname2,',');
end
%% 1 km time series
fprintf('onekm')
[onekmTS] = WidthGridTS(Wfinal);
%% grid
fprintf('grid')
[Wgrid] = TStoGRID(onekmTS);

%% save
 fname3 = strcat(River,'_','Widthgrid','2');
save(fname3,'Wgrid');