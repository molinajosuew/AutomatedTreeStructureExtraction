% This file gives an example of shearlet denoising.
% Code contributors: Glenn R. Easley, Demetrio Labate, and Wang-Q Lim

% Determine weather coefficients are to be displayed or not
display_flag=0; % Do not display coefficients
%display_flag=1; % Display coefficients
dataPath='../dataLab/'; 
fileName='Tige_13_2100_2100.mat';
sigma=.1;
nsst_scalars_calculated=0;
%There are three possible ways of implementing the 
%local nonsubsampled shearlet transform (nsst_dec1e,
%nsst_dec1, nsst_dec2). For this demo, we have created 
%a flag called shear_version to choose which one to
%test.

%shear_version=0; %nsst_dec1e
%shear_version=1; %nsst_dec1
shear_version=2; %nsst_dec2

% Load image
%x=double(imread('barbara.gif'));
eval([' load ' dataPath fileName]);

%***********Above data reading can be chnages to reading tif files**
%**********in loop via matlab routine , as done in dataPath folder*
[L Y Z]=size(X);
xrec=zeros(L,Y,Z,'uint8');
% setup parameters for shearlet transform
lpfilt='maxflat';
% .dcomp(i) indicates there will be 2^dcomp(i) directions 
shear_parameters.dcomp =[ 3  3  4  4];
% .dsize(i) indicate the local directional filter will be
% dsize(i) by dsize(i)
shear_parameters.dsize =[32 32 16 16];
% 
%Tscalars determine the thresholding multipliers for
%standard deviation noise estimates. Tscalars(1) is the
%threshold scalar for the low-pass coefficients, Tscalars(2)
%is the threshold scalar for the band-pass coefficients, 
%Tscalars(3) is the threshold scalar for the high-pass
%coefficients. 

Tscalars=[0 3 4];
for slice=1:Z
    x_noisy=X(:,:,slice);
    sigma=sdest(x_noisy);
% compute the shearlet decompositon on each slice
if shear_version==0,
  [dst,shear_f]=nsst_dec1e(x_noisy,shear_parameters,lpfilt);
elseif shear_version==1, 
  [dst,shear_f]=nsst_dec1(x_noisy,shear_parameters,lpfilt);
elseif shear_version==2
  [dst,shear_f]=nsst_dec2(x_noisy,shear_parameters,lpfilt);
end

% Determines via Monte Carlo the standard deviation of
% the white Gaussian noise with for each scale and 
% directional components when a white Gaussian noise of
% standard deviation of 1 is feed through.
if nsst_scalars_calculated==0
if shear_version==0,
   dst_scalars=nsst_scalars_e(L,shear_f,lpfilt);
else
   dst_scalars=nsst_scalars(L,shear_f,lpfilt);
end
nsst_scalars_calculated=1;%Avoid recaculation in loop
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% display coefficients %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if display_flag==1,
   figure(1)
   imagesc(dst{1})
   for i=1:length(dst)-1,
       l=size(dst{i+1},3);
       JC=ceil(l/2);
       JR=ceil(l/JC);
       figure(i+1)
       for k=1:l,
           subplot(JR,JC,k)
           imagesc(abs(dst{i+1}(:,:,k)))
           axis off
           axis image
       end   
   end
end % display_flag 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% apply hard threshold to the shearlet coefficients
dst=nsst_HT(dst,sigma,Tscalars,dst_scalars);


% reconstruct the image from the shearlet coefficients
if shear_version==0,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==1,
    xr=nsst_rec1(dst,lpfilt);      
elseif shear_version==2,
    xr=nsst_rec2(dst,shear_f,lpfilt);      
end
clear X(:,:,slice);
 xrec(:,:,slice)=xr;
end
% compute a measure of performance
%can plot PSNR frame by frame
save Tige_13_2100_2100_2ddsh_with_gussian_sd_es xrec
figure(1);


% p0 = psnr(x,x_noisy);
% fprintf('Initial PSNR = %f\n',p0);
% p1 = psnr(x,xr);
% fprintf('PSNR After Denoising = %f\n',p1);
% fprintf('Reconstruction Error (norm) After Denoising = %f\n',norm(xr-x)/norm(x));
%RECONTRUCTION_ERROR = norm(xr-x)/norm(x)
% imwrite(x_noisy,'barbara_Sh_n20.gif');
% imwrite(xr,'barbara_Sh_r20.gif');
% 
% figure(10)
% imagesc(x)
% title(['ORIGINAL IMAGE, size = ',num2str(L),' x ',num2str(L)])
% colormap('gray')
% axis off
% axis image
% 
% figure(11)
% imagesc(x_noisy)
% title(['NOISY IMAGE, PSNR = ',num2str(p0)])
% colormap('gray')
% axis off
% axis image
% 
% figure(12)
% imagesc(xr)
% title(['RESTORED IMAGE, PSNR = ',num2str(p1)])
% colormap('gray')
% axis off
% axis image


