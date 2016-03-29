%Averaging background noise, std dev from multiple backgrounds

%filename
filename = 'project3_images\images\001_a5_002_t001.tif';

% %Storing image in matrix
% I = imread(filename);
% I = double(I);

%Number of iterations
num_iterations = 5;

% bkgdMean = 0;
% bkgdStd = 0;

[bkgdMean, bkgdStd, crop_width, crop_height] = crop_background(I, num_iterations);

% for iter = 1:num_iterations
%     [bkgdNoise_mean, bkgdNoise_stdDev] = crop_background(filename, num_iterations);
%     bkgdMean = bkgdMean + bkgdNoise_mean;
%     bkgdStd = bkgdStd + bkgdNoise_stdDev;
%     close all
% end


%% Filtering with gaussian Kernel

[I_gaussFilter] = Gaussian_filter(I);

%% Finding local maxima and local minima 
maskSize = 5;
[localMax_3, localMin_3] = findLocalMaxMin (I_gaussFilter, maskSize);

%% Establishing the local association of maxima and minima
  
%Determine delaunay triangulation of local minima & nearest local minima
[associationMat, Tri_indices] = localAssociation(localMax_3, localMin_3, I);

%% Statistical selection of local maxima

Quantile = 6.5;
[finalMaxima] = statisticalTest(Quantile, associationMat, localMin_3, Tri_indices, bkgdStd, I);

I_detection = zeros(size(I));
indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));

I_detection(indices) = 100;

figure,
imshow(I_detection,[])



%% Plot localMaxima 
%plotLocalMax_Min(localMax_3, localMin_3,I)

%maskSize = 5;
%[localMax_5, localMin_5] = findLocalMaxMin (I_gaussFilter, maskSize);
% Plot localMaxima 
%plotLocalMax_Min(localMax_5, localMin_5,I)



