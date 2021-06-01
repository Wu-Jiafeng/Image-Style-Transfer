function img=texture_rendering(H,J)
%����texture_renderingʵ������Ǩ�ƣ����ɷ�����������ĻҶ�ͼimg
%���������H��ԭʼǦ�ʺۼ�����ͼ����J������ֱ��ͼƥ��Ĵ�����ɫ��ͼ��
%���������img(������������ĻҶ�ͼ)
%˼·������gamma�任ʹH^beta=img��img��J����ʱ���Ի�Ϊ���Ż�����ͨ�������ݶȷ����beta

renderdepth=0.7;%
lambda=0.2;
[H2,W2,~]=size(J);
k2=H2*W2;
%��ʼ������������
H=imresize(double(H),[H2,W2]);
H=reshape(H,k2,1);
logH=log(H);
logH=spdiags(logH,0,k2,k2);

J=imresize(double(J),[H2,W2]);
J=reshape(J,k2,1);
logJ=log(J);
%�����ݶ�
e=ones(k2,1);
Dx=spdiags([-e,e],[0,H2],k2,k2);
Dy=spdiags([-e,e],[0,1],k2,k2);
%������⹫ʽ����
A=lambda*(Dx*Dx'+Dy*Dy')+(logH)'*logH;
b=(logH)'*logJ;
%����������ʽ��beta
beta=pcg(A,b,1e-6,60);
%ת���ɾ�����ʽ������
beta=reshape(beta,H2,W2);
beta=(beta-min(beta(:)))/(max(beta(:))-min(beta(:)))*5;
%ʹ�ù����ݶȷ�����
H=reshape(H,H2,W2);
T=H.^beta;
img=uint8(T.^renderdepth);