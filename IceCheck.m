%% Determine whether to use the IceFilter
% Written by S. Tuozzolo, 8/2014
% This can be updated in the future with more rivers... and maybe a better
% way for checking about ice. A latitude check?

function [DoIce,icefile] = IceCheck(rivername);
        if strcmp(rivername,'Yukon') || strcmp(rivername,'Mackenzie')...
                ||strcmp(rivername,'Indigirka') || strcmp(rivername,'Kolyma')...
               || strcmp(rivername,'Lena') || strcmp(rivername,'Menzen')...
                ||strcmp(rivername,'Ob') || strcmp(rivername,'Olenyok')...
               || strcmp(rivername,'Pechora')|| strcmp(rivername,'StLawrence')...
               || strcmp(rivername,'Yenisei');
                
            DoIce=true;
        else
            DoIce=false;
        end
        icefile = ['icebreak_' rivername];
end