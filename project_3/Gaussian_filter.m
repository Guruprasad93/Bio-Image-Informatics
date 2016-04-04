
function [imGauss] = Gaussian_filter(im,pixelSize)
%% The Inputs to the function are as follows
% im : The image that has to be filtered
% pixelSize : the size of the pixel in nm's : 65nm or 13nm


%% 
%Rayleigh's radius
lambda = 515e-9;
NA = 1.4;
radius = 0.61*lambda/NA;

%Gaussian kernel sigma
sigVal = (radius/3)/(pixelSize);

%% Filter the image

% Define size of Gaussian mask
    N = (2*ceil(3*sigVal))+1;

    %Display the size of the gaussian mask
    display(sprintf('Size of the gaussian kernel for sigma = %d is %d',sigVal,N));
    

    % Reference :  http://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
    % Create a Gaussian mask
    ind = -floor(N/2) : floor(N/2);
    [X,Y] = meshgrid(ind, ind);
    h = (exp(-(X.^2 + Y.^2) / (2*sigVal*sigVal)));
    h = h ./ sum(h(:));

   

    % Pad the image with zeros
    imPad = padarray(im,[floor(N/2) floor(N/2)]);

    imGauss = zeros(size(imPad,1),size(imPad,2));
    for ii = floor(N/2)+1: size(imPad,1)-floor(N/2)
        for jj = floor(N/2)+1:size(imPad,2)-floor(N/2)
           imVal=imPad(ii-floor(N/2):ii+floor(N/2),jj-floor(N/2):jj+floor(N/2));
             filtIm = imVal.* h;
             imGauss(ii,jj)=sum(filtIm(:));
        end
    end    

  
    imGauss = imGauss(floor(N/2)+1: size(imPad,1)-floor(N/2),floor(N/2)+1:size(imPad,2)-floor(N/2));
    
  


%%
% %// Convert filter into a column vector
% h = h(:);
% 
% % Blur the image using a gaussian kernel
% 
% I = im2double(im);
% % pad the image with zeros around the boundary
% I_pad = padarray(I, [floor(N/2) floor(N/2)]);
% C = im2col(I_pad, [N N], 'sliding');
% C_filter = sum(bsxfun(@times, C, h), 1);
% blurred_image = col2im(C_filter, [N N], size(I_pad), 'sliding');
end