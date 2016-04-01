%Question 2 
%% Part 2.1

I = imread('Question2\image01.tiff');

I = im2double(I);
I(:) = (I(:)/max(I(:)))*255;

nbins = 1000;
figure(1)
hist(I(:),nbins)
xlabel('Image Intensity')
ylabel('Frequency')

%% Part 2.2

I = imread('Question2\image01.tiff');
imcrop(I)

