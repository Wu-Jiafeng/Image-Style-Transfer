function img=sketch_processing_better(filename,ks,dirnum,k1,k2,k3)
%函数sketch_processing_better实现图像素描风格化的各部分算法集成
%输入参数：filename（待处理图像）/ks（卷积核大小）/dirNum（多个方向合成梯度）k1(光亮层权重,越大色调越亮)/k2（中间层权重）/k3（暗层权重）（k1+k2+k3=1）
%输出参数：img（处理后图像）

[~,~,dimension]=size(filename);
if dimension==3
    img0=rgb2gray(filename);
end
img1=stroke(img0,ks,dirnum);
img2=tone_drawing(img0,k1,k2,k3);
img3=texture_rendering(rgb2gray(imread('6.jpg')),img2);
img=uint8(double(img3).*img1);
imshow(img);