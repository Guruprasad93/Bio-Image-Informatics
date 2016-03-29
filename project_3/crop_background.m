function [bkgdMean, bkgdStd, crop_width, crop_height] = crop_background(I, num_iterations)

% %Display figure
% figure, 
% imshow(I,[])

bkgdMean = 0;
bkgdStd = 0;

for iter = 1:num_iterations

    %Display figure
    figure, 
    imshow(I,[])

    
    %Selecting Background area
    h = imrect;
    pos = getPosition(h);
    xmin = floor(pos(1));
    ymin = floor(pos(2));
    width = floor(pos(3));
    height = floor(pos(4));

    %Cropping ROI, visualizing cropped image
    I2 = I(ymin: ymin+height, xmin: xmin+width); %height - rows; width - columns
    figure,
    imshow(I2, [])

    %Determining mean, std deviation of background noise
    bkgdMean = bkgdMean + mean(I2(:));
    bkgdStd = bkgdStd + std(I2(:));
    
    crop_width(iter,:) = [width, xmin];
    crop_height(iter,:) = [height, ymin];
    close all

end

bkgdMean = bkgdMean/num_iterations;
bkgdStd = bkgdStd/num_iterations;



