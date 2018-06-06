function [dirRatio_b, firstSomaParts, minF] = SomaDetection(segmentedImage1, segmentedImage2,NBANDS,FSIZE)
% This function returns the first cut of the soma detection. It normally
% returns regions that are contained inside a soma, but are not necessarily
% the entire soma region. It also eliminates false soma parts, and fills
% possible holes left in those regions.
%
% INPUT:
% - segmnetedImage: The segmented version of the image
% 
% OUPUT:
%  - firstSomaParts: mask of the first cut of soma regions.
%

% Constants needed on this function
%NBANDS = 10; % Number of bands to be considered
%FSIZE  = 32;
% Size of the directional filters
THR4 = 150;  % Threshold to  keep components with cardinality greater than
             % that threshold
%THR4 = 100;        
             
[dirRatio_b, minF1] = directionalRatio(segmentedImage1,NBANDS, FSIZE);
mask = zeros(size(segmentedImage1));
Idx = find(dirRatio_b>0.85);
mask(Idx) = dirRatio_b(Idx);


% eliminate the parts which are not likely to be soma part ie if the 
% card of  that component less than some threshold eliminating it.
CC1 = connComp(mask);
RemainComp1 = cat(1, CC1.compIdx{CC1.compCard > THR4});
firstSomaParts1 = zeros(size(segmentedImage1));
firstSomaParts1(RemainComp1) = 1;
C1 = connComp(firstSomaParts1);
%figure;imshow(firstSomaParts,[]);colormap('jet');

[dirRatio_b, minF2] = directionalRatio(segmentedImage2,NBANDS, FSIZE);
mask = zeros(size(segmentedImage2));
Idx = find(dirRatio_b>0.85);
mask(Idx) = dirRatio_b(Idx);


% eliminate the parts which are not likely to be soma part ie if the 
% card of  that component less than some threshold eliminating it.
CC2 = connComp(mask);
RemainComp2 = cat(1, CC2.compIdx{CC2.compCard > THR4});
firstSomaParts2 = zeros(size(segmentedImage2));
firstSomaParts2(RemainComp2) = 1;
C2 = connComp(firstSomaParts2);

if(C2.compNum == C1.compNum)
    %firstSomaParts = firstSomaParts2;
    firstSomaParts = firstSomaParts1;
    minF=minF1;
    
end
if(C2.compNum > C1.compNum)
   firstSomaParts = firstSomaParts2; 
   minF=minF1;
end
if(C2.compNum < C1.compNum)
   firstSomaParts = firstSomaParts1; 
   minF=minF2;
end

end

%Created by: 
%Burcin Ozcan
%modified by:
% Cihan Bilge Kayasandik
