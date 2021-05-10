function y = Combine(x, y)  %用x填补y的空缺
    a = zeros(size(y,1),size(y,2));
    m = zeros(size(y,1),size(y,2));
    n = zeros(size(y,1),size(y,2));  %制作mask的底板
    for i=1:size(y,1)   %常规抠白块制作mask
        for j=1:size(y,2)
            b = uint16(y(i,j,1));
            c = uint16(y(i,j,2));
            d = uint16(y(i,j,3));
            ob =double([b,c,d]);
        	%if(b>253&&c>253&&d>253||(b+c+d)>720)
            if((b>253&&c>253&&d>253)||((var(ob)<1.2)&&((b+c+d)>720)))
            a(i,j) =255;
            end
        end
    end
    a = imsharpen(a);
    a = medfilt2(a,[3 3]); %卷积核不能太大否则会使图形的边缘变的圆滑
    a = imbinarize(a,'adaptive');    %对mask进行增强、去噪
    %kernel-------
    G = bwboundaries(a);
    i = 1;
    for k=1:size(G)
        if(size(G{k},1)>230)
            %H{i}=G{k};
            m = m + roipoly(n,G{k}(:,2),G{k}(:,1));
            i=i+1;
        end
    end %筛，制作蒙片
    %kernel------
    for o=1:28    
        m = ordfilt2(m,9,ones(3,3));%最大值滤波
    end       %多次进行是为了扩大mask上的白块，尽力遮掉最后的白线
    
    %基于蒙片mask合并
    for i=1:size(y,1)       %首先先遍历蒙片mask上所有的点
        for j=1:size(y,2)   %注：mask大小和原图大小相同
        	if(m(i,j)==1)   %如果mask上是白色像素点
                y(i ,j , 1)=min(x(i ,j , 1),y(i ,j , 1));
                y(i ,j , 2)=min(x(i ,j , 2),y(i ,j , 2));
                y(i ,j , 3)=min(x(i ,j , 3),y(i ,j , 3));
            end             %对应的被填补图片上的像素点等于填补图片的像素点
        end
    end
end

%核心思想就是把缺失部分的像素点记录下来，以图片的形式而非数组的形式
%方便之处在于能够处理缺失羽化的地方—对mask白色部分进行膨胀而泛性的增加填补面积
%这个方法普适度很高


    