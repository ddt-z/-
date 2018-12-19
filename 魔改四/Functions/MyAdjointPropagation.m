function eta=MyAdjointPropagation(S,E,lambda,Lx,Ly,f,d1,d2)

S = real(S);
% S = Ang_spetrum(S,lambda,Lx,Ly,z); 
S = efrft2(S,lambda,d1,d2,f,Lx);
eta=conj(E).*S;