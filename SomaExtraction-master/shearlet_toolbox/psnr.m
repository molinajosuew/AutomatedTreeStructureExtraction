function p1 = psnr(x,y)

[nx,ny]=size(x);
MSE=norm(x-y,'fro')^2/(nx*ny);
p1 = 20.0*( log10(255)- 1/2*log10(MSE) );


