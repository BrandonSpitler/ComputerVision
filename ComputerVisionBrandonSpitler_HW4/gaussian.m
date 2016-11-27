function [ file ] = gaussian( ncurrent_img, nsd,nsize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    weightedMatrixNorm=gaussianMatrix(nsize,nsize,nsd);
    sizeOfGuass=nsize;
    sizeOfGuassDevTwo=floor(sizeOfGuass);
    [x1,y1,z1]=size(ncurrent_img);
    newFile=zeros(x1,y1,z1);
    newFile=uint8(newFile);
    

    for i=1:1:(x1)
    %for i=1+sizeOfGuassDevTwo:1:(x1-sizeOfGuassDevTwo)
        %for n=1+sizeOfGuassDevTwo:1:(y1-sizeOfGuassDevTwo)
        for n=1:1:(y1)
            for ni=1:1:z1
                
                if(i>=1+sizeOfGuassDevTwo && i <= x1-sizeOfGuassDevTwo && n>=1+sizeOfGuassDevTwo && n<= y1-sizeOfGuassDevTwo)
                    for x=0:1:(sizeOfGuass-1)
                        for y=0:1:(sizeOfGuass-1)
                            newFile(i,n,ni)= ncurrent_img(i+x-sizeOfGuassDevTwo,n+y-sizeOfGuassDevTwo,ni)*weightedMatrixNorm(x+1,y+1)+newFile(i,n,ni);
                        end
                    end
                else
                    sum=0;
                    for x=0:1:(sizeOfGuass-1)
                        for y=0:1:(sizeOfGuass-1)
                            if i+x-sizeOfGuassDevTwo > 0 && n+y-sizeOfGuassDevTwo >0 && x1 >= i+x-sizeOfGuassDevTwo && y1>=n+y-sizeOfGuassDevTwo
                                newFile(i,n,ni)= ncurrent_img(i+x-sizeOfGuassDevTwo,n+y-sizeOfGuassDevTwo,ni)*weightedMatrixNorm(x+1,y+1)+newFile(i,n,ni);
                                sum=weightedMatrixNorm(x+1,y+1)+sum;
                            end
                            
                        end
                    end
                    newFile(i,n,ni)=newFile(i,n,ni)/sum;
                end
               
            end
        end
    end

    file=newFile;
end





