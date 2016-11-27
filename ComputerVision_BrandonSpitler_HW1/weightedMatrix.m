function [ returnMatrix ] = weightedMatrix( xSize,ySize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    weightInEachCell=1/(xSize*ySize);
    returnMatrix=zeros(xSize,ySize);
    
    for i=1:1:xSize
        for n=1:1:ySize
    
            returnMatrix(i,n)=weightInEachCell;
        end
    end

end

