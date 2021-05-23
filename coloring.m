img = imread('D:\machine learning\PR of fruit\orange2.jpg');
imm = imresize(img,[220 220]);
imm1 = rgb2gray(imm);
print(imm);



[m, n]=size(e);
i1=0;
j1=0;

for i=1:m
    for j=1:n
        if(e(i,j)==1)
            k2=e(i,j);
             i1=i;
             j1=j;
            break
        end
    end
    break
end

k=1;k1=1;
for i=1:m
    for j=1:n
        if(e(i,j)==1)
            disi(k)=abs(i-i1); 
            disj(k1)=abs(j-j1);
             k=k+1;
              k1=k1+1;
        end
    end
end

maxi=max(disi);



