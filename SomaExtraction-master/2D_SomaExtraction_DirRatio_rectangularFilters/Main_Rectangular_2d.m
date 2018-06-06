function [dirRatio_burcins, firstSomaParts, segmentedSomas,filled_segmentation]=Main_Rectangular_2d(segmentedImage,fsize,num_direction)
%main file to segment soma regions
% INPUT: 
%   -segmentedImage: binary segmentation of the image
%   -fsize: filter length
%   -num_directions: number of directions
% OUTPUTS:
%   -dirRatio: matrix with the size of input image. It gives
% directional ratio value for each pixel.
%   - detectedSomas: soma regions in input.
%   - segmentedSomas: segmented soma regions after fast marching method.
%   - filled_segmentation: second segmentation of the input image through
%   filling the possible gaps in foreground. This process is necessary for 
%   soma detection process.

% We first fill possible gaps in segmentation 
THR=0.4;
%compImage = eliminateComp(segmentedImage,100);

medianFilter = ones(6)/36;
convolvedSegm = convn(segmentedImage,medianFilter,'same');
T= uint8((convolvedSegm>THR) & (convolvedSegm<1)&(segmentedImage<1));
tempSegmentedImage = uint8(T | segmentedImage);
filled_segmentation = uint8(tempSegmentedImage | segmentedImage);

%soma detection
display('Detecting soma...')
tic
[dirRatio_burcins, firstSomaParts] = SomaDetection(segmentedImage,filled_segmentation,num_direction,fsize); 
toc
%soma extraction
display('Extracting somas (computing Fast Marching routine)...')
tic
[segmentedSomas,~]=fastMarching_rect(firstSomaParts,segmentedImage, filled_segmentation,fsize,10); 
toc
%seperating contiguous somas
%dividedSomas = SomaDivision_fastMarching(segmentedImage,soma,0, 10);

%segmentedSomas= zeros(size(segmentedImage));
%for i=1:length(dividedSomas) segmentedSomas(dividedSomas{i})=10*i; end
%figure;imshow(segmentedSomas,[]);colormap('jet');
end

% CREATED: 
% - Date: 2016-07-13
% - By: Cihan Bilge Kayasandik and Demetrio Labate.
% 



