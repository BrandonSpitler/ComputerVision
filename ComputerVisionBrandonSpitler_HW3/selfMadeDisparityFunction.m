% Brandon Spitler
% CSCI 4830 computer vision
% CU boulder
% Fleming
%finds the disparity of two images based on the least squares difference
%windowSize is the size of the frome that will be taken from both images
%disparity is the amount that the window will vary from left to right
%a gaussian filter is used on each window
function [ rowDifArray ] = selfMadeDisparityFunction( imgLeft,imgRight,windowSize,disparityRange )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    %grey scale both images
    if(windowSize<3)
        kernel=windowSize;
    else
        kernel=3;
    end
    [r1,c1,~]=size(imgLeft);
    pad=windowSize+disparityRange/2;
    imgLeft     = padarray(imgLeft,[pad,pad]);
    imgRight    = padarray(imgRight,[pad,pad]);
    
    rowDifArray = zeros(r1,c1);
    
    for row=1+pad:1:r1-1-pad;
        for col=1+pad:1:c1-1-pad;
            %fprintf('%i, %i\n',col,row);
            window=imgLeft(row-windowSize:row+windowSize,col-windowSize:col+windowSize);
            gaussian(window,1,kernel);
            min = inf;
            for disp = col-disparityRange/2:1:col+disparityRange/2
              imgRightB = imgRight(row-windowSize:row+windowSize,disp-windowSize:disp+windowSize);
              diff=sum(sum((window-imgRightB).^2));
              if(min>diff)
                 min= diff;
                 minIndex=disp;
              end
              
            end
            rowDifArray(row,col)=col-minIndex;
        end
    end
    
    %set up new images with padding that are equal to the old image except
    %with padding equal to the window size in all directions
    
    
    
end

