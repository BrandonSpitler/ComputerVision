function [ disparityMatrix ] = NCCSDisparityv3( e1,e2,maxDisp,occ ,windowSize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[r1,c1,~]=size(e1);
%nommalize values aka make all values in between 1 and 2
    e1=padarray(double(e1(:,:))./double(max(max(e1(:,:)))),[windowSize,windowSize]);
    e2=padarray(double(e2(:,:))./double(max(max(e2(:,:)))),[windowSize,windowSize]);
    
    
    dynamicArray=zeros(c1,c1,2);
    
    disparityMatrix=zeros(r1,c1);
    disparityMatrix(:,:)=NaN;
    for row=1:1:r1
        %start dynamic programming scheme
        dynamicArray(1:c1,1:c1,1)=inf;
        
        for j=1:1:c1
          for i=j:1:min(c1,j+maxDisp)
               if(j==1)
                   minScore=(i-1)*occ;
                   dir=4;
               else
                   [minScore,dir]=min([dynamicArray(i-1,j-1,1),dynamicArray(i,j-1,1)+occ,dynamicArray(i-1,j,1)+occ]);
                   
               end
               e1X=e1(row:row+windowSize*2,i:i+windowSize*2);
               e2X=e2(row:row+windowSize*2,j:j+windowSize*2);
               if (i==c1)
                  dynamicArray(i,j,1)=sum(sum((double(e1X)-double(e2X)).^2))+(c1-j)*occ+minScore;
                  dynamicArray(i,j,2)=dir;
               elseif (j==c1)
                  dynamicArray(i,j,1)=sum(sum(double(e1X)-double(e2X).^2))+(c1-i)*occ+minScore;
                  dynamicArray(i,j,2)=dir;
               else
                  dynamicArray(i,j,1)=sum(sum((double(e1X)-double(e2X)).^2))+minScore ;
                  dynamicArray(i,j,2)=dir;
               end
             
          end
          
          
        end
        
        %end dynamic programming
        %[~,indexB]=min(dynamicArray(c1,1:c1,1));
        indexB=c1;
        indexA=c1;
        while(dynamicArray(indexA,indexB,2)~=4)
            if(dynamicArray(indexA,indexB,2)== 1)
                disparityMatrix(row,indexA)=-indexB+indexA;
                indexA=indexA-1;
                indexB=indexB-1;
            elseif(dynamicArray(indexA,indexB,2)==2)
                indexB=indexB-1;
            elseif(dynamicArray(indexA,indexB,2)==3)
                indexA=indexA-1;
            end
            if indexA<=0 || indexB<=0
               disp('error'); 
            end

        end
        
    end
    
    

end
