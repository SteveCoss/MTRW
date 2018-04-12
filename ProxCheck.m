function [Wfinal] = ProxCheck(CL,Widths);
%unpack CL
Xline = CL.Xline;
Yline = CL.Yline;
FD = CL.FD;
%% set aproximate decimal degree distance with average lat
Xmean = median(Xline);
Ymean = median (Yline);
[distkm,~] = lldistkm([Ymean Xmean],[(Ymean+.8) (Xmean+.8)]); 
Ddegree=sqrt((Xmean-(Xmean+.8)).^2 + (Ymean-(Ymean+.8)).^2 );
degreesperkm = Ddegree/distkm;
ddproxlimit = degreesperkm*2; %this means 2km
for i=1:length(Widths);
    %check lon for > 180
    if Widths(i,2)  > 180;
        Widths(i,2) = Widths(i,2) - 360;
    end
    D=sqrt((Widths(i,2)-Xline).^2 + (Widths(i,1)-Yline).^2 );
    [~,imin]=min(D);
    if min(D)< ddproxlimit; % was.2 got some extra
        Widths(i,5)=FD(imin);
        Index(i) = 1;
    else
        Index(i) = 0;
    end
    if Index(i)==1;
        Wfinal(i,:)= Widths(i,:);
    end
end
%% clear out Zeros
for i = 1:length(Wfinal);
if sum(Wfinal(i,:)) ~= 0
keep(i)=i;
end
end
gkeep = keep > 0;
keep = keep(gkeep);
Wfinal = Wfinal(keep,:);

end
