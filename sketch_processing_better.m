function img=sketch_processing_better(filename,ks,dirnum,k1,k2,k3)
%����sketch_processing_betterʵ��ͼ�������񻯵ĸ������㷨����
%���������filename��������ͼ��/ks������˴�С��/dirNum���������ϳ��ݶȣ�k1(������Ȩ��,Խ��ɫ��Խ��)/k2���м��Ȩ�أ�/k3������Ȩ�أ���k1+k2+k3=1��
%���������img�������ͼ��

[~,~,dimension]=size(filename);
if dimension==3
    img0=rgb2gray(filename);
end
img1=stroke(img0,ks,dirnum);
img2=tone_drawing(img0,k1,k2,k3);
img3=texture_rendering(rgb2gray(imread('6.jpg')),img2);
img=uint8(double(img3).*img1);
imshow(img);