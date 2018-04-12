%fillcheck
clear all; close all; clc
s=size(Wgrid.Wgrid);
for i= 1:s(2)
    kmtote(i) = length(find(~isnan(Wgrid.Wgrid(:,i))));
end
x = 1:1:s(2);
y = linspace(1,1,s(2));
scatter(x,y,2,kmtote)
hist(kmtote,15)
xlabel('width measurements')
ylabel('count')