function [Wfinal] = ProxCheckV2(CL,Widths);
%unpack CL
Xline = CL.Xline;
Yline = CL.Yline;
MeanW = nanmean(CL.width);
%Ylinesmooth = CL.Ylinesmooth;
FD = CL.FD;
%reproject center;ine
ZONE = utmzone(Yline, Xline);
mstruct = defaultm('utm');
mstruct.zone = ZONE;
mstruct.geoid = almanac('earth','wgs84','meters');
mstruct = defaultm(mstruct);
[Xline,Yline]=mfwdtran(mstruct,Yline,Xline);
Xline = smooth(Xline);
Yline = smooth (Yline);

%sorth width data by date and package by scene create reprojected lat and
%lon
Scenes = unique(Widths(:,3));
for i = 1: length(Scenes)
    dx = find(Widths(:,3)== Scenes(i));
    SceneW(i).scene = Widths(dx,:);
    %reproject
    WX=SceneW(i).scene(:,2);
    WY=SceneW(i).scene(:,1);
%ZONE = utmzone(WY, WX);
mstruct = defaultm('utm');
mstruct.zone = ZONE;
mstruct.geoid = almanac('earth','wgs84','meters');
mstruct = defaultm(mstruct);
[SceneW(i).scene(:,6),SceneW(i).scene(:,5)]=mfwdtran(mstruct,WY,WX);
% figure(1);
% plot(WX,WY,'.')
% figure(2)
% plot(SceneW(i).scene(:,6),SceneW(i).scene(:,5),'.')
end
% Take an extraction box down the centerline and sum points in teh box to
% add to complete channel width.
for i = 2:length(Xline)-1
    if i == 40329
    %if i == 40300
        potato =1
    end
[PC(i)]=polygoncorners(Xline,Yline,i,MeanW);% need to add some way to maky polygon perpendicular scalable on different rivers
end
PC = PC(2:end);
FD = FD((2:end-1));
for i = 1:length(PC);%check each polgon foe each scene
    for j = 1:length(SceneW)
        IN = inpolygon(SceneW(j).scene(:,6),SceneW(j).scene(:,5),PC(i).X,PC(i).Y) ;
       if ~isempty(find(IN >0))
          
       
        Wss=SceneW(j).scene(:,4) ;      
        SceneW(j).scene(IN,7) = sum(Wss(IN));%sum so that braids are added
         SceneW(j).scene(IN,8) = FD(i); %incorperate FD for valid widths     
       end
    end    
end
%loop through again and get rid of SceneW.scene without columb 7/8
k=0;
for i = 1:length(SceneW)
    S=size(SceneW(i).scene);
    if S(2)>6
        k=k+1;
        DEX(k)=i;
    end
end
SceneW=SceneW(DEX);
    

SceneW = vertcat(SceneW.scene);%condense scenes into one Wdat
Fill=SceneW(:,8)==0;
SceneW=SceneW(~Fill,:);

% Wdex = find(~isempty(SceneW(:,7)));%index valid widths
% SceneW = SceneW(Wdex,:);%filter

WW(:,1) = SceneW(:,1);
WW(:,2) = SceneW(:,2);
WW(:,3) = SceneW(:,3);
WW(:,4) = SceneW(:,7);
WW(:,5) = SceneW(:,8);

Wfinal = WW;

end
