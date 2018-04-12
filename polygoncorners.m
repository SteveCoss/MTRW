function [PC]=polygoncorners(Xline,Yline,i,MeanW)
Wflt= MeanW ;%this is how far off center line the box extents go

P0 = [Yline(i-1), Xline(i-1)];%trailing point
Pi = [Yline(i), Xline(i)];%point i
P1 = [Yline(i+1), Xline(i+1)];%leading point
D01 =sqrt((P1(2)-P0(2)).^2 +(P1(1)-P0(1)).^2);%distance from leading and trailing point
if D01 > Wflt
    D01 = Wflt;
end
Ld = .55*D01;
if Ld> .4*Wflt;
    Ld = .4*Wflt;
end

Pgon.TP(1,1) = Pi(1)-(Ld*(Pi(1)-P0(1))/D01);%trailing point box extent
Pgon.TP(1,2) = Pi(2)-(Ld*(Pi(2)-P0(2))/D01);
Pgon.TP = [Pgon.TP(1,1), Pgon.TP(1,2)];
Pgon.LP(1,1) = Pi(1)-(Ld*(Pi(1)-P1(1))/D01);
Pgon.LP(1,2) = Pi(2)-(Ld*(Pi(2)-P1(2))/D01);%leading point box extent
Pgon.LP =[Pgon.LP(1,1), Pgon.LP(1,2)];
%%  find perpindicular line to the line between LP/TP and pi
%perpendicular at LP with Pi
coeffs = polyfit([Pgon.LP(2), Pi(2)],[Pgon.LP(1), Pi(1)], 1);
Pslope = -1/coeffs(1);
%y ? y1 = m(x ? x1) use point slope formula to generate line centered
%around LP
XXl = linspace (Pgon.LP(2)-Wflt*2,Pgon.LP(2)+Wflt*2,Wflt*10);
YYl= Pslope*(XXl-Pgon.LP(2))+Pgon.LP(1);
% find xx/yy closest to 500m from LP

[blorp MidL]=min(abs(XXl-Pgon.LP(2)));
[beep boop] =min (abs(Wflt-(sqrt((XXl(MidL+1:end)-Pgon.LP(2)).^2 + (YYl(MidL+1:end)-Pgon.LP(1)).^2 ))));
dx=MidL:length(XXl);
Pgon.LPc1 = [YYl(dx(boop)),XXl(dx(boop))];
[beep boop] =min (abs(Wflt-(sqrt((XXl(1:MidL-2)-Pgon.LP(2)).^2 + (YYl(1:MidL-2)-Pgon.LP(1)).^2 ))));
dx=1:MidL-1;
Pgon.LPc2 =  [YYl(dx(boop)),XXl(dx(boop))];
%% perpendicular at TP with Pi
coeffs = polyfit([Pgon.TP(2), Pi(2)],[Pgon.TP(1), Pi(1)], 1);
Pslope = -1/coeffs(1);
%y ? y1 = m(x ? x1) use point slope formula to generate line centered
%around LP
XXt = linspace (Pgon.TP(2)-Wflt*2,Pgon.TP(2)+Wflt*2,Wflt*10);
YYt= Pslope*(XXt-Pgon.TP(2))+Pgon.TP(1);
[blorp MidT]=min(abs(XXt-Pgon.TP(2)));
% find xx/yy closest to 500m from TP
[beep boop] =min (abs(Wflt-(sqrt((XXt(MidT+1:end)-Pgon.TP(2)).^2 + (YYt(MidT+1:end)-Pgon.TP(1)).^2 ))));
dx=MidL:length(XXt);
Pgon.TPc1 = [YYt(dx(boop)),XXt(dx(boop))];
[beep boop] =min (abs(Wflt-(sqrt((XXt(1:MidT-2)-Pgon.TP(2)).^2 + (YYt(1:MidT-2)-Pgon.TP(1)).^2 ))));
dx=1:MidT-1;
Pgon.TPc2 =  [YYt(dx(boop)),XXt(dx(boop))];
PC.Y =[Pgon.LPc1(1),Pgon.LPc2(1),Pgon.TPc2(1),Pgon.TPc1(1),Pgon.LPc1(1)];
PC.X =[Pgon.LPc1(2),Pgon.LPc2(2),Pgon.TPc2(2),Pgon.TPc1(2),Pgon.LPc1(2)];
if i >40000
plot (Xline, Yline);
hold on
plot(PC.X,PC.Y);
end

end