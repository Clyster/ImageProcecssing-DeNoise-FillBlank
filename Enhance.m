function y = Enhance(x)

    R = x(:,:,1);
    G = x(:,:,2);
    B = x(:,:,3);
    R = imsharpen(R);
    G = imsharpen(G);
    B = imsharpen(B);
    R = imadjust(R);
    G = imadjust(G);
    B = imadjust(B);
    R = medfilt2(R);
    G = medfilt2(G);
    B = medfilt2(B);
    y(:,:,1)=R(:,:,1);
    y(:,:,2)=G(:,:,1);
    y(:,:,3)=B(:,:,1);

end
