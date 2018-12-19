function S=MyForwardOperatorPropagation(eta,E,Nx,Ny,Nz,lambda,Lx,Ly,f,d1,d2)

eta=reshape(MyV2C(eta),Nx,Ny,Nz);

S=MyForwardPropagation(eta,E,lambda,Lx,Ly,f,d1,d2);

S=MyC2V(S(:));
