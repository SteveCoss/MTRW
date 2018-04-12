%working on widthgrid
clear all; close all; clc
River = 'Mississippi';
fname2 = strcat(River,'_','WidthDataFD');
Wfinal = dlmread(fname2,',');
[onekmTS] = WidthGridTS(Wfinal);
[Wgrid] = TStoGRID(onekmTS);