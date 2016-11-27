function [ file ] = BilinearImageScaling( ncurrent_img,factor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [xSize,ySize,zSize]=size(ncurrent_img);
    newFile=zeros((floor(xSize*factor)),floor(ySize*factor),zSize);
    [xSizeF,ySizeF,zSize]=size(newFile);
    newFile=uint8(newFile);
    for i=1:1:xSizeF-1
            for n=1:1:ySizeF-1
                for ni=1:1:zSize
                   x=i/factor;

                   y=n/factor;
                   x1=floor(i/factor);%todo
                   
                       
                   x2=ceil(i/factor);    %todo 
                   if x2==x1
                       x2=x2+1;
                   end
                   if(x1<=0)
                       x1=1;
                       x2=2;
                   end
                   if x2>xSize
                       x2=xSize;
                       x1=xSize-1;
                   end
                   
                     
                   
                  
                   y1=floor(n/factor); %todo
                   y2=ceil(n/factor); %todo
                   if y1==y2
                       y2=y2+1;
                   end
                   if y1<=0
                       y1=1;
                       y2=2;
                   end
                   if y2 >ySize
                       y2=ySize;
                       y1=ySize-1;
                   end
                   fOfY1=((x2-x)/(x2-x1))*ncurrent_img(x1,y1,ni)+(x-x1)/(x2-x1)*ncurrent_img(x2,y1,ni);
                   fOfY2=((x2-x)/(x2-x1))*ncurrent_img(x1,y2,ni)+(x-x1)/(x2-x1)*ncurrent_img(x2,y2,ni);
                
                   ValueToInsert=(y2-y)/(y2-y1)*fOfY1+(y-y1)/(y2-y1)*fOfY2;
                    
                   newFile(i,n,ni)=ValueToInsert;
                end
            end
     end
    
%     for i=1:1:xSize-1
%         for n=1:1:ySize-1
%             for ni=1:1:zSize
%                 
%                 for ifactored= floor(i*factor-(factor-1)):1:floor((i+1)*factor-(factor-1))
%                     for nfactored= floor(n*factor-(factor-1)):1:floor((n+1)*factor-(factor-1))                        x=(ifactored+(factor-1))/factor;
%                         y=(nfactored+(factor-1))/factor;
%                         x1=i;
%                         x2=i+1;
%                         y1=n;
%                         y2=n+1;
%                         fOfY1=((x2-x)/(x2-x1))*ncurrent_img(x1,y1,ni)+(x-x1)/(x2-x1)*ncurrent_img(x2,y1,ni);
%                         fOfY2=((x2-x)/(x2-x1))*ncurrent_img(x1,y2,ni)+(x-x1)/(x2-x1)*ncurrent_img(x2,y2,ni);
%                 
%                         ValueToInsert=(y2-y)/(y2-y1)*fOfY1+(y-y1)/(y2-y1)*fOfY2;
%                 
%                         newFile(ifactored,nfactored,ni)=ValueToInsert;
%                     end
%                 end
%             end
%         end
%     end

    file=newFile;
end


