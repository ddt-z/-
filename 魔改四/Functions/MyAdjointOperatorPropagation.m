function eta=MyAdjointOperatorPropagation(S,E,Nx,Ny,Nz,lambda,Lx,Ly,f,d1,d2)

S=reshape(MyV2C(S),Nx,Ny);

eta=MyAdjointPropagation(S,E,lambda,Lx,Ly,f,d1,d2);

eta=MyC2V(eta(:));
