function [subPixelDetect, realSubPixelMaxima] = subPixelDetection(finalMaxima, I)

%Access final detected particles

for i = 1:size(finalMaxima,1)

    %select pixel-level detection
    I_oversample = I(finalMaxima(i,1)-1:finalMaxima(i,1)+1,finalMaxima(i,2)-1:finalMaxima(i,2)+1);
   
    I_localMax = max(I_oversample(:));
    
    %Oversample results from pixel-level detection
    I_oversample = imresize(I_oversample,5); 
    
    [oversampleMax,index] = max(I_oversample(:));
    %I_localMax = oversampleMax
    [rowMax, colMax] = ind2sub(size(I_oversample),index);
    realSubPixelMaxima(i,:) = [rowMax, colMax];
     
    %Perform gaussian detection
    subpixel = gaussianDetection(I_oversample, I_localMax);
    
    %Subpixel detection
    subPixelDetect(i,:) = [(finalMaxima(i,1)-1)*5+subpixel(1), (finalMaxima(i,2)-1)*5+subpixel(2), subpixel(1),subpixel(2)];
    
end
