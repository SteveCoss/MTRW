function [out] = TStoGRID(onekmTS);
%Generate a grid where x is the extent of FD and Y is the extent of T
Tall=vertcat(onekmTS.t);
ut=unique(Tall);
%empty grid
Wgrid=NaN(length(ut),length(onekmTS));
%build eack km of grid
S=size(Wgrid);
for i = 1:S(2);
    if ~isempty(onekmTS(i).t);
    for j =1:length(onekmTS(i).t);
        j;
        dx= find(ut==onekmTS(i).t(j));
        Wgrid(dx,i)= onekmTS(i).w(j);
    end
    end
    out.Wgrid=Wgrid;
    out.T=ut;
    out.FD=1:1:S(2);
end