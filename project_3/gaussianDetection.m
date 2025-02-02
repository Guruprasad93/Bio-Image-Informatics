function [subpixel] = gaussianDetection(I_oversample, I_max)

%% Parameters of gaussianDetection
% I_oversample: After performing pixel level detection, the identified pixel
% and its 3x3 neighbouring pixels are oversampled by a factor of 5
% I_max : The maximum intensity of the detected particles

 %% Parameters of the Gaussian Kernel
    A = I_max;
    sigVal = (0.61*515/(1.4*3))/13;

    % Define size of Gaussian mask
    N = (2*ceil(3*sigVal))+1;

    % Create a Gaussian mask
    ind = -floor(N/2) : floor(N/2);
    [X,Y] = meshgrid(ind, ind);
    h = A*(exp(-(X.^2 + Y.^2) / (2*sigVal*sigVal)));
    %h = h ./ sum(h(:));
    
    % Pad the image with zeros
    imPad = padarray(I_oversample,[floor(N/2) floor(N/2)]);   

    % Look for the co-ordinates in the oversampled image where the least
    % square error fit with the gaussian is minimum. The pixel co-ordinates
    % with least square error are recorded as the subpixel co-ordinates.
   
    min_intensity = Inf;
    
    for ii = floor(N/2)+1: size(imPad,1)-floor(N/2)
        for jj = floor(N/2)+1:size(imPad,2)-floor(N/2)
            imVal=imPad(ii-floor(N/2):ii+floor(N/2),jj-floor(N/2):jj+floor(N/2));
            leastSquare = sum(sum((imVal - h).^2));
            
            if (leastSquare<min_intensity)
                min_intensity = leastSquare;
                subpixel = [ii-floor(N/2),jj-floor(N/2)];
            end
            
            %filtIm = imVal.* h;
            %imGauss(ii,jj)=sum(filtIm(:));
        end
    end
    
end