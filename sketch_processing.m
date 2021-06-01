function img=sketch_processing(filename)
%函数sketch_processing实现图片素描风格化
%输入参数：ori_img（原始图片）
%输出参数：img（处理后图片）

clear clc;
[X,map] = imread(filename);%读取原始图片（索引图像另作处理）
if ~isempty(map)
    ori_img= ind2rgb(X,map);
else
    ori_img=imread(filename);
end

info_size=size(ori_img);
if(numel(info_size)==3)%将彩色图片转化为灰度图像处理
    img0=rgb2gray(ori_img);
else
    img0=ori_img;
end
img1=uint8(255-img0);%反色
gausize=100;gausigma=10;%参数越大纹理越清晰
gau_filter=fspecial('gaussian',gausize,gausigma);
img2=imfilter(img1,gau_filter);%高斯模糊
img=uint8(min(double(img0)+(double(img0).*double(img2))./(256-double(img2)),255));
%颜色减淡处理(C=MIN(A+(A*B)/(255-B),255)，其中C为混合结果，A为源像素点，B为目标像素点）
imshow(img);
