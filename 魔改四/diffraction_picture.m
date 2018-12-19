%   ��������������λ�ڹ����������ͼƬ

close all;
clear all;
clc;
addpath('./Functions');
%% ��ͼ
src = imread('cell.jpg');
src = rgb2gray(src);
src = imresize(src,[1024,1024]);
src = 1 - im2double(src);
figure;imshow(src);title('ԭͼ');         % ͼ1 ��ʾԭͼ

%% ��������
x = src;
nx = size(x,1);
ny = size(x,2);
lambda = 0.532;                  % ���� ��λ ΢��
dector_size = 4;                 % һ�����ص�ʵ�ʴ�С
% Lx = dector_size * nx;           % ͼƬx����ʵ�ʴ�С
Lx = 20;
% d1 =  [400000,40000,4000,400,40,4,0.4];
d1 = [1000000,100000,10000,1000,100,10,1];
d1 = wrev(d1);
d2 = [250000,25000,2500,250,25,2.5,0.25];
d2 = wrev(d2);
f = [200000,20000,2000,200,20,2,0.2];
f = wrev(f);
length = size(d1,2);
figure;subplot(2,4,1);imshow(src);title('ԭͼ');

%% ��չ��������Ҷ
for i = 1:length
    A(:,:,i) = efrft2(src,lambda,d1(i),d2(i),f(i),Lx);
    subplot(2,4,i+1);imshow(abs(A(:,:,i)),[]);title(['d = ',num2str(d1(i)/1000),'mm,f = ',num2str(f(i)/1000),'mm']);
end

%% ����������
figure;subplot(2,4,1);imshow(src);title('ԭͼ');
for i = 1:length
    B(:,:,i) = lens_fresnel(src,lambda,Lx,Lx,d1(i),d2(i),f(i)); 
    subplot(2,4,i+1);imshow(abs(B(:,:,i)),[]);title(['d = ',num2str(d1(i)/1000),'mm,f = ',num2str(f(i)/1000),'mm']);
end