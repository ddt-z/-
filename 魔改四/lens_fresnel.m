function Fi = lens_fresnel(I1,Lambda,Lx,Ly,d1,d2,f)
[M,N] = size(I1);
[u,v] = meshgrid([-N/2+1:N/2],[-M/2+1:M/2]);
u = u/Lx*Lambda;
v = v/Ly*Lambda;

[x,y] = meshgrid(([0:N-1]/N-1/2),([0:M-1]/M-1/2)); % Normarlized coordinates
x=Lx*x;
y=Lx*y;

Fhdq1 = exp(1i*2*pi*d1/Lambda)*exp(-1i*pi*d1/Lambda*[u.^2+v.^2]);
Fi = ifft2(fft2(I1).*fftshift(Fhdq1));
f1=Fi.*exp(-1j*pi*(x.^2+y.^2)/Lambda/f);
Fhdq2 = exp(1i*2*pi*d2/Lambda)*exp(-1i*pi*d2/Lambda*[u.^2+v.^2]);
Fi = ifft2(fft2(f1).*fftshift(Fhdq2));