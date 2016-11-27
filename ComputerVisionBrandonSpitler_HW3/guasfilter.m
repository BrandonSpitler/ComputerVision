function [ retMat ] = guasfilter( matrix, sd)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [matSize,c2,~]=size(matrix);
    row=matSize;
        col=matSize;
        %,dep]=size(matrix);
    guasMatrix=zeros(row,col);
    sum=0;
    retMat=zeros(row,col);
    for i=-(row-1)/2:1:(row-1)/2
        for n=-(col-1)/2:1:(col-1)/2
            guasMultiplier=(1/(2*pi*(sd^2)))*exp(-1*(i^2+n^2)/(2*(sd^2)));
            sum=guasMultiplier+sum;
            guasMatrix(i+(row-1)/2+1,n+(row-1)/2+1)=guasMultiplier;
        end
    end
    guasMatrix=guasMatrix./sum;
    for i=1:1:matSize
       for n=1:1:matSize
           mainPixel=guasMatrix(i,n)*matrix(i,n)+mainPixel;
       end
    end
    for i=1:1:matSize
       for n=1:1:matSize
           retMat(i,n)=mainPixel(i,n);
       end
    end
end

