function S = stroke(im, ks, dirNum)
%函数stroke实现待处理图片的铅笔结构生成
%输入参数：im（待处理图片）,ks（卷积核大小）,dirNum（多个方向合成梯度）
%输出参数：S（待处理图片的铅笔结构）
%思路：类似边缘提取，但为了模拟铅笔结构，不能精确计算边缘梯度，应该用多方向偏导模拟铅笔作画时的涂抹

%计算梯度
strokedepth=0.7;%多描边几遍
[H, W, sc] = size(im);
if sc == 3
   im = rgb2gray(im);
end
sh=fspecial('sobel');%利用sobel算子计算偏导
sv=sh';
imX=imfilter(double(im),sh,'replicate');
imY=imfilter(double(im),sv,'replicate');
imEdge=uint8((imX.^2+imY.^2).^0.5);
%构造水平方向的卷积核（便于后面旋转获取不同方向的梯度）
kerRef=zeros(ks*2+1);
kerRef(ks+1,:)=1;
%选取梯度最大的方向作为边缘的方向
ker=zeros(ks*2+1,ks*2+1,dirNum);
for n=1:dirNum
    ker(:,:,n)=imrotate(kerRef,(n-1)*180/dirNum,'bilinear','crop');
end
response=zeros(H,W,dirNum);
for n=1:dirNum
    response(:,:,n)=conv2(imEdge,ker(:,:,n),'same');
end
[~,index]=max(response,[],3); 
%构造铅笔结构
C = zeros(H,W,dirNum);
for n=1:dirNum
    C(:,:,n)=imEdge.*uint8(index==n);
end
Spn=zeros(H,W,dirNum);
for n=1:dirNum
    Spn(:,:,n)=conv2(C(:,:,n),ker(:,:,n),'same');
end
Sp=sum(Spn,3);
Sp=(Sp-min(Sp(:)))/(max(Sp(:))-min(Sp(:)));%数据归一化
S=1-Sp;
S=S.^strokedepth;