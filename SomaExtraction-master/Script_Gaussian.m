clear;
close all;
file_path=pwd;
fileName='segm_MAX_DIV14_DMSO24h_FGF14_PanNavRabb_MAP2_4_blue.tif';
stacks = tiffRead(fullfile(file_path,'data',fileName),{'MONO'});
s = stacks.MONO; %read image
fileName='MAX_DIV14_DMSO24h_FGF14_PanNavRabb_MAP2_4_blue.tif';
stacks = tiffRead(fullfile(file_path,'data',fileName),{'MONO'});
image = stacks.MONO; %read image
% Set filter length. 'filtersize' is the standard deviation corresponding to the main axis of the anisotropic Gaussian filter. Length is approximately 3*filtersize 
filtersize=9; 
% Set number of directions.
num_direction=10;
[dirRatio, firstSomaParts, mask,s2] = Main_Anigauss_2d(s, filtersize, num_direction);

figure;

subplot(2,2,1);
imshow(image,[]);
axis off;
title('Original image');
colormap('Gray');
freezeColors;

subplot(2,2,2);
imshow(s2,[]);
axis off;
title('Segmented image');
freezeColors;

subplot(2,2,3);
imshow(dirRatio,[]);
axis off;
title('Directional Ratio');
colormap('jet');
freezeColors;

subplot(2,2,4);
imshow(mask,[]);
axis off;
title('Extracted somas');
colormap('Gray'); 

% CREATED: 
% - Date: 2016-07-13
% - By: Cihan Bilge Kayasandik and Demetrio Labate.
% 