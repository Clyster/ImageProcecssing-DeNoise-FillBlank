clear
clc
addpath = "BM3D-master";    %位
x = imread("img2.jpg");
y = imread("img1.jpg");
T = imread("Penguins.jpg");
PSNR=0;
info = imfinfo("img1.jpg")

mask_loss = EdgeMark(y);% 通过边缘检测筛选出有效的确实部分
[B,L,N] = bwboundaries(mask_loss);
figure(1)
title("缺失部分检测")
imshow(y); hold on;
for k=1:length(B),   %画边框线
   boundary = B{k};
   if(k > N)
     plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
   else
     plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
   end
end
title("缺失部分检测")
%%
x = imresize(x,[info.Height info.Width]);   %基于读到的图片经行大小调整
x=im2double(x);
% T=im2double(T);
[PSNR, x2]=CBM3D(1, x ,121);  %调用目前能找到的最强滤波代码

x2=im2uint8(x2);
x2 = Enhance(x2);    %图像增强
figure(2)
imshow(x2)
title("滤波完成");
psnr(x2, T)
%%
z = Combine(x2,y);     %拼接函数
figure(3)
imshow(z)
title("拼接后");

% imwrite(z, "After.jpg");
psnr(z,T)


%这个算法具有普适性







