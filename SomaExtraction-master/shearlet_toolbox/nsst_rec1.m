function x=nsst_rec1(dst,lpfilt)
% This function performs the inverse discrete shearlet transform
%
% Input:
%
% dst          - the nonsubsampled shearlet coefficients
%
% lpfilt       - the filter to be used for the Laplacian
%                Pyramid/ATrous decomposition using the codes
%                written by Arthur Cunha
%
% Output 
% 
% x         - the reconstructed image 
%
% Code contributors: Glenn R. Easley, Demetrio Labate, and Wang-Q Lim
%

level=length(dst)-1;
y{1}=dst{1};
for i=1:level,
      y{i+1} = real(sum(dst{i+1},3));
end

x=real(atrousrec(y,lpfilt));

