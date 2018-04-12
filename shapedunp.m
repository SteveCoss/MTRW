%shape dump
% create line geostruct
[S(1:length(Wfinal)).Geometry] = deal('point');
    for i = 1: length(S)
    S(i).Lat = Wfinal(i,1);
    S(i).Lon = Wfinal(i,2);
    S(i).width = Wfinal(i,4);
    end
    
    
    shapewrite(S,'tester');
    
    
