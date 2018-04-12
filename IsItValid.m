%test fresh extraction for vaild argument

function [ValidExtracted] = IsItValid(Extracted);
if isfield(Extracted,'fmask_count');
V1 = []; V2 = []; V3 = [];
for i = 1:length (Extracted.Mlength)
    if Extracted.fmask(i) == 0;
        V1(i)=1;
    else
        V1(i)=0;
    end
    if Extracted.fmask_count(i) == 2;
        V2(i)=1;
    else
        V2(i)=0;
    end
    if  Extracted.waterMask_mean(i) < 1;
        V3(i) = 1;
        else
        V3(i)=0;
    end
    if (V1(i) + V2(i) + V3(i))==3;
        VALID(i)=1;
    else
        VALID(i)=0;
    end
end
goodval=find(VALID==1);

ValidExtracted.MLength= Extracted.MLength(goodval);
ValidExtracted.lat= Extracted.lat(goodval);
ValidExtracted.lon= Extracted.lon(goodval);
ValidExtracted.waterMask_mean= Extracted.waterMask_mean(goodval);
ValidExtracted.date= Extracted.date(goodval);
ValidExtracted.Gratio= length(goodval)/length(Extracted.lat)
else
    for i = 1:length (Extracted.MLength)
    if Extracted.any(i) ~= 0 && Extracted.any(i) ~=-9999;
        V1(i)=1;
    else
        V1(i)=0;
    end
    if Extracted.fsnow_mean(i) == 0;
        V2(i)=1;
    else
        V2(i)=0;
    end
    if  Extracted.fcloud_mean(i) == 0;
        V3(i) = 1;
        else
        V3(i)=0;
    end
    if (V1(i) + V2(i) + V3(i))==3;
        VALID(i)=1;
    else
        VALID(i)=0;
    end
end
goodval=find(VALID==1);

ValidExtracted.MLength= Extracted.MLength(goodval);
ValidExtracted.lat= Extracted.lat(goodval);
ValidExtracted.lon= Extracted.lon(goodval);
ValidExtracted.fwater_mean= Extracted.fwater_mean(goodval);
ValidExtracted.river_mean= Extracted.river_mean(goodval);
ValidExtracted.date= Extracted.date(goodval);
ValidExtracted.Gratio= length(goodval)/length(Extracted.lat)
end
end