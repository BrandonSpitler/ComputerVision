function [guassianweightedmatrix] = gaussianMatrix(xsize,ysize,nsd)
    weightedMatrix = zeros(xsize,ysize);
    sizeDivByTwo=floor(xsize/2);
    weightedSum=0;
    for x=1:1:xsize
        for y=1:1:ysize
        	weightedMatrix(x,y)=(1/(2*pi*(nsd^2)))*exp(-1*((x-sizeDivByTwo-1)^2+(y-sizeDivByTwo-1)^2)/(2*nsd^2));
            weightedSum=weightedSum+weightedMatrix(x,y);
        end
    end
    %disp(weightedMatrix);
    for x=1:1:xsize
        for y=1:1:ysize
        	weightedMatrix(x,y)=weightedMatrix(x,y)/weightedSum;
        end
    end
    guassianweightedmatrix=weightedMatrix;
end