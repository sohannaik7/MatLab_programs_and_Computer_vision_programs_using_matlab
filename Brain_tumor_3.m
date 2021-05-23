clc
clear all
close all

%%input
[I, path] =uigetfile('*.jpg','select the image');
str=strcat(path,I);
s = imread(str);
figure,
imshow(s);
title('Input Image');

%%Anisotropic Filter
numiter=10;
    delta=1/7;
    kappa= 15;
    option=2;
    disp('Preprocessing image..');
    img = anisodiff(s,numiter,delta,kappa,option);
    img=uint8(img);
    
img= imresize(img,[256,256]);
if size(img,3)>1
    img = rgb2gray(img);
end
figure;
imshow(img);
title('Filter Image');

%%Thresholding
sout=imresize(img,[256,256]);
t=60;
thdg=t+((max(img(:))+min(img(:)))./2);
for i=1:1:size(img,1)
    for j=1:1:size(img,2)
        if img(i,j)>thdg
            sout(i,j)=1;
        else
            sout(i,j)=0;
        end
    end
end

%%Morphological

label = bwlabel(sout);
stats= regionprops(logical(sout),'Solidity','Area','BoundingBox');
density= [stats.Solidity];
area= [stats.Area];
highdensearea = density>0.6;
maxarea= max(area(highdensearea));
tumor_label= find(area==maxarea);
tumor=ismember(label,tumor_label);
if maxarea>100
    figure;
    imshow(tumor)
    title('Tumor');
else
    h= msgbox('NO TUMOR FOUND','status');
    return;
end

%%Bounding Box
box = stats(tumor_label);
wantedBox = box.BoundingBox;
figure;
imshow(img);
title('BoundingBox');
hold on;
rectangle('Position',wantedBox,'EdgeColor','y');
hold off;


%%Tumor Outline

dilationAmnt = 5;
rad = floor(dilationAmnt);
[r,c] = size(tumor);
fillimg= imfill(tumor,'holes');
for i=1: r
    for j=1:c
        x1= i-rad;
        x2= i+rad;
        y1= j-rad;
        y2= j+rad;
        if x1<1
            x1=1;
        end
        if x2>r
            x2=r;
        end
        if y1<1
            y1=1;
        end
        if y2>c
            y2=c;
        end
        erodeimg(i,j) = min(min(fillimg(x1:x2,y1:y2)));
    end
end
figure;
imshow(erodeimg);
title('Erode Image');


%%Subtraction erod from original

tumoroutline=tumor;
tumoroutline(erodeimg)=0;
figure;
imshow(tumoroutline);
title('Tumor Outline');
        
%%Outline in blue
rgb =img(:,:,[1 1 1]);
red = rgb(:,:,1);
red(tumoroutline)=0;
green = rgb(:,:,2);
green(tumoroutline)=0;
blue = rgb(:,:,3);
blue(tumoroutline)=255;

tumoroutlineInserted(:,:,1)=red;
tumoroutlineInserted(:,:,1)=green;
tumoroutlineInserted(:,:,1)=blue;
figure;
imshow(tumoroutlineInserted);
title('Tumor Detection');

%%Display

figure;
subplot(231),imshow(s);
subplot(232);imshow(img);
subplot(233);imshow(img);
hold on;rectangle('Position',wantedBox,'Edgecolor','y');hold off;
subplot(234);imshow(tumor);
subplot(235);imshow(tumoroutline);
subplot(236);imshow(tumoroutlineInserted);

    
