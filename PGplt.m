figure;
plot(Pi(2),Pi(1),'ko')
hold on
plot(P0(2),P0(1),'kx')
plot(P1(2),P1(1),'kx')
plot(Pgon.TP(2),Pgon.TP(1),'bs')
plot(Pgon.LP(2),Pgon.LP(1),'bs')
plot(XXl(MidL:end),YYl(MidL:end),'r');
plot(XXl(1:MidL),YYl(1:MidL),'g');
plot(Pgon.LPc1(2),Pgon.LPc1(1),'ro')
plot(Pgon.LPc2(2),Pgon.LPc2(1),'ro')
plot(XXt(MidT:end),YYt(MidT:end),'r');
plot(XXt(1:MidT),YYt(1:MidT),'g');
plot(Pgon.TPc1(2),Pgon.TPc1(1),'go')
plot(Pgon.TPc2(2),Pgon.TPc2(1),'go')
