% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% your information
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('../ComputerVision/meanFilter.m')
clear all;close all;clc;
filename='lena1.jpg';
current_img = imread('lena1.jpg');
% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image','Display Image', 'Mean Filter','Gaussian Filter','Scale Nearest-Neightbor','Bilinear Image Scale','fun Filter','grey scale','Simple edge Dectect');  % as you develop functions, add buttons for them here  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program', 'Load Image', 'Display Image', 'Mean Filter','Gaussian Filter','Scale Nearest-Neightbor','Bilinear Image Scale','fun Filter','grey scale','Simple edge Dectect');  % as you develop functions, add buttons for them here
  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek','Noise');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename='mandrill1.jpg';
               case 3
                   filename='sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               case 5
                   filename='lenaWithNoise.jpg';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           
           % 1. Ask the user for size of kernel
           
           % 2. Call the appropriate function
           prompt=('kerenel size');
           dlg_title='input screen';
           num_lines=1;
           answers=inputdlg(prompt,dlg_title,num_lines);
           a=str2double(answers(1));
           newImage = meanFilter(current_img, a); % create your own function for the mean filter
          % imagesc(newImage);
           imwrite(newImage,strcat('meanFilter_',filename));
           
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('meanFilter_',filename));
            subplot(1,2,1), imshow(X1,map1);
            subplot(1,2,2), imshow(X2,map2);

           % 3. Display the old and the new image using subplot
           % ....
           %subplot(...)
           %imagesc(current_img)
           
           % subplot(...)
           %imagesc(newImage)
           
           
           % 4. Save the newImage to a file
           
              
       case 5
           prompt={'standard deviation','kerenel size'};
           dlg_title='input screen';
           num_lines=1;
           answers=inputdlg(prompt,dlg_title,num_lines);
           a=str2double(answers(1));
           b=str2double(answers(2));
           newImage = gaussian( current_img,a,b );
           imwrite(newImage,strcat('gaussian_',filename));
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('gaussian_',filename));
            subplot(1,2,1), imshow(X1,map1);
            subplot(1,2,2), imshow(X2,map2);

           imagesc(newImage);
           %....
       case 6
           prompt={'by factor'};
           dlg_title='input screen';
           num_lines=1;
           %30000 angle mod
           %30000000 distance mod
           answers=inputdlg(prompt,dlg_title,num_lines);
           a=str2double(answers(1));
           newImage=ScaleNearestNeightbor(current_img,a);
           imwrite(newImage,strcat('scaleNearest_',filename));
           
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('scaleNearest_',filename));
            subplot(1,2,1), imshow(X1,map1);
            subplot(1,2,2), imshow(X2,map2);
           %imagesc(newImage);
       case 7
           prompt={'by factor'};
           dlg_title='input screen';
           num_lines=1;
           %30000 angle mod
           %30000000 distance mod
           answers=inputdlg(prompt,dlg_title,num_lines);
           a=str2double(answers(1));
           newImage=BilinearImageScaling(current_img,a);
           imwrite(newImage,strcat('BilinearScaled_',filename));
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('BilinearScaled_',filename));
            subplot(1,2,1), imshow(X1,map1);
            subplot(1,2,2), imshow(X2,map2);
           %imagesc(newImage);
       case 8
           prompt={'what is the angle Mutiplier','What is the distance mutiplier'};
           dlg_title='input screen';
           num_lines=1;
           %30000 angle mod
           %30000000 distance mod
           defualts={'300000000','30000000000'};
           answers=inputdlg(prompt,dlg_title,num_lines,defualts);
           a=str2double(answers(1));
           b=str2double(answers(2));
           newImage=funFilter(current_img,a,b);
           imwrite(newImage,strcat('funFilter_',filename));
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('funFilter_',filename));
            subplot(1,2,1), imshow(X1,map1)
            subplot(1,2,2), imshow(X2,map2)
           %imagesc(newImage);
       case 9
           newImage=greyScale(current_img);
           imwrite(newImage,strcat('greyscaleimage_',filename));
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('greyscaleimage_',filename));
            subplot(1,2,1), imshow(X1,map1)
            subplot(1,2,2), imshow(X2,map2)
           %imagesc(newImage);
           
       case 10
           prompt={'edge detect in the x or y direction (1 for x direction 0 for y direction)','with what threshold'};
           dlg_title='input screen';
           num_lines=1;
           answers=inputdlg(prompt,dlg_title,num_lines);
           a=str2double(answers(1));
           b=str2double(answers(2));
           newImage=edgeDect( current_img,b,a );
           imwrite(newImage,strcat('edgeDect_',filename));
            [X1,map1]=imread(filename);
            [X2,map2]=imread(strcat('edgeDect_',filename));
            subplot(1,2,1), imshow(X1,map1)
            subplot(1,2,2), imshow(X2,map2)
          %imagesc(newImage);
       %....
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter','Gaussian Filter','Scale Nearest-Neightbor','Bilinear Image Scale','fun Filter','grey scale','Simple edge Dectect');  % as you develop functions, add buttons for them here
end
