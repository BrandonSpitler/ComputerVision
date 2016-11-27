

chars=char(97:122);

for ns=1:length(chars)%imwrite(tempImage, 'z-l.jpg')
    
    imageName=[chars(ns),'-l.jpg'];
    
    letterImage=imread(imageName);
    letterImage=imresize(letterImage,[70,20],'bicubic');
     %letterImage = rgb2gray(letterImage);
 letterImage(letterImage < 128) = 0;
 letterImage(letterImage >= 128) = 1; % Pay attention to the order
 letterImage = logical(letterImage);
%     imwrite(letterImage, [chars(ns),'-l.jpg'])
    letterStruct=struct('letter',chars(ns),'array',letterImage);
    letterArray(ns)=letterStruct;
end

[output,minVector]=RecognizeCharacters;
image = imread('sentence.jpg');
originalImage = image;
%image =  double(image);
image = rgb2gray(image);
image(image < 128) = 1;
image(image >= 128) = 0; % Pay attention to the order
image = logical(image); 
[row,col] = size(minVector);
LetterCoords = [];ans
imshow(originalImage);
dots = [];

% all non two part character label
for d=1:1:row
        imshow(image(minVector(d,1):minVector(d,3),minVector(d,2):minVector(d,4),:));
        tempLetter=imresize(image(minVector(d,1):minVector(d,3),minVector(d,2):minVector(d,4),:),[70,20],'bicubic');
        minSum=inf;
        minIndex=0;
        for ns=1:length(chars)
            curSum=sum(sum((letterArray(ns).array-tempLetter).^2));
            if(curSum<minSum)
                minIndex=ns;
                minSum=curSum;
            end
        end
        
        disp(letterArray(minIndex).letter);
        i=0;
        
end