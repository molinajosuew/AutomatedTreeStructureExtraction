% Soma Segmentation via Anisotropic Gaussian Filters m-files
%
%--------------------------------------------------------------------------
% Cihan Bilge Kayasandik last edited: 2016-07-13


% install_DR_RF.m
%   Main file to add necessary paths to Matlab.
% /data/
%   contains 20 2D images with their segmentation to test the algorithm.
% /fast marching tollbox/
%   Files to apply Fast Marching method to input.
%   This package is prepared by Gabriel Peyre
%   *to compile mex files type: mex mex/perform_front_propagation_2d.cpp mex/perform_front_propagation_2d_mex.cpp mex/fheap/fib.cpp
%   in matlab or run compile_mex.m file. This package is reduced only to
%   necessary files for this project. The complete package can be found
%   online.
% connComp.m
%   It takes a binary solid and returns struct containing indices
%   of the components
% SomaDetection.m
%   It takes a binary solid and returns the Directional Ratio values for each 
%   pixel with respect using images filters with rotated rectangular filters. 
%   This file calls directionalRatio.m
% fastMarching_rect.m 
%   It applies 2D Fast Marching method to input.
% freezeColors.m 
%   Utility to lock colors of plot, enabling multiple colormaps
%   per figure. Due to freezeColors  Lock colors of plot, enabling multiple
%   colormaps per figure. Due to John Iversen.
% Script.m
%   Script showing an example of soma detection and extraction 
% Main_Rectangular_2d.m
%   Main function calls all necessary functions to segment soma regions in 
%   2D image.
% SomaDivision_fastMarching.m
%   File to separate contiguous somas, if there needed. 
% tiffRead.m
%   It reads tif files.


