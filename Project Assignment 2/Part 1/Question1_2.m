% Please enter the value of sigma
sigma = 2;
sigVal = sigma;
pathToImage = 'image01.tiff';

%% Read in the image

im = double(imread(pathToImage));
figure,
imshow(im,[]);
title('Original Image')


N = (2*(3*sigVal))+1;

%Display the size of the gaussian mask
display(strcat('Size of the gaussian kernel for sigma = ',num2str(sigVal),' ','is',' ',num2str(N))); 

% Reference :  http://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
% Create a Gaussian mask
ind = -floor(N/2) : floor(N/2);
[X,Y] = meshgrid(ind, ind);
h = exp(-(X.^2 + Y.^2) / (2*sigVal*sigVal));
h = h ./ sum(h(:));

blurred_image =conv2(im, h,'same');

y_der = zeros(size(blurred_image,1),size(blurred_image,2));
for i = 2:size(blurred_image,1)-1
    for j = 2:size(blurred_image,2)-1
      y_der(i,j) = (blurred_image(i,j+1)-blurred_image(i,j-1))/2;
    
    end
end

x_der = zeros(size(blurred_image,1),size(blurred_image,2));
for i = 2:size(blurred_image,1)-1
    for j = 2:size(blurred_image,2)-1
      x_der(i,j) = (blurred_image(i+1,j)-blurred_image(i-1,j))/2;
    
    end
end

gmag = hypot(x_der,y_der);

figure,imshow(x_der,[]);
figure,imshow(y_der,[]);
figure,imshow(gmag,[]);