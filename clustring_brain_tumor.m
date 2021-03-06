 close all;
 clear all;
 clc;
 warning off

 
 
 a = imread('2 no.jpeg');
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorChannels] = size(a);
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Convert it to gray scale by taking only the green channel.
  a = rgb2gray(a); 
end
 
 
 imData = reshape(a,[],1);
 imData = double(imData);
 [IDX nn] = kmeans(imData,4);
 imIDX = reshape(IDX, size(a));
 
 figure, 
    imshow(imIDX, []),title('tumor image');
     
  
   bw = (imIDX==2);
   se = ones(5);
   bw = imopen(bw, se);
   bw = bwareaopen(bw,400);
   figure,imshow(bw);
   
   [R C] = size(bw)
   
   for i = 1:R
       for j=1:C
           if bw(i,j) == 1
               Out(i,j) = a(i,j);
           else
               Out(i,j) = 0;
           end 
       end
   end
  figure;imshow(Out,[])
               
   
   figure,
    subplot(3,2,1),imshow(imIDX==1, []);
        subplot(3,2,2),imshow(imIDX==2, []);
            subplot(3,2,3),imshow(imIDX==3, []);
                subplot(3,2,4),imshow(imIDX==4, []);
   


    
 
 
 