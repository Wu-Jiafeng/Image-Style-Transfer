function img=tone_drawing(ori_img,k1,k2,k3)
%函数tone_drawing产生色调图
%输入参数：ori_img（原始灰度图像）/k1(光亮层权重,越大色调越亮)/k2（中间层权重）/k3（暗层权重）（k1+k2+k3=1）
%输出参数：img（输出色调图）
%思路：根据

i=0:255;
img1=(1/9)*exp(-(255-i)/9);%模拟[0,255]的离散拉普拉斯分布
img2=zeros(1,256);
img2(105:225)=1/(225-105);%模拟[105,225]的离散均匀分布;
img3=(1/sqrt(2*pi*121))*exp(-((i-90).^2)/(2.0*121));%模拟[0,255]的高斯分布
img4=img1*k1+img2*k2+img3*k3;%模拟铅笔画的灰度分布
img=histeq(ori_img,img4);