function y = Combine(x, y)  %��x�y�Ŀ�ȱ
    a = zeros(size(y,1),size(y,2));
    m = zeros(size(y,1),size(y,2));
    n = zeros(size(y,1),size(y,2));  %����mask�ĵװ�
    for i=1:size(y,1)   %����ٰ׿�����mask
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
    a = medfilt2(a,[3 3]); %����˲���̫������ʹͼ�εı�Ե���Բ��
    a = imbinarize(a,'adaptive');    %��mask������ǿ��ȥ��
    %kernel-------
    G = bwboundaries(a);
    i = 1;
    for k=1:size(G)
        if(size(G{k},1)>230)
            %H{i}=G{k};
            m = m + roipoly(n,G{k}(:,2),G{k}(:,1));
            i=i+1;
        end
    end %ɸ��������Ƭ
    %kernel------
    for o=1:28    
        m = ordfilt2(m,9,ones(3,3));%���ֵ�˲�
    end       %��ν�����Ϊ������mask�ϵİ׿飬�����ڵ����İ���
    
    %������Ƭmask�ϲ�
    for i=1:size(y,1)       %�����ȱ�����Ƭmask�����еĵ�
        for j=1:size(y,2)   %ע��mask��С��ԭͼ��С��ͬ
        	if(m(i,j)==1)   %���mask���ǰ�ɫ���ص�
                y(i ,j , 1)=min(x(i ,j , 1),y(i ,j , 1));
                y(i ,j , 2)=min(x(i ,j , 2),y(i ,j , 2));
                y(i ,j , 3)=min(x(i ,j , 3),y(i ,j , 3));
            end             %��Ӧ�ı��ͼƬ�ϵ����ص�����ͼƬ�����ص�
        end
    end
end

%����˼����ǰ�ȱʧ���ֵ����ص��¼��������ͼƬ����ʽ�����������ʽ
%����֮�������ܹ�����ȱʧ�𻯵ĵط�����mask��ɫ���ֽ������Ͷ����Ե���������
%����������ʶȺܸ�


    