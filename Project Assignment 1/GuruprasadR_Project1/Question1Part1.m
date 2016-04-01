%Project Assignment - 1
%Part I
%% Example 1

clear
close all

%Read Image to a variable 'I'
I = imread('pout.tif');
%Display Image
imshow(I)

%Describe all the variables in the workspace
whos

%Plot Histogram of Image 'I'
figure
imhist(I)

%Increasing contrast of Image 'I'
I2 = histeq(I);
figure

%Viewing Image with better contrast ('I2')
imshow(I2)

%plot Histogram of Image ('I2')
figure
imhist(I2)

%Write image to file
imwrite(I2, 'pout.png')
imfinfo('pout.png')

%% Example 2

clear 
close all

I = imread('rice.png');
imshow(I)
saveas(gcf, 'originalrice.png')

background = imopen(I,strel('disk',25));
% figure
% imshow(background)

figure
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');
saveas(gcf, 'bkgd surf.png')

I2 = I - background;
imshow(I2)
saveas(gcf, 'removeBkgd.png')

I3 = imadjust(I2);
imshow(I3)

level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);
imshow(bw)

cc = bwconncomp(bw, 4)
cc.NumObjects


grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
imshow(grain);

labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label)

graindata = regionprops(cc, 'basic')
graindata(50).Area

grain_areas = [graindata.Area];

[min_area, idx] = min(grain_areas)
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);

nbins = 20;
figure, hist(grain_areas, nbins)
title('Histogram of Rice Grain Area');
saveas(gcf, 'Rice grain Area Hist.png')

