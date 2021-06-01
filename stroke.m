function S = stroke(im, ks, dirNum)
%����strokeʵ�ִ�����ͼƬ��Ǧ�ʽṹ����
%���������im��������ͼƬ��,ks������˴�С��,dirNum���������ϳ��ݶȣ�
%���������S��������ͼƬ��Ǧ�ʽṹ��
%˼·�����Ʊ�Ե��ȡ����Ϊ��ģ��Ǧ�ʽṹ�����ܾ�ȷ�����Ե�ݶȣ�Ӧ���ö෽��ƫ��ģ��Ǧ������ʱ��ͿĨ

%�����ݶ�
strokedepth=0.7;%����߼���
[H, W, sc] = size(im);
if sc == 3
   im = rgb2gray(im);
end
sh=fspecial('sobel');%����sobel���Ӽ���ƫ��
sv=sh';
imX=imfilter(double(im),sh,'replicate');
imY=imfilter(double(im),sv,'replicate');
imEdge=uint8((imX.^2+imY.^2).^0.5);
%����ˮƽ����ľ���ˣ����ں�����ת��ȡ��ͬ������ݶȣ�
kerRef=zeros(ks*2+1);
kerRef(ks+1,:)=1;
%ѡȡ�ݶ����ķ�����Ϊ��Ե�ķ���
ker=zeros(ks*2+1,ks*2+1,dirNum);
for n=1:dirNum
    ker(:,:,n)=imrotate(kerRef,(n-1)*180/dirNum,'bilinear','crop');
end
response=zeros(H,W,dirNum);
for n=1:dirNum
    response(:,:,n)=conv2(imEdge,ker(:,:,n),'same');
end
[~,index]=max(response,[],3); 
%����Ǧ�ʽṹ
C = zeros(H,W,dirNum);
for n=1:dirNum
    C(:,:,n)=imEdge.*uint8(index==n);
end
Spn=zeros(H,W,dirNum);
for n=1:dirNum
    Spn(:,:,n)=conv2(C(:,:,n),ker(:,:,n),'same');
end
Sp=sum(Spn,3);
Sp=(Sp-min(Sp(:)))/(max(Sp(:))-min(Sp(:)));%���ݹ�һ��
S=1-Sp;
S=S.^strokedepth;