function [subPixelDetect, realSubPixelMaxima] = subPixelDetection(finalMaxima, I, I_syntheticNoNoise)
%% Input
%% finalMaxima : Load FinalMaxima. mat. It contains the x,y co-ordinate of detected particles and
% the corresponding intensity value
% I :  Original Image
% I_syntheticNoNoise :  This is an optional parameter used in the extra
% credit section of Main.m. This is an image which contains only the
% detected particle intensities with no added noise(raw image).

%% Output
% subPixelDetect : Detected sub-pixel co-ordinates that is returned by
% using gaussian fitting.
% realSubPixelMaxima : The actual sub-pixel co-ordinates obtained from the
% raw image.

%% Access final detected particles

if nargin == 3

% Iterate over all the detected particles intensities
    for i = 1:size(finalMaxima,1)

       %% Synthetic Noisy Image
        % select pixel-level detection
        
        % Oversample the detected particle(pixel) and its neighborhood
        I_oversample = I(finalMaxima(i,1)-1:finalMaxima(i,1)+1,finalMaxima(i,2)-1:finalMaxima(i,2)+1);

        % Set the local maximum to be the intensity of the particle
        % detected
        I_localMax = finalMaxima(i,3);

        %Oversample results from pixel-level detection by a factor of 5
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
    
