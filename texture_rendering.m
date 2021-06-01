function img=texture_rendering(H,J)
%函数texture_rendering实现纹理迁移，生成符合素描纹理的灰度图img
%输入参数：H（原始铅笔痕迹纹理图）、J（经过直方图匹配的待处理色调图）
%输出参数：img(符合素描纹理的灰度图)
%思路：存在gamma变换使H^beta=img且img≈J，此时可以化为最优化问题通过共轭梯度法求解beta

renderdepth=0.7;%
lambda=0.2;
[H2,W2,~]=size(J);
k2=H2*W2;
%初始化向量简便计算
H=imresize(double(H),[H2,W2]);
H=reshape(H,k2,1);
logH=log(H);
logH=spdiags(logH,0,k2,k2);

J=imresize(double(J),[H2,W2]);
J=reshape(J,k2,1);
logJ=log(J);
%两个梯度
e=ones(k2,1);
Dx=spdiags([-e,e],[0,H2],k2,k2);
Dy=spdiags([-e,e],[0,1],k2,k2);
%带入求解公式计算
A=lambda*(Dx*Dx'+Dy*Dy')+(logH)'*logH;
b=(logH)'*logJ;
%计算向量形式的beta
beta=pcg(A,b,1e-6,60);
%转化成矩阵形式并拉伸
beta=reshape(beta,H2,W2);
beta=(beta-min(beta(:)))/(max(beta(:))-min(beta(:)))*5;
%使用共轭梯度法求解β
H=reshape(H,H2,W2);
T=H.^beta;
img=uint8(T.^renderdepth);