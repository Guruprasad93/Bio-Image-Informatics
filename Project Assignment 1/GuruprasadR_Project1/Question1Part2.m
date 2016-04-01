%project Assignment - 1
%part II

%% Detect SURF Interest Points in a Grayscale Image
I = imread('cameraman.tif');
points = detectSURFFeatures(I);

imshow(I); hold on;
plot(points.selectStrongest(10));

%% Using LBP Features to Differentiate Images by Texture

brickWall = imread('bricks.bmp');
rotatedBrickWall = imread('bricksRotated.bmp');
carpet = imread('carpet.bmp');

figure
imshow(brickWall)
title('Bricks')
figure
imshow(rotatedBrickWall)
title('Rotated Bricks')
figure
imshow(carpet)
title('Carpet')

lbpBricks1 = extractLBPFeatures(brickWall,'Upright',false);
lbpBricks2 = extractLBPFeatures(rotatedBrickWall,'Upright',false);
lbpCarpet = extractLBPFeatures(carpet,'Upright',false);

brickVsBrick = (lbpBricks1 - lbpBricks2).^2;
brickVsCarpet = (lbpBricks1 - lbpCarpet).^2;

figure
bar([brickVsBrick; brickVsCarpet]','grouped')
title('Squared Error of LBP Histograms')
xlabel('LBP Histogram Bins')
legend('Bricks vs Rotated Bricks','Bricks vs Carpet')

%% Extract and Plot HOG Features

%Read the image of interest.
img = imread('cameraman.tif');

%Extract HOG features.
[featureVector, hogVisualization] = extractHOGFeatures(img);

%Plot HOG features over the original image.
figure;
imshow(img); hold on;
plot(hogVisualization);

%% Find Edges in an Image

%Create edge detector, color space converter, and image type converter objects.
hedge = vision.EdgeDetector;
hcsc = vision.ColorSpaceConverter('Conversion', 'RGB to intensity');
hidtypeconv = vision.ImageDataTypeConverter('OutputDataType','single');

%Read in the original image and convert color and data type.
img = step(hcsc, imread('peppers.png'));
img1 = step(hidtypeconv, img);

%Find edges.
edges = step(hedge, img1);

%Display original and image with edges.
subplot(1,2,1);
imshow(imread('peppers.png'));
subplot(1,2,2);
imshow(edges);

%%  Enhance Image Quality using Contrast Adjuster

%Create a contrast adjuster object.
hcontadj = vision.ContrastAdjuster;

%Read an image.
x = imread('pout.tif');

%Apply the contrast adjuster to the image using the object's step method.
y = step(hcontadj,x);

%Display the original and enhanced image.
imshow(x); title('Original Image');
figure,imshow(y);
title('Enhanced image after contrast adjustment');

%% Find Vertical and horizontal Edges in image

%Read the input image and compute the integral image.
I = imread('pout.tif');
intImage = integralImage(I);

%Construct Haar-like wavelet filters. Use the dot notation to find the vertical filter from
%the horizontal filter.
horiH = integralKernel([1 1 4 3; 1 4 4 3],[-1, 1]);
vertH = horiH.'

%Display the horizontal filter.
imtool(horiH.Coefficients, 'InitialMagnification','fit');

%Compute the filter responses.
horiResponse = integralFilter(intImage,horiH);
vertResponse = integralFilter(intImage,vertH);

%Display the results.
figure;
imshow(horiResponse,[]);
title('Horizontal edge responses');
figure;
imshow(vertResponse,[]);
title('Vertical edge responses');