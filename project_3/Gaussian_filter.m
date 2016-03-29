
function [imGauss] = Gaussian_filter(im)
%% The Inputs to the function are as follows
% pathToImage : Takes as input a string which specifies the path to the
% image
% Example : pathToImage = 'image01.tiff'
% sigma : Is a vector variable that takes as input the values of sigma
% For Example sigma = [1,2,5,7]

% The output of the function consists of a series of images for different
% sigma values


%% Read in the image

%im = double(imread(pathToImage));
%figure,
%imshow(im,[]);
%imshow(im, []);
%title('Original Image')

%% 
%Rayleigh's radius
lambda = 515*1e-9;
NA = 1.4;
radius = 0.61*lambda/NA;

%Gaussian kernel sigma
sigVal = radius/3;

%% Apply the Gaussian filter for all sigma

% Define size of Gaussian mask
    N = (2*(3*sigVal))+1;

    %Display the size of the gaussian mask
    display(strcat('Size of the gaussian kernel for sigma = ',num2str(sigVal),' ',' is ', num2str(N))); 

    % Reference :  http://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
    % Create a Gaussian mask
    ind = -floor(N/2) : floor(N/2);
    [X,Y] = meshgrid(ind, ind);
    h = (exp(-(X.^2 + Y.^2) / (2*sigVal*sigVal)));
    h = h ./ sum(h(:));

    % As a check i implemented the convolution using conv2 and for loops and both implementations return the same
    % value with significant precision
    % Note : using conv2 is much faster !! 
    % blur =conv2(im, h,'same');

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

    %figure,
    %imshow(imGauss(floor(N/2)+1: size(imPad,1)-floor(N/2),floor(N/2)+1:size(imPad,2)-floor(N/2)),[]);
    %title(strcat('Blurred Image for sigma = ',' ',num2str(sigVal)));

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