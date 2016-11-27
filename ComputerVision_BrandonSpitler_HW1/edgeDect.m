function [ newFile ] = edgeDect( ncurrent_img,threshold,yDir )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


    [x1,y1,z1]=size(ncurrent_img);
    newFile=zeros(x1,y1,z1);
    newFile=uint8(newFile);
    newImage=greyScale(ncurrent_img);
    if(yDir==0)
        l=1;
        t=0;
    else
       l=0;
       t=1;
    end
    for i=2:1:(x1-1)
        for n=2:1:(y1-1)
            if(abs(newImage(i,n,1)-newImage(i-l,n-t,1))<threshold)
                newFile(i,n,1)=255;
                newFile(i,n,2)=255;
                newFile(i,n,3)=255;
            else
                newFile(i,n,1)=0;
                newFile(i,n,2)=0;
                newFile(i,n,3)=0;
                
            end
        end
    end


end

