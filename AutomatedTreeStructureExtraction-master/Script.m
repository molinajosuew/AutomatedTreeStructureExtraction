load('inputSeg');
load('inputSoma');

option.rect = 1;
option.manual = 0;

[neuriteGraph, cell_rect] = runCenterLineParallel(inputSeg, inputSoma, option);