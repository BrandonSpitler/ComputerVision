function [ file ] = ScaleNearestNeightbor( ncurrent_img,factor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [xSize,ySize,zSize]=size(ncurrent_img);
    newFile=zeros(xSize*factor,ySize*factor,zSize);
    newFile=uint8(newFile);

    
    for i=1:1:xSize-1
        for n=1:1:ySize-1
            for ni=1:1:zSize
                
                for ifactored= floor(i*factor-(factor-1)):1:floor((i+1)*factor-(factor-1))-1
                    for nfactored= floor(n*factor-(factor-1)):1:floor((n+1)*factor-(factor-1))-1
                        x=(ifactored+(factor-1))/factor;
                        y=(nfactored+(factor-1))/factor;
                        x1=i;
                        x2=i+1;
                        y1=n;
                        y2=n+1;
                        nearestX=0;
                        nearestY=0;
                        if x-x1>x2-x
                            nearestX=x2;
                        else
                            nearestX=x1;
                        end
                        
                        if y-y1>y2-y
                            nearestY=y2;
                        else
                            nearestY=y1;
                        end
                        
                        newFile(ifactored,nfactored,ni)=ncurrent_img(nearestX,nearestY,ni);
                    end
                end
            end
        end
    end

    file=newFile;
end