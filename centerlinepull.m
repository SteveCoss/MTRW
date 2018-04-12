%centerline pull opens relevant centerline and packages into vectors
function [out] = centerlinepull(River);

Fname=fullfile('C:\Users\coss.31\Documents\MATH\Steves_final_Toolbox\AltimetryToolbox\MEaSUREsToolbox2016\RiverLines',strcat(River,'_','centerline'));
S=shaperead(Fname);
if isfield(S,'longitude');
    out.Xline=[S.longitude];
    out.Yline=[S.latitude];
    out.FD=[S.Flow_Dist];
    out.width=[S.width];
else
    out.FD=[S.Flow_Dist];
    out.Xline=[S.lon];
    out.Yline=[S.lat];
    out.width=[S.width];
    %% smooth the center line
%     YY = smooth(out.Xline,out.Yline,'rloess');
%     out.Yline = YY';
end