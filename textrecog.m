clc, close all,clear all

img = imread('D:\machine learning\number.png');

imshow(img)

if size(img,3)==3
    img=rgb2gray(img);
end

threshold = graythresh(img);
img=~imbinarize(img,threshold);

img = bwareaopen(img,30);

word=[ ];
re = img;
fid = fopen('text.txt', 'wt');

load templates
global templates

num_letras=size(templates,2);

while 1
    [f1, re]=lines(re);
    imgn=f1;
    [L, Ne] = bwlabel(imgn);
    for n=1:Ne
        [r,c]=find(L==n);
        n1=imgn(min(r):max(r),min(c):max(c));
        img_r=imresize(n1,[42 24]);
        letter=read_letter(img_r,num_letras);
        word=[word letter];
    end
    fprintf(fid,'%s\n',word);
    word=[];
    
    if isempty(re)
        break
    end
end
fclose(fid);
winopen('text.txt')




  