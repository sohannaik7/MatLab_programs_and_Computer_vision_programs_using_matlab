clear;
image=imread('orange1.jpg');
im=imresize(image,[150 150]);
im1=rgb2gray(im);
e=edge(im1);
%imshow(e)
%imagesc(im(:,:,2));

r1=im(:,:,1);
g1=im(:,:,2);
b1=im(:,:,3);
m1=mean2(g1);
m2=mean2(r1);
m3=mean2(b1);
r2=m2/(m1+m2+m3);
disp(r2)

image2 = imread('apple.jpg');
imm=imresize(image2,[150 150]);
im2=rgb2gray(imm);
ee=edge(im2);
%imshow(ee)


r2=imm(:,:,1);
g2=imm(:,:,2);
b2=imm(:,:,3);
m11=mean2(g2);
m22=mean2(r2);
m33=mean2(b2);
res=m22/(m11+m22+m33);
disp(res)



if(res<=0.3600)
    dis = 'not orange';
    disp(dis);
end

if(res>=0.3600)
    dispp='is orange';
    disp(dispp);
end
    

subplot(3,3,1);
imshow(im1);

subplot(3,3,2);
imshow(im2);

subplot(3,3,3);
imhist(im);

subplot(3,3,4);
imhist(imm);

subplot(3,3,5)
imagesc(im(:,:,3));
  
subplot(3,3,6)
imagesc(imm(:,:,3));
    


