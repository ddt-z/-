function Fi = Ang_spetrum(I1,Lambda,Lx,Ly,d)
% Fresnel diffraction
% I1 is input image or pattern
% Lambda is wavelength
% Lx and Ly are the size of input image
% d is length of optical path

[M,N] = size(I1);
[u,v] = meshgrid([-N/2+1:N/2],[-M/2+1:M/2]);
u = u/Lx*Lambda;
v = v/Ly*Lambda;

Fhdq3 = exp(1i*2*pi*d/Lambda*sqrt(1-u.^2-v.^2));
Fhdq3((1-u.^2-v.^2)<0) = 0;
% Fi = ifft2(fft2(I1).*fftshift(Fhdq3));
Fi = fftshift(fft2(I1)).*Fhdq3;
Fi = ifft2(ifftshift(Fi));
