function [ outputDis ] = toDisShowingNaN( inputDis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %normalize between ranges 0 and 1 subtract min from array divide by max
    [r1,c1]=size(inputDis);
    inputDis=(inputDis(:,:)-min(min(inputDis(:,:))))./(max(max(inputDis(:,:))));
    redLayer=inputDis;
    redLayer(redLayer~=redLayer)=1;
    NonRedLayer=inputDis;
    NonRedLayer(NonRedLayer~=NonRedLayer)=0;
   
    outputDis=zeros(r1,c1,3);
    outputDis(:,:,1)=redLayer;
    outputDis(:,:,2)=NonRedLayer;
    outputDis(:,:,3)=NonRedLayer;

end

