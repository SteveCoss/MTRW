function [Wfinal] = ProxCheckE(CL,Widths);
%unpack CL
Xline = CL.Xline;
Yline = CL.Yline;
FD = CL.FD;
%check lon for > 180
    REREF=Widths(:,2)  > 180;
    lons = Widths(:,2);
    lons(REREF) = lons(REREF)-360;
    Widths(:,2) = lons;
for i=1:5000%length(Widths);
    D=sqrt((Widths(i,2)-Xline).^2 + (Widths(i,1)-Yline).^2 );
    [~,imin]=min(D);
    if min(D)<.15% was.2 got some extra
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
Index=Index>0;
dxvec = 1:1:length(Index);
dx = dxvec(Index);

Wfinal = Wfinal(dx,:);

end
