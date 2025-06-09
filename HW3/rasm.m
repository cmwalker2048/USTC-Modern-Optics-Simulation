function [u2] = rasm(z,u1,N,dx,k,lambda,P)
%ASM 利用RS衍射的角谱衍射理论做的衍射传输函数
%
% 设置角谱的参数
dfx = 1/(N*dx);
fx = -N/2*dfx:dfx:N/2*dfx-dfx;
fy = fx;
[FX,FY] = meshgrid(fx,fy);

H = exp(1i*k*z*sqrt(1-(lambda*FX).^2-(lambda*FY).^2).*P);
H = fftshift(H);
U1 = fft2(fftshift(u1));
U2 = H.*U1;
u2 = fftshift(ifft2(U2));
%figure;imshow(u2);
end

