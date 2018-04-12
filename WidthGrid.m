%take Width data and format into a time/flow distance grid
function [onekmTS] = WideGrid(Wfinal);
FDZ=unique(Wfinal(:,5));%unique flow distances
% package each unique locations data
for i = 1:length(FDZ)
    curloc = find(Wfinal(:,5)== FDZ(i));
    Location(i).data = Wfinal(curloc,:);
end
%time sort unique FD groups by time
for i = 1 : length(Location);
    Location(i).data = sortrows(Location(i).data,3);
end
%group into 1 km sections
onekm = min(FDZ):1000: max(FDZ);
k=2;
p=1;
for i = 1:length(Location);
    
if Location(i).data(1,5) <= onekm(k) && Location(i).data(1,5) >= onekm(k-1);

    KM(k-1).data(p).data = Location(i).data;
    p=p+1;
else
    k=k+1;
    p=1;
end
% average 1km sections at each t
for i = 1: length(KM)
    thisKM = [KM(i).data];
    T = thisKM.data(:,3);
    Ts = unique(T);
    for j= 1:length(Ts);
    thisT = find(T == Ts(j));
    thisTsWs = thisKM.data(thisT,4);
    avW(j) = nanmean(thisTsWs);
    end
    onekmTS(i).t = Ts;
    onekmTS(i).w = avW;
end
    
    

end
potato = 1;