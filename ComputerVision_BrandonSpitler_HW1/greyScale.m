function [ newFile ] = greyScale( ncurrent_img )
    [x1,y1,z1]=size(ncurrent_img);
    newFile=zeros(x1,y1,z1);
    newFile=uint8(newFile);
    for i=2:1:(x1-1)
        for n=2:1:(y1-1)

            newFile(i,n,1)=(ncurrent_img(i,n,1)+ncurrent_img(i,n,2)+ncurrent_img(i,n,3))/3;  
            newFile(i,n,2)=(ncurrent_img(i,n,1)+ncurrent_img(i,n,2)+ncurrent_img(i,n,3))/3;

            newFile(i,n,3)=(ncurrent_img(i,n,1)+ncurrent_img(i,n,2)+ncurrent_img(i,n,3))/3;

        end
    end
end

