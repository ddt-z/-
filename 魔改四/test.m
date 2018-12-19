%   本程序用于生成位于共轭面的两幅图片

close all;
clear all;
clc;
addpath('./Functions');
%% 读图
src = imread('cell.jpg');
src = rgb2gray(src);
src = imresize(src,[256,256]);
src = 1 - im2double(src);
figure;imshow(src);title('原图');         % 图1 显示原图

%% 参数设置
x = src;
nx = size(x,1);
ny = size(x,2);
lambda = 0.532;                  % 波长 单位 微米
dector_size = 4;                 % 一个像素的实际大小
Lx = dector_size * nx;           % 图片x方向实际大小
E = ones(nx,ny);

% d1 =  [400000,40000,4000,400,40,4,0.4];
d1 = [1000000,100000,10000,1000,100,10,1];
d1 = wrev(d1);
d2 = [250000,25000,2500,250,25,2.5,0.25];
d2 = wrev(d2);
f = [200000,20000,2000,200,20,2,0.2];
f = wrev(f);
length = size(d1,2);
figure;subplot(2,4,1);imshow(src);title('原图');

%% 扩展分数傅立叶
for i = 1:length
    E_efrft_conj = efrft2(E,lambda,-d1(i),-d2(i),-f(i),Lx);
    E3 = efrft2(E,lambda,d1(i),d2(i),f(i),Lx);
    src2 =src.*E_efrft_conj;
    A = efrft2(src2,lambda,d1(i),d2(i),f(i),Lx);
    E_efrft = E.*E_efrft_conj;
    E2 = efrft2(E_efrft,lambda,d1(i),d2(i),f(i),Lx);
    U = ((A+1).*conj(A+1)) ./ ((E2+1).*conj(E2+1)); 
    U = U.*E3
    subplot(2,4,i+1);imshow(abs(U),[]);title(['d = ',num2str(d1(i)/1000),'mm,f = ',num2str(f(i)/1000),'mm']);
end

%% 菲涅尔衍射
figure;subplot(2,4,1);imshow(src);title('原图');
for i = 1:length
    B(:,:,i) = lens_fresnel(src,lambda,Lx,Lx,d1(i),d2(i),f(i)); 
    subplot(2,4,i+1);imshow(abs(B(:,:,i)),[]);title(['d = ',num2str(d1(i)/1000),'mm,f = ',num2str(f(i)/1000),'mm']);
end