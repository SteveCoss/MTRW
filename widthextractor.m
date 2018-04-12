%ingest raw Riv_width data and convert to time location matrix of widths
clear all; close all; clc
%% user inputs
read = 0;
proxC = 1;
retrim = 0;
ICEoverride = 0;
polished = 0;%Xiaos version with widths already extracted 1= yes
Btwo=1;
SLfilter = 1;
% point to directory with width files
River = 'Congo';
readlocation = fullfile('C:\Users\coss.31\Documents\Work\Utility\Multi_temporal_river_widths\Raw\',River,'\unziped');
readlocationXiao = fullfile('C:\Users\coss.31\Documents\Work\Utility\Multi_temporal_river_widths\Raw\',River,'Xiao2018\unziped');
%% read in
tic
if read
    if polished
        Data = dir(readlocationXiao);%Xiaos version with widths already extracted
    else
        Data = dir(readlocation);
    end
%% check for ice and remove from Data list
[DoIce,icefile] = IceCheck(River)
switch polished
     case{0}
 
if DoIce 
    [Data] = filterGEEwithicelist(Data,icefile,polished);
end
%
for i = 1:length(Data);
   
    if Data(i).bytes > 0;
        filename = fullfile(readlocation,Data(i).name);
        status = xlsfinfo(filename);
        if ~strcmp('',status);
            [Extracted] = TWidesheetimporter (readlocation,Data(i).name,polished,Btwo);%read sheet
         
            [ValidExtracted] = IsItValid(Extracted);%check valid ==1
             Estat(i).Gratio = ValidExtracted.Gratio;
            [Widths(i).data,Estat(i).MW]= widthpull(ValidExtracted);
        end
        
    end
end
%% create one set of Width data
 Widths = [Widths(1:end).data];
%% package into matrix
[Widths] = Wstruct_to_dlm( Widths,polished);   
%% write filtered concatinated widths
fname = strcat(River,'_','WidthData.txt');
dlmwrite(fname,Widths);
     case {1}
         [Extracted] = TWidesheetimporter (readlocationXiao,Data(3).name,polished);%read sheet
         if ICEoverride==0
         [Widths] = filterGEEwithicelist(Extracted,icefile,polished);
         end
         %% package into matrix
         [Widths] = Wstruct_to_dlm( Widths,polished);
         %% write filtered concatinated widths
         fname = strcat(River,'_','WidthData.txt');
         dlmwrite(fname,Widths);
 end
else
fname = strcat(River,'_','WidthData.txt');
Widths = dlmread(fname,',');
end
fprintf('data read-')
toc

%% pull in Centerline, Check for proximity then add Flow D to proximal points
if proxC
    [CL] = centerlinepull(River);
    tic
    %[Wfinal] = ProxCheck(CL,Widths);
     [Wfinal] = ProxCheckV2(CL,Widths);
    toc
    %%save with dlmwrite for speed
    fname2 = strcat(River,'_','WidthDataFD.txt');
    dlmwrite(fname2,Wfinal);
else if retrim % used to take a second tighter pass on data
        fname2 = strcat(River,'_','WidthDataFD.txt');
        Widths = dlmread(fname2,',');
        [CL] = centerlinepull(River);
        
        tic
        [Wfinal] = ProxCheck(CL,Widths);
        toc
        %%save with dlmwrite for speed
        fname2 = strcat(River,'_','WidthDataFDr.txt');
        dlmwrite(fname2,Wfinal);
        
    else
        fname2 = strcat(River,'_','WidthDataFD.txt');
        Wfinal = dlmread(fname2,',');
    end
end
%% 1 km time series
[onekmTS] = WidthGridTS(Wfinal);
%% grid
[Wgrid] = TStoGRID(onekmTS);
%% save
 fname3 = strcat(River,'_','Widthgrid','3');
save(fname3,'Wgrid');