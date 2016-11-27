% Brandon Spitler
% CSCI 4830 computer vision
% CU boulder
% Fleming
% this function finds a distance given a disparty as well as some campara paremeters
function [ distanceMatrixXYZ ] = findDistanceGivenDisparity( disparity, steroparams )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    baseLine=steroparams.CameraParameters1.PrincipalPoint(1) - steroparams.CameraParameters2.PrincipalPoint(1);
    focalLength=steroparams.CameraParameters1.FocalLength(1);
    distanceMatrix= (14*baseLine*focalLength)./disparity;%fairly sure this was done wrong I know that I have to convert from pixels and 'mm' some how but am unsure how
    [row,col]=size(disparity);
    [x,y] = meshgrid(1:col,1:row);
    x=(baseLine.*x)./disparity;
    y=(baseLine.*y)./disparity;
    x = reshape(x, size(disparity));
    y = reshape(y, size(disparity));
    distanceMatrix = reshape(distanceMatrix, size(disparity));
    distanceMatrixXYZ = cat(3, x, y, distanceMatrix);
end

