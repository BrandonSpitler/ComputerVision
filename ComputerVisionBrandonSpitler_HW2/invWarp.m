 function [ warpNewImage,mergeImage ] = invWarp( image1,image2, Matrix )
    [x1,y1,z1]=size(image1);
    [x2,y2,z2]=size(image2);
    [X,Y]=meshgrid(1:y1,1:x1);
    
    pointsOut=applyHomography([X(:),Y(:)]',Matrix);
 
    xMin=min(1,floor(min(pointsOut(2,:))));
    xMax=max(x2,ceil(max(pointsOut(2,:))));
    yMin=min(1,floor(min(pointsOut(1,:))));
    yMax=max(y2,ceil(max(pointsOut(1,:))));
    xRange=xMax-(xMin+1);
    yRange=yMax-(yMin+1);%for the zero between
    
    
    warpNewImage=zeros(xRange,yRange,3);
    warpNewImage=uint8(warpNewImage);
    mergeImage=zeros(xRange,yRange,3);
    mergeImage=uint8(mergeImage);
    [X,Y]=meshgrid(yMin:yMax,xMin:xMax);
    warpedCord=[X(:),Y(:)]';
    
    origCor=applyHomography(warpedCord,pinv(Matrix));
    
    [~,y3]=size(origCor);
    for i=1:1:x2
        for n=1:y2
           shiftY= n - (yMin+1);
           shiftX= i - (xMin+1);
            if shiftX>=1 && shiftY >= 1 && shiftX < xRange && shiftY < yRange
                    
            	mergeImage(shiftX,shiftY,1:3)=image2(i,n,1:3);
                
            
                
            end
        end
    end
    for i=1:1:y3
        xIn=round(origCor(2,i));
        yIn=round(origCor(1,i));
        if  xIn > 0 && yIn>0 && xIn<x1 && yIn<y1
            
            warpedX=max(1,floor(warpedCord(2,i))-xMin+1);
            warpedY=max(1,floor(warpedCord(1,i))-yMin+1);
            warpNewImage(warpedX,warpedY,1:3)=image1(round(origCor(2,i)),round(origCor(1,i)),1:3);
            mergeImage(warpedX,warpedY,1:3)=image1(round(origCor(2,i)),round(origCor(1,i)),1:3);

        end
    end
    
    

    
    
    
    
 end


