function img=oilpainting(filename,ksize)
%函数oilpainting实现图片的油画滤镜风格化
%输入参数：filename（待处理图像）/ksize（邻域半径，一般为9/11）
%输出参数：img（处理后图像）
%算法思路：根据油画粘连厚重的特点，对于每个像素点p(i,j)，对其邻域的各个像素点进行强度的统计，令处理后新像素点等于原像素点邻域强度为众数的像素点的平均数
%考虑优化：对于图像的边缘，可以作更精细的操作（邻域半径减少）（图像边缘的提取可以通过edge函数实现且可以膨胀边界）；基于时间关系尚未实现上述操作。

Mode=@(x)mode(x);
[H,W,~]=size(filename);
img=zeros(H,W,3);
img0= uint8(rgb2gray(filename).*(180/255));%构造图像的强度矩阵
img1=colfilt(img0,[ksize ksize],'sliding',Mode);%利用confilt函数找到邻域强度众数矩阵（图片边界尚未处理）
img2=colfilt(img0,[ksize ksize],'sliding',@get_modenum);%利用confilt函数找到邻域强度众数频数矩阵（图片边界尚未处理）
for i=1:H
    for j=1:W
        for m=i-(ksize-1)/2:i+(ksize-1)/2
            if(m<1||m>H)
                break;
            end
            for n=j-(ksize-1)/2:j+(ksize-1)/2
                if(n<1||n>W)
                    break;
                end
                if(img0(m,n)==img1(i,j))%平均构造新像素点
                    img(i,j,1)=img(i,j,1)+double(filename(m,n,1))/img2(i,j);                    
                    img(i,j,2)=img(i,j,2)+double(filename(m,n,2))/img2(i,j);
                    img(i,j,3)=img(i,j,3)+double(filename(m,n,3))/img2(i,j);
                end
            end 
        end
    end
end
img=uint8(img);
imshow(img);