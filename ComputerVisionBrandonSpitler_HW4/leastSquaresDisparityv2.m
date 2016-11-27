function [ disparityMatrix ] = leastSquaresDisparityv2( e1,e2,maxDisp,occ ,windowSize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    occ=-occ;
    [r1,c1,~]=size(e1);
%nommalize values aka make all values in between 1 and 2
    e1=padarray(double(e1(:,:))./double(max(max(e1(:,:)))),[windowSize,windowSize]);
    e2=padarray(double(e2(:,:))./double(max(max(e2(:,:)))),[windowSize,windowSize]);
    
    
    dynamicArray=zeros((ceil((c1-windowSize)/(2*windowSize+1))),ceil((c1-windowSize)/(2*windowSize+1)),3);
    [dr1,dc1,~]=size(dynamicArray);
    disparityMatrix=zeros(514,719);
    disparityMatrix(:,:)=NaN;
    for row=1+windowSize:windowSize*2+1:r1
        %start dynamic programming scheme
        dynamicArray(1:ceil((c1-windowSize)/(2*windowSize+1)),1:ceil((c1-windowSize)/(2*windowSize+1)),1)=-inf;
        dynamicArray(1:ceil((c1-windowSize)/(2*windowSize+1)),1:ceil((c1-windowSize)/(2*windowSize+1)),2)=4;
        %count=0;
        for j=1+windowSize:windowSize*2+1:c1
            %count=count+1;
          for i=j:windowSize*2+1:min(c1,j+maxDisp)
               if(j==1+windowSize)
                   minScore=(i-1)*occ;
                   dir=4;
               else
                   [minScore,dir]=max([dynamicArray(ceil((i-1-windowSize)/(2*windowSize+1)),ceil((j-1-windowSize)/(2*windowSize+1)),1),...
                       dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-1-windowSize)/(2*windowSize+1)),1)+occ,...
                       dynamicArray(ceil((i-1-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),1)+occ]);
                   
               end
               e1X=e1(row-windowSize:row+windowSize,i-windowSize:i+windowSize);
               e2X=e2(row-windowSize:row+windowSize,j-windowSize:j+windowSize);
               nccsVar=corr(e1X(:),e2X(:))^2;

               if (i==c1)
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),1)=nccsVar+(c1-j)*occ+minScore;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),2)=dir;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),3)=i;
               elseif (j==c1)
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),1)=nccsVar+(c1-i)*occ+minScore;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),2)=dir;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),3)=i;
               else
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),1)=nccsVar+minScore;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),2)=dir;
                  dynamicArray(ceil((i-windowSize)/(2*windowSize+1)),ceil((j-windowSize)/(2*windowSize+1)),3)=i;
               end
             
          end
          
          
        end
        
        %end dynamic programming
        %[~,indexB]=min(dynamicArray(c1,1:c1,1));
        indexB=dr1;
        indexA=dc1;
        while(dynamicArray(indexA,indexB,2)~=4)
            if(dynamicArray(indexA,indexB,2)== 1)
                disparityMatrix(row-windowSize:min(row+windowSize,514),...
                    dynamicArray(indexA,indexB,3)-2*windowSize:dynamicArray(indexA,indexB,3))...
                    =-indexB+indexA;
                [~,sizeY]=size(disparityMatrix);
                if sizeY>719
                    disp('error')
                end
                indexA=indexA-1;
                indexB=indexB-1;
            elseif(dynamicArray(indexA,indexB,2)==2)
                indexB=indexB-1;
            elseif(dynamicArray(indexA,indexB,2)==3)
                indexA=indexA-1;
            end
            if indexA<=0 || indexB<=0
               disp('error line 60'); 
            end

        end
        %disp(count)
    end
    
    

end


