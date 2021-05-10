function output = EdgeMark(y)

a = zeros(size(y,1),size(y,2));
m = zeros(size(y,1),size(y,2));
n = zeros(size(y,1),size(y,2));
for i=1:size(y,1)  %常规抠白块
    for j=1:size(y,2)
        b = uint16(y(i,j,1));
        c = uint16(y(i,j,2));
        d = uint16(y(i,j,3));
        ob =double([b,c,d]);
        if((b>253&&c>253&&d>253)||((var(ob)<1.5)&&((b+c+d)>747)))
            a(i,j) =255;
        end
    end
end
%-------------------------------------------------------------------------
a = imsharpen(a);
a = medfilt2(a,[3 3]);
a = imbinarize(a,'adaptive');%二值化一下能有效避免下面边缘检测检测出奇怪的东西
%-------------------------------------------------------------------------
G = bwboundaries(a);%先检测所有白块边缘
i = 1;
for k=1:size(G)
    if(size(G{k},1)>230)
        m = m + roipoly(n,G{k}(:,2),G{k}(:,1));
        i=i+1;
    end
end %通过边缘周长筛出来的有效的白块，将其记录在另一张图上面
%-------------------------------------------------------------------------
output =m;



end