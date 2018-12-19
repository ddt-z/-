clc;clear all;close all;
src = imread('cell.jpg');
src = rgb2gray(src);
src = imresize(src,[256,256]);
src = 1 - im2double(src);
figure;imshow(src);title('ԭͼ');         % ͼ1 ��ʾԭͼ
x = src;
lambda = 532e-9;h
dector_size = 4e-6;
d1 = 200e-3;
d2 = 200e-3;
f  = 200e-3;
iterations = 200;
[f_reconstruct,mse] = CS_EFRFT_Function(x,lambda,dector_size,d1,d2,f,iterations,0)