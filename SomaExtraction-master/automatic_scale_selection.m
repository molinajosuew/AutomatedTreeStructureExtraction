%finds the largest diameter of all possible blobs in the input image
function [m_scale, Scale_Chart]= automatic_scale_selection(image)
%image must be binary and 2D. 
%scale range can be determined by user. 
display('scale selection...')
tic
min_scale=2; max_scale=20;
filtIm=zeros(size(image,1),size(image,2),max_scale-min_scale+1); filtIm2=filtIm; i=1;
for scale=min_scale:1:max_scale
    filtIm(:,:,i)=anigauss_mex(double(image),scale,ceil(scale/10),double(0),0,0);
    filtIm2(:,:,i)=anigauss_mex(double(image),scale,ceil(scale/10),double(60),0,0);
    %filtIm3(:,:,i)=anigauss_mex(double(image),scale,ceil(scale/10),double(120),0,0);

    i=i+1;
end
% find points which gives maximum response to smalllest scale
[i,j]=find(abs(filtIm(:,:,1)-1)<=0.011); 

Scale_Chart=zeros(length(i),3); t=1; %chart to store possible blobs with characteristic radius/scale.
for x=1:length(i)
  if (abs(filtIm2(i(x), j(x),1)-1)<=0.011) 
      %if (abs(filtIm3(i(x), j(x),1)-1)<=0.0001)
        k=find(filtIm(i(x),j(x),:)<=0.989); %0.98 is tolerance
        %same proportis must be satisfied at filtered image which filtered in opposite orientation
        chac_scale=min(k); if isempty(chac_scale)  chac_scale=max_scale; end
        l=find(filtIm2(i(x),j(x),:)<=0.989);
        chac_scalel=min(l); if isempty(chac_scalel)  chac_scalel=max_scale; end
        %l1=find(filtIm3(i(x),j(x),:)<=0.989);
        %chac_scalel1=min(l1); if isempty(chac_scalel1)  chac_scalel1=max_scale; end
        
        Scale_Chart(t,:)=[i(x) j(x) min(chac_scale, chac_scalel)];
        t=t+1;
      %end
  end
    
end
Scale_Chart=Scale_Chart(1:t-1,3);
m_scale=max(Scale_Chart); %diameter=3*m_scale. m_scale is sigma for gaussian
toc
end