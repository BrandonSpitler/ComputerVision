Takes points from the pictures using the centers of the picture as 0,0 the uses trigs functions to transform
the image over the image. A function which as the points get futher away from 0,0

function [ newImage ] = funFilter( cur_Image,a,b )
    [x1,y1,z1]=size(cur_Image);
    %newFile=zeros(x1,y1,z1);
    newFile=uint8(cur_Image);
    
    xHalfWayPoint = floor(x1*1/2);
    yHalfWayPoint=floor(y1*1/2);
    
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    for i=2:1:(x1-1)
        for n=2:1:(y1-1)
            for ni =1:1:z1
                %angle=exp(-((i-xHalfWayPoint)^2+(n-yHalfWayPoint)^2)/30); %todo you can make this more or less then squared to give it a greater or less angle
                distanceFromTheOrgin=sqrt((n-xHalfWayPoint)^2+(i-yHalfWayPoint)^2);
                curAngle=acosd((i-xHalfWayPoint)/distanceFromTheOrgin);
                curAngleS=asind((n-yHalfWayPoint)/distanceFromTheOrgin);
               % if(i>abs(500) || n >abs(500))
                %   modAng=0;
                    
                %else
                modAng=a*exp(-((i-xHalfWayPoint)^2+(n-yHalfWayPoint)^2)/b); %todo you can make this more or less then squared to give it a greater or less angle
               % end
                u=abs(floor(cosd(curAngle+modAng)*distanceFromTheOrgin+xHalfWayPoint));
                v=abs(floor(sind(curAngleS+modAng)*distanceFromTheOrgin+yHalfWayPoint));
                
                %angle=arctan((i-xHalfWayPoint)/(n-yHalfWayPoint));
                
                u=floor(u);
                v=floor(v);
                if (u<x1 && v<y1 && u>0 && v>0)
                    %disp(u)
                    newFile(u,v,ni)=cur_Image(i,n,ni);
                end
            end
        end
    end
newImage=newFile;
end

