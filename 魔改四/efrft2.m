function an = efrft2(a0,Lambda,d1,d2,f,L)
% extended fractional Fourier transform
% a0: input signal
% Lambda: wavelength
% d1: distance from input to lens
% d2: distance from lens to output
% f: focal length
% L: size of input image 

N = size(a0,1);
x = [0:N-1]/N*L-L/2;
[x,y] = meshgrid(x);
u = [[0:N-1]/N-0.5]*N/L;
[u,v] = meshgrid(u);

m1x = exp(1i*pi*[-d2]*[x.^2+y.^2]/Lambda/[2*f^2-d1*d2]);
m2x = exp(1i*pi*f*[x.^2+y.^2]/Lambda/[2*f^2-d1*d2]);
m3u = exp(1i*pi*[-d1]*[x.^2+y.^2]/Lambda/[2*f^2-d1*d2]);
M2u = exp(-1i*pi*Lambda*[u.^2+v.^2]*[2*f^2-d1*d2]/f);%omit a phase factor
an = m3u.*ifft2(fft2(a0.*m1x).*fftshift(M2u));
% an = m3u.*ifft2(fft2(a0.*m1x).*fft2(m2x))/N;
