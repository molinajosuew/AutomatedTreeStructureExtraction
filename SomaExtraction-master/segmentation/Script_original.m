%this file is an example shows also how to find the segmentation of the
%image.
load('MaxModel(April4-1).mat');
fileName='MAX_24h_DMSO_FGF14_488_PanNav_568_MAP2_647_01_blue.tif';
file_path=pwd;
% fileName='01_test.tif';
%file_path='/Users/cihanbilgekayasandik/Dropbox/Soma Detection Complete Code/Soma Detection Complete Code/Soma Detection Complete Code';
file_path=pwd;
%stacks = tiffRead(fullfile(file_path,'data',fileName),{'MONO'});
stacks = tiffRead(fullfile(file_path,fileName),{'MONO'});
image = stacks.MONO;
image=max(image,[],3);
tic;
%image = shearDen2D(image); toc;%this step is for denoising but since all images in data folder are already denoised we actually do not need to use this step for present images.
figure;imshow(image,[]);colormap('jet');

%segmenting the image
tic;
[s, s1, s2] = segmentImage(image,find(image>0),model,0.9,300);toc;%returns the segmented image, s, and filled segmented images s1 and s2
figure;imshow(s,[]);colormap('jet');
tic;
[filtersize,Scale_Chart]=automatic_scale_selection(s);
% Set number of directions. 
num_direction=10;
[dirRatio, firstSomaParts, mask,s2]=Main_Anigauss_2d(s,filtersize,num_direction); toc;

figure; subplot(2,2,1);  imshow(image,[]); axis off;title('Original image'); colormap('Gray'); freezeColors
subplot(2,2,2); imshow(s2,[]);  axis off; title('Segmented image'); freezeColors;
subplot(2,2,3); imshow(dirRatio,[]);  axis off; title('Directional Ratio'); colormap('jet'); freezeColors;
subplot(2,2,4); imshow(mask,[]);  axis off; title('Extracted somas'); colormap('Gray');