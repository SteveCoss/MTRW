%remove files from
function[Data] = filterGEEwithicelist(Data,icefile,polished);
fname = fullfile('C:\Users\coss.31\Documents\MATH\Steves_final_Toolbox\AltimetryToolbox\MEaSUREsToolbox2016\IN',icefile)
[IceData] = ReadIceFile(fname);
    
%% finddate based on landsat ID 
if polished
    LLength = length(Data.date);
else
    LLength =length(Data);
end
for i = 1:LLength
    if Data(i).bytes>0
        if ~polished
            if Data(i).bytes>0
                YYYY = str2num(Data(i).name(10:13));
                DDD = str2num(Data(i).name (14:16));
                date = doy2date(DDD,YYYY);
                Data(i).LSCdate = date
            end
        end
        for j = 1: length(IceData)
            if polished
                if  Data.date(i) > IceData(j,2) && Data.date(i) < IceData(j,3);
                    
                    flag(j) = 1;
                else
                    flag(j) = 0;
                end
            else
                if Data(i).LSCdate > IceData(j,2) && Data(i).LSCdate < IceData(j,3);
                    flag(j) = 1;
                else
                    flag(j) = 0;
                end
            end
            if sum(flag)> 0
                ice(i) = 1;
            else
                ice(i) = 0;
            end
            clear flag
        end
    end
end
noicelogical = ice <1;
if polished
    Data.lat = Data.lat(noicelogical);
    Data.lon = Data.lon(noicelogical);
    Data.width = Data.width(noicelogical);
    Data.date = Data.date(noicelogical);
else
    Data = Data(noicelogical);
end
end

