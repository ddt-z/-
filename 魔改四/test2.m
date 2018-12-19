A = imread('�ָ�ͼ.png');
A = rgb2gray(A);
A = im2double(A);
C = imread('cameraman.tif');
figure;imshow(C);title('ԭͼ');
figure;imshow(A);
figure;imshow(A,[]);
B = 1-A;
figure;imshow(B);