
%             [X2,map2]=imread(strcat('meanFilter_',filename));
%             subplot(1,2,1), imshow(X1,map1);
%             subplot(1,2,2), imshow(X2,map2);
warning('off', 'Images:initSize:adjustingMag');
 image1 = imread('lena1.jpg');
 image2 = imread('binder.JPG');
%  subplot(1,2,1), imshow(image1);
%  subplot(1,2,2), imshow(image2);
numberOfPoints=4;

% image1 = imread('uttower1.JPG');
% image2 = imread('uttower2.JPG');
%  subplot(1,2,1), imshow(image1);
%  subplot(1,2,2), imshow(image2);

%click points
imshow(image1)
[image1Points]=ginput(numberOfPoints);

%disp(image1Points)

imshow(image2);
[image2Points]=ginput(numberOfPoints);
%disp(image2Points)
%homograph=zeros(3,3);

homograph=zeros(numberOfPoints*2,8);
for n=1:1:numberOfPoints
    %disp(n)
    homograph(n*2-1,1)=image1Points(n,1);
    homograph(n*2-1,2)=image1Points(n,2);
    homograph(n*2-1,3)=1;
    %homograph(n,4)=1;
    %homograph(n,5)=1;
    %homograph(n,6)=1;
    homograph(n*2-1,7)=-image1Points(n,1)*image2Points(n,1);
    homograph(n*2-1,8)=-image1Points(n,2)*image2Points(n,1);
    %homograph(n,9)=image2Points(n,1);
    
    
   % homograph(n+1,1)=-image1Points(n,1);
   % homograph(n+1,2)=-image1Points(n,2);
   % homograph(n+1,3)=-1;
    homograph(n*2,4)=image1Points(n,1);
    homograph(n*2,5)=image1Points(n,2);
    homograph(n*2,6)=1;
    homograph(n*2,7)=-image1Points(n,1)*image2Points(n,2);
    homograph(n*2,8)=-image1Points(n,2)*image2Points(n,2);
    %homograph(n+1,9)=image2Points(n,2);

end


% %disp(homograph);
M2=zeros(numberOfPoints*2,1);
for n=1:1:numberOfPoints
    M2(n*2-1,1)=image2Points(n,1);
    M2(n*2,1)=image2Points(n,2);

end
%f=M2 \ homograph;
%disp(X);
%  disp(M2);
   f=(transpose(homograph)*homograph) \ (transpose(homograph)*M2);
%  disp(f);
   l=zeros(3,3);
   l(1,1:3)=f(1:3);
   l(2,1:3)=f(4:6);
   l(3,1:2)=f(7:8);
   l(3,3)=1;
%  disp(l)
%  temp=zeros(3,1);
  temp(1)=image1Points(1,1);
  temp(2)=image1Points(1,2);
  temp(3)=1;
  [newImage,newImage2]=invWarp(image1,image2,l);
  [x3,y3,z3]=size(newImage);
%   imshow(newImage);
% %  disp(image2Points(1,1:2))
% %  disp('other matrix is')
%  [image3Points]=ginput(numberOfPoints);
   imshow(newImage2);


 