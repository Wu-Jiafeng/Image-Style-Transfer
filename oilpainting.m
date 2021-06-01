function img=oilpainting(filename,ksize)
%����oilpaintingʵ��ͼƬ���ͻ��˾����
%���������filename��������ͼ��/ksize������뾶��һ��Ϊ9/11��
%���������img�������ͼ��
%�㷨˼·�������ͻ�ճ�����ص��ص㣬����ÿ�����ص�p(i,j)����������ĸ������ص����ǿ�ȵ�ͳ�ƣ����������ص����ԭ���ص�����ǿ��Ϊ���������ص��ƽ����
%�����Ż�������ͼ��ı�Ե������������ϸ�Ĳ���������뾶���٣���ͼ���Ե����ȡ����ͨ��edge����ʵ���ҿ������ͱ߽磩������ʱ���ϵ��δʵ������������

Mode=@(x)mode(x);
[H,W,~]=size(filename);
img=zeros(H,W,3);
img0= uint8(rgb2gray(filename).*(180/255));%����ͼ���ǿ�Ⱦ���
img1=colfilt(img0,[ksize ksize],'sliding',Mode);%����confilt�����ҵ�����ǿ����������ͼƬ�߽���δ����
img2=colfilt(img0,[ksize ksize],'sliding',@get_modenum);%����confilt�����ҵ�����ǿ������Ƶ������ͼƬ�߽���δ����
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
                if(img0(m,n)==img1(i,j))%ƽ�����������ص�
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