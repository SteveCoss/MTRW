%importer for GEE-RivWidth csv imports
function [Extracted] = TWidesheetimporter (readlocation, infile,polished,Btwo)


%% Initialize variables.
filename = fullfile(readlocation,infile);
[NUM,TXT,RAW]=xlsread(filename);
S=size(TXT);
for i = 1:S(2);
    Header(i).header = TXT{1,i};
end
if polished
    for i = 1: length(Header);
        if strcmp(Header(i).header,'lat')
            latdx = (i);
            else if strcmp(Header(i).header,'lon')
                londx = (i);
                else if strcmp(Header(i).header,'date')
                datedx = (i);
                else if strcmp(Header(i).header,'width')
                widthdx = (i);
                    end
                    end
                end
        end
    end
Extracted.lat = NUM(:,latdx);
Extracted.lon = NUM(:,londx);
Extracted.width = NUM(:,widthdx);
for i = 1:length(TXT)-1;
Extracted.date(i) = datenum(cell2mat(TXT((i+1),datedx)));
end
else
    %look for fmask (old format)4.5.2018
    for i = 1:length(Header)
        if strcmp(Header(i).header,'fmask');
            Mcheck = 1;
        else 
            Mcheck = 0;
        end
    end
    if sum(Mcheck ==1);
   %% this is the old format
for i = 1: length(Header);
    if strcmp(Header(i).header,'system:index')
        sysindexdx = (i);
        
    else if strcmp(Header(i).header,'lat')
            latdx = (i);
            
        else if strcmp(Header(i).header,'lon')
                londx = (i);
                
            else if strcmp(Header(i).header,'fmask')
                    fmaskdx = (i);
                    
                else if strcmp(Header(i).header,'fmask_count')
                        fmaskctdx = (i);
                        
                    else if strcmp(Header(i).header,'waterMask_mean')
                            wmmeandx = (i);
                            
                        else if strcmp(Header(i).header,'MLength')
                                mlendx = (i);
%                                  else if strcmp(Header(i).header,'hillshade')
%                                      end
                                
                            end
                        end
                    end
                end
            end
        end
    end
end
  
    
                                    
%% Read columns of data 
% For more information, see the TEXTSCAN documentation.

Extracted.systemindex = NUM(:, sysindexdx);
Extracted.MLength = NUM(:, mlendx);
Extracted.lat = NUM(:,latdx);
Extracted.lon = NUM(:,londx);
Extracted.fmask = NUM(:,fmaskdx);
Extracted.fmask_count = NUM(:,fmaskctdx);
Extracted.waterMask_mean = NUM(:, wmmeandx);
 else %if no fmask then new data format
     for i = 1: length(Header);
    if strcmp(Header(i).header,'system:index')
        sysindexdx = (i);
        
    else if strcmp(Header(i).header,'lat')
            latdx = (i);
            
        else if strcmp(Header(i).header,'lon')
                londx = (i);
                
            else if strcmp(Header(i).header,'any')
                    anydx = (i);
                    
                else if strcmp(Header(i).header,'fsnow_mean')
                        fsnowmeandx = (i);
                        
                    else if strcmp(Header(i).header,'fcloud_mean')
                            fcloudmeandx = (i);
                            
                        else if strcmp(Header(i).header,'MLength')
                                mlendx = (i);
                                 else if strcmp(Header(i).header,'river_mean')
                                         rivermeandx = (i);
                                         else if strcmp(Header(i).header,'fwater_mean')
                                         fwatermeandx = (i);
                                     end
                                     end
                                
                            end
                        end
                    end
                end
            end
        end
    end
end
  
    
                                    
%% Read columns of data 
% For more information, see the TEXTSCAN documentation.

%Extracted.systemindex = cell2mat(RAW(2:end, sysindexdx));
Extracted.MLength =cell2mat(RAW(2:end, mlendx));
Extracted.lat = cell2mat(RAW(2:end,latdx));
Extracted.lon =cell2mat(RAW(2:end,londx));
Extracted.any = cell2mat(RAW(2:end, anydx));
Extracted.fsnow_mean = cell2mat(RAW(2:end, fsnowmeandx));
Extracted.fcloud_mean =cell2mat(RAW(2:end, fcloudmeandx));
Extracted.river_mean = cell2mat(RAW(2:end, rivermeandx));
Extracted.fwater_mean =cell2mat(RAW(2:end, fwatermeandx));
    end

%% add date based on landsat ID to export
YYYY = str2num(infile(10:13));
DDD = str2num(infile (14:16));
date = doy2date(DDD,YYYY);
Extracted.date=repmat(date,[length(Extracted.MLength),1]);
end
end

