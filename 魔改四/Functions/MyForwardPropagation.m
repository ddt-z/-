function S=MyForwardPropagation(eta,E,lambda,Lx,Ly,f,d1,d2)

Es=eta.*E;
% S = Ang_spetrum(Es,lambda,Lx,Ly,z);
S = efrft2(Es,lambda,d1,d2,f,Lx);
S = real(S);