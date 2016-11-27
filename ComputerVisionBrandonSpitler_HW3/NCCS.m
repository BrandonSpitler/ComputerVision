% Brandon Spitler
% CSCI 4830 computer vision
% CU boulder
% Fleming
%find disparity based on the square with the highest correlation to the
%window 0 stand devaiton replace with a value of .001

function [ returnMatrix ] = NCCS( imgLeft,imgRight,windowSize,disparityRange )
 
    [r1,c1,~]=size(imgLeft);
    pad=windowSize+disparityRange/2;
    imgLeft     = padarray(imgLeft,[pad,pad]);
    imgRight    = padarray(imgRight,[pad,pad]);
    
    returnMatrix = zeros(r1,c1);
    dynArrayMeanStd=zeros(c1,2);
    for row=1+pad:1:r1-1-pad;
        for col=1+pad:1:c1-1-pad;
            template=double(imgRight(row-windowSize:row+windowSize,col-windowSize:col+windowSize));
            meanTemplate=mean(mean(imgRight));
            sigmaTemplate=std(template(:));
            dynArrayMeanStd(col,1)=meanTemplate;
            dynArrayMeanStd(col,2)=sigmaTemplate;
        end
        for col=1+pad:1:c1-1-pad;
            %fprintf('%i, %i\n',col,row);
            window=double(imgLeft(row-windowSize:row+windowSize,col-windowSize:col+windowSize));
            max = 0;
            meanWindow=mean(mean(window));
            sigmaWindow=std(window(:));
            for disp = col-disparityRange/2:1:col+disparityRange/2% find most correlated template
              template = double(imgRight(row-windowSize:row+windowSize,disp-windowSize:disp+windowSize));
              %meanTemplate=mean(mean(imgRight));
              meanTemplate=dynArrayMeanStd(disp,1);
              sigmaTemplate=dynArrayMeanStd(disp,2);
              %sigmaTemplate=std(template(:));
         
              if(sigmaTemplate ==0)
                  sigmaTemplate=.001;
                  
              end
              if sigmaWindow== 0
                  sigmaWindow=.001;
              end
              matrixCorreleation=((window-meanWindow).*(template-meanTemplate))./(sigmaTemplate*sigmaWindow);
              matrixCorreleation=sum(sum(matrixCorreleation));%dividing by window size is not nessasary

              if(max<abs(matrixCorreleation))
                 max= abs(matrixCorreleation);
                 maxIndex=disp;
              end
              
            end
            returnMatrix(row,col)=col-maxIndex;
        end
    end
    
    %set up new images with padding that are equal to the old image except
    %with padding equal to the window size in all directions
    
    
end

