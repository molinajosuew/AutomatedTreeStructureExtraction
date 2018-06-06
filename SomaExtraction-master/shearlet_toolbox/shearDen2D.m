function xrec = shearDen2D(J)


nsst_scalars_calculated=0;
shear_version=2; %nsst_dec2
X=J;
[L Y Z]=size(X);
xrec=zeros(L,Y,Z,'uint16');
lpfilt='maxflat';
shear_parameters.dcomp =[ 3  3  4  4];
shear_parameters.dsize =[32 32 16 16];

Tscalars=[0 3 4];
for slice=1:Z
    x_noisy=X(:,:,slice);
    sigma=sdest(x_noisy);
    if shear_version==0,
        [dst,shear_f]=nsst_dec1e(x_noisy,shear_parameters,lpfilt);
    elseif shear_version==1,
        [dst,shear_f]=nsst_dec1(x_noisy,shear_parameters,lpfilt);
    elseif shear_version==2
        [dst,shear_f]=nsst_dec2(x_noisy,shear_parameters,lpfilt);
    end
    
    if nsst_scalars_calculated==0
        if shear_version==0,
            dst_scalars=nsst_scalars_e(L,shear_f,lpfilt);
        else
            dst_scalars=nsst_scalars(L,shear_f,lpfilt);
        end
        nsst_scalars_calculated=1;%Avoid recaculation in loop
    end
    
    dst=nsst_HT(dst,sigma,Tscalars,dst_scalars);
    
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


end

