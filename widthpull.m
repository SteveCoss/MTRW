% Generate width, lat, lon and date vectors
function [Widths,MW]= widthpull(ValidExtracted);
%riverWidth = (15 * pi + MLength) * waterMask_mean
Widths = []; MW = [];
for i = 1:length(ValidExtracted.lat);
   Widths(i).lat=ValidExtracted.lat(i);
   Widths(i).lon=ValidExtracted.lon(i);
   Widths(i).date=ValidExtracted.date(i);
   if isfield(ValidExtracted,'waterMask_mean');
   riverWidth = (15 * pi + ValidExtracted.MLength(i)) * ValidExtracted.waterMask_mean(i);
   Widths(i).riverWidth = riverWidth;
   MW = nanmean(riverWidth);
   else
   riverWidth = (15 * pi + ValidExtracted.MLength(i)) * ValidExtracted.river_mean(i);
   fWidth = (15 * pi + ValidExtracted.MLength(i)) * ValidExtracted.fwater_mean(i);
   Widths(i).riverWidth = riverWidth;
   Widths(i).fWidth = fWidth;
   MW = nanmean(riverWidth);
   end
end
   