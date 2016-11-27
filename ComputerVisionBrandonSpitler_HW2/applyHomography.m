function [ pointsOut ] = applyHomography( points,homography )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [x1,y1]=size(points);
    unScaledTransform = homography*[points;ones(1,y1)];
    xScaledTrans=unScaledTransform(2,:) ./ unScaledTransform(3,:);
    yScaledTrans=unScaledTransform(1,:) ./ unScaledTransform(3,:);
    pointsOut=[yScaledTrans;xScaledTrans];
end

