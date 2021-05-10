clear
clc
addpath = "BM3D-master";    %λ
x = imread("img2.jpg");
y = imread("img1.jpg");
T = imread("Penguins.jpg");
PSNR=0;
info = imfinfo("img1.jpg")

mask_loss = EdgeMark(y);% ͨ����Ե���ɸѡ����Ч��ȷʵ����
[B,L,N] = bwboundaries(mask_loss);
figure(1)
title("ȱʧ���ּ��")
imshow(y); hold on;
for k=1:length(B),   %���߿���
   boundary = B{k};
   if(k > N)
     plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
   else
     plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
   end
end
title("ȱʧ���ּ��")
%%
x = imresize(x,[info.Height info.Width]);   %���ڶ�����ͼƬ���д�С����
x=im2double(x);
% T=im2double(T);
[PSNR, x2]=CBM3D(1, x ,121);  %����Ŀǰ���ҵ�����ǿ�˲�����

x2=im2uint8(x2);
x2 = Enhance(x2);    %ͼ����ǿ
figure(2)
imshow(x2)
title("�˲����");
psnr(x2, T)
%%
z = Combine(x2,y);     %ƴ�Ӻ���
figure(3)
imshow(z)
title("ƴ�Ӻ�");

% imwrite(z, "After.jpg");
psnr(z,T)


%����㷨����������







