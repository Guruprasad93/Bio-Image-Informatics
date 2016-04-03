function [subPixelDetect, realSubPixelMaxima] = subPixelDetection(finalMaxima, I, I_syntheticNoNoise)

%Access final detected particles

if nargin == 3

    for i = 1:size(finalMaxima,1)

       %% Synthetic Noisy Image
        %select pixel-level detection
        I_oversample = I(finalMaxima(i,1)-1:finalMaxima(i,1)+1,finalMaxima(i,2)-1:finalMaxima(i,2)+1);

        %I_localMax = max(I_oversample(:));
        I_localMax = finalMaxima(i,3);

        %Oversample results from pixel-level detection
        I_oversample = imresize(I_oversample,5); 

        %Perform gaussian detection
        subpixel = gaussianDetection(I_oversample, I_localMax);

        %Subpixel detection
        subPixelDetect(i,:) = [(finalMaxima(i,1)-1)*5+subpixel(1), (finalMaxima(i,2)-1)*5+subpixel(2), subpixel(1),subpixel(2)];

        %% Synthetic Image (without noise)

        I_realoverSample = I_syntheticNoNoise(finalMaxima(i,1)-1:finalMaxima(i,1)+1,finalMaxima(i,2)-1:finalMaxima(i,2)+1);
        %Oversample results from pixel-level detection
        I_realoverSample = imresize(I_realoverSample,5); 


        [oversampleMax,index] = max(I_realoverSample(:));
        %I_localMax = oversampleMax
        [rowMax, colMax] = ind2sub(size(I_oversample),index);
        realSubPixelMaxima(i,:) = [rowMax, colMax];


    end
else
    
    for i = 1:size(finalMaxima,1)

       %% Synthetic Noisy Image
        %select pixel-level detection
        I_oversample = I(finalMaxima(i,1)-1:finalMaxima(i,1)+1,finalMaxima(i,2)-1:finalMaxima(i,2)+1);

        %I_localMax = max(I_oversample(:));
        I_localMax = finalMaxima(i,3);

        %Oversample results from pixel-level detection
        I_oversample = imresize(I_oversample,5); 

        %Perform gaussian detection
        subpixel = gaussianDetection(I_oversample, I_localMax);

        %Subpixel detection
        subPixelDetect(i,:) = [(finalMaxima(i,1)-1)*5+subpixel(1), (finalMaxima(i,2)-1)*5+subpixel(2), subpixel(1),subpixel(2)];

        
    end
    
end
    
