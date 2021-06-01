function img=sketch_processing(filename)
%����sketch_processingʵ��ͼƬ������
%���������ori_img��ԭʼͼƬ��
%���������img�������ͼƬ��

clear clc;
[X,map] = imread(filename);%��ȡԭʼͼƬ������ͼ����������
if ~isempty(map)
    ori_img= ind2rgb(X,map);
else
    ori_img=imread(filename);
end

info_size=size(ori_img);
if(numel(info_size)==3)%����ɫͼƬת��Ϊ�Ҷ�ͼ����
    img0=rgb2gray(ori_img);
else
    img0=ori_img;
end
img1=uint8(255-img0);%��ɫ
gausize=100;gausigma=10;%����Խ������Խ����
gau_filter=fspecial('gaussian',gausize,gausigma);
img2=imfilter(img1,gau_filter);%��˹ģ��
img=uint8(min(double(img0)+(double(img0).*double(img2))./(256-double(img2)),255));
%��ɫ��������(C=MIN(A+(A*B)/(255-B),255)������CΪ��Ͻ����AΪԴ���ص㣬BΪĿ�����ص㣩
imshow(img);
