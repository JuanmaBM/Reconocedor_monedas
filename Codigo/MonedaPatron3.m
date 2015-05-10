function [per,selcol,monedas] = MonedaPatron3()
load vid3
vid=vid2;
set(vid,'FramesPerTrigger', Inf);
set(vid,'ReturnedColorspace','rgb')
vid.FrameGrabInterval = 5;
start(vid);
per=0;
selcol=0;
w=1;
while (vid.FramesAcquired<=15)
imgReal = getsnapshot(vid);
Im = im2double(imgReal);
    data=rgb2gray(imgReal);
    dataum = imcomplement( im2bw(data/0.8));
    %imshow(dataum)
    [r c p] = size(imgReal);
    imR = squeeze(Im(:,:,1));
    imG = squeeze(Im(:,:,2));
    imB = squeeze(Im(:,:,3));
    imbinR = im2bw(imR,graythresh(imR));
    imbinG = im2bw(imG,graythresh(imG));
    imbinB = im2bw(imB,graythresh(imB));
    imBin = imcomplement(imbinR&imbinG&imbinB);
    se = strel('disk',3);
    imclean = imopen(dataum,se);
    imclean = imfill(imclean,'holes');
    imclean = imclearborder(imclean);    
    [L ne] = bwlabel(imclean);
    Propiedades     = regionprops(L,'Area','Perimeter', 'BoundingBox','Centroid');
    rLabel = zeros(r,c);
    gLabel = zeros(r,c);
    bLabel = zeros(r,c);
    for i=1:ne
        rLabel(L==i) = median(imR(L==i));
        gLabel(L==i) = median(imG(L==i));
        bLabel(L==i) = median(imB(L==i));
    end
    imlabel = cat(3,rLabel,gLabel,bLabel);
    %imshow(imclean)


    Areas = find([Propiedades.Area] > 1000 & [Propiedades.Area] < 3000);
    if size(Areas,2) > 0
    
    monedas=cell(1,size(Areas,2));
        corte = round(Propiedades(Areas(1)).BoundingBox);
        monedas = imresize(imcrop(imgReal,corte),[70 70]);
        per(w) = Propiedades(Areas(1)).Perimeter;
        centroid = Propiedades(Areas(1)).Centroid;
        selcol(w) = imlabel(floor(centroid(2)),floor(centroid(1)));
        
    end 
    w=w+1;
end
stop(vid);
flushdata(vid);
%per=per(size(Areas,2));
%selcol=selcol(size(Areas,2));
per = mean(per(2:end));
selcol = mean(selcol(2:end));
end

