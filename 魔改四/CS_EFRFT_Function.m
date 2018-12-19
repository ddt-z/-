function [f_reconstruct,mse] = CS_EFRFT_Function(x,lambda,dector_size,d1,d2,f,iterations,Verbose)
addpath('./Functions');
nx = size(x,1);
ny = size(x,2);
nz = 1;                          
Lx = dector_size * nx;           % 图片x方向实际大小
Ly = dector_size * ny;
Nx = nx;
Ny = ny * 2;                     % 虚数部分
Nz = 1;
%% 角谱衍射
E = ones(nx,ny);                    % 照明光
% E_Ang = Ang_spetrum(E,lambda,Lx,Ly,z);
% E_AngConj = Ang_spetrum(E,lambda,Lx,Ly,-z);
E_Frft2 = efrft2(E,lambda,d1,d2,f,Lx);
E_Frft2Conj = efrft2(E,lambda,-d1,-d2,-f,Lx);



%% CCD接收到的光场分布
O = x.*E_Frft2Conj;                                         % 不知道为啥乘E_AngConj
O1 = efrft2(O,lambda,d1,d2,f,Lx);

R = E.*E_Frft2Conj;                                         % 归一化分母计算
R1 = efrft2(R,lambda,d1,d2,f,Lx);

U = ((O1+1).*conj(O1+1)) ./ ((R1+1).*conj(R1+1));       % 归一化
figure;imshow(abs(U),[]);title('衍射场');                       % 图二 衍射场
U_double = im2double(U);
U_double = abs(U_double);
U_C2V = MyC2V(U_double(:));
y = U_C2V;

%% 传播函数
A = @(x)MyForwardOperatorPropagation(x,E_Frft2Conj,nx,ny,nz,lambda,Lx,Ly,f,d1,d2);
% A = @(x)ForwardOperatorPropagation(x,lambda,Lx,Ly,z)
AT = @(y)MyAdjointOperatorPropagation(y,E_Frft2Conj,nx,ny,nz,lambda,Lx,Ly,-f,-d1,-d2);

%% Twist参数及算法
tau = 0.005; 
piter = 4;
tolA = 1e-6;


Psi = @(f,th) MyTVpsi(f,th,0.05,piter,Nx,Ny,Nz);
Phi = @(f) MyTVphi(f,Nx,Ny,Nz);

[f_reconstruct,~,~,...
    ~,~,~]= ...
    TwIST(y,A,tau,...
    'AT', AT, ...
    'Psi', Psi, ...
    'Phi',Phi, ...
    'Initialization',2,...
    'Monotone',1,...
    'StopCriterion',1,...
    'MaxIterA',iterations,...
    'MinIterA',iterations,...
    'ToleranceA',tolA,...
    'Verbose', Verbose);

%% ch
f_reconstruct=reshape(MyV2C(f_reconstruct),nx,ny,nz);
re=(abs(f_reconstruct));
mse = mean2((x - re).^2);
fprintf('MSE = %f\n',mse);
figure;imshow(re);title('重构');                      % 图三 重构结果
end

