function x=nsst_rec2(dst,shear_f,lpfilt)
% This function performs the inverse discrete shearlet transform
%
% Input:
%
% dst          - the nonsubsampled shearlet coefficients
%
% shear_f      - the cell array containing the shearing filters 
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
      l=size(dst{i+1},3);
      for k=1:l,
          dst{i+1}(:,:,k)=conv2p(conj(shear_f{i}(:,:,k)),dst{i+1}(:,:,k));
      end
      y{i+1} = real(sum(dst{i+1},3));
end

x=real(atrousrec(y,lpfilt));

