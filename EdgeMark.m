function output = EdgeMark(y)

a = zeros(size(y,1),size(y,2));
m = zeros(size(y,1),size(y,2));
n = zeros(size(y,1),size(y,2));
for i=1:size(y,1)  %����ٰ׿�
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
a = imbinarize(a,'adaptive');%��ֵ��һ������Ч���������Ե��������ֵĶ���
%-------------------------------------------------------------------------
G = bwboundaries(a);%�ȼ�����а׿��Ե
i = 1;
for k=1:size(G)
    if(size(G{k},1)>230)
        m = m + roipoly(n,G{k}(:,2),G{k}(:,1));
        i=i+1;
    end
end %ͨ����Ե�ܳ�ɸ��������Ч�İ׿飬�����¼����һ��ͼ����
%-------------------------------------------------------------------------
output =m;



end