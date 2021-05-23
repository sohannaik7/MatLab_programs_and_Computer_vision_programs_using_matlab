I = imread('D:\machine learning\moon.jpg');

I = rgb2gray(I);
mm = I;
k = 150 - I; 
k = imtophat(k,strel('disk',15));

marker = imerode(k, strel('line',10,0));
Iclean = imreconstruct(marker, k);
BW2 = imbinarize(Iclean);
p = BW2; 

%figure; 
Rmin = 30;
Rmax = 65;
%imshowpair(k,BW2,'montage');
k = 255 - k;
k = imbinarize(k);
k=edge(k);
[centers, radii, metric] = imfindcircles(k,[7 100]);
centersStrong5 = centers(1:100,:);
radiiStrong5 = radii(1:100);
metricStrong5 = metric(1:100);

%viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
Rmin = 30;
Rmax = 65;
[centersBright, radiiBright] = imfindcircles(k,[Rmin Rmax],'ObjectPolarity','bright');
[radiiDark] = imfindcircles(k,[Rmin Rmax],'ObjectPolarity','dark');

points = detectSURFFeatures(p); 


subplot(1,4,1);
plot(points.selectStrongest(50));

subplot(1,4,2);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','r');

p = imresize(p,[300 300]);
subplot(1,4,3);
imshow(p);

subplot(1,4,4);
imshow(mm);
