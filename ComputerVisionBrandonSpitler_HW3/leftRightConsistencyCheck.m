function [ outliers ] = leftRightConsistencyCheck( L2R,R2L,threshold )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[r1,c1,~]=size(L2R);
outliers=zeros(r1,c1);
for row=1:1:r1
    for col=1:1:c1
        revPixelRight=round(col-L2R(row,col));%calculate the revese pixel
        
        if(revPixelRight > c1 || revPixelRight<1)%pixel does not exist
            outliers(row,col)=1;
        else
            revPixelLeft=revPixelRight+R2L(row,revPixelRight);
            if (abs(revPixelLeft-col)<threshold)%find amound pixel is off by
                outliers(row,col)=0;
            else
                outliers(row,col)=1;
            end
        end
    end
end



end

