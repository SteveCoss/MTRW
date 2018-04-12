%% package into matrix
function [W] = Wstruct_to_dlm(Widths,polished);
W(:,1) = [Widths.lat];
W(:,2) = [Widths.lon];
W(:,3) = [Widths.date];
if polished
    W(:,4) = [Widths.width];
else
    W(:,4) = [Widths.riverWidth];
end
    
end

