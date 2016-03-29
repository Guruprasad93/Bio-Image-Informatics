

%Processing the first Image

%filename
filename = sprintf('project3_images\\images\\001_a5_002_t%0.3d.tif',1);

%Number of iterations
num_iterations = 5;

%Storing image in matrix
I = imread(filename);
I = double(I);

%% Calibration of Dark Noise (B.2.1)
[bkgdMean, bkgdStd, crop_width, crop_height] = crop_background(I, num_iterations);

%% Detection of Local maxima and Local minima (B.2.2)

% Gaussian filtering
[I_gaussFilter] = Gaussian_filter(I);

% Finding local maxima and local minima 
maskSize = 3;
[localMax_3, localMin_3] = findLocalMaxMin (I_gaussFilter, maskSize);

%% Establishing the local association of maxima and minima
  
%Determine delaunay triangulation of local minima & nearest local minima
[associationMat, Tri_indices] = localAssociation(localMax_3, localMin_3, I);

%% Statistical selection of local maxima

Quantile = 6.2;
[finalMaxima] = statisticalTest(Quantile, associationMat, localMin_3, Tri_indices, bkgdStd, I);

I_detection = zeros(size(I));
indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));

I_detection(indices) = 100;

%figure,
%mshow(I_detection,[])
file_save = sprintf('detectionImages\\img%0.3d.png',1);
save(file_save, 'I_detection');
%imwrite(I_detection, file_save);

%% All other Images

for image_num = 2:218
    
    %filename
    filename = sprintf('project3_images\\images\\001_a5_002_t%0.3d.tif',image_num);

    %Storing image in matrix
    I = imread(filename);
    I = double(I);
    
    %% Calibration of Dark Noise (B.2.1)

    for iter = 1:num_iterations

        %Cropping ROI, visualizing cropped image
        I2 = I(crop_height(iter,2): crop_height(iter,2)+crop_height(iter,1), crop_width(iter,2): crop_width(iter,2) + crop_width(iter)); %height - rows; width - columns
        bkgdMean = bkgdMean + mean(I2(:));
        bkgdStd = bkgdStd + std(I2(:));

    end
    
    bkgdMean = bkgdMean/num_iterations;
    bkgdStd = bkgdStd/num_iterations;
    
    %% Detection of Local maxima and Local minima (B.2.2)

    % Gaussian filtering
    [I_gaussFilter] = Gaussian_filter(I);

    % Finding local maxima and local minima 
    maskSize = 3;
    [localMax_3, localMin_3] = findLocalMaxMin (I_gaussFilter, maskSize);

    %% Establishing the local association of maxima and minima

    %Determine delaunay triangulation of local minima & nearest local minima
    [associationMat, Tri_indices] = localAssociation(localMax_3, localMin_3, I);

    %% Statistical selection of local maxima

    Quantile = 6.2;
    [finalMaxima] = statisticalTest(Quantile, associationMat, localMin_3, Tri_indices, bkgdStd, I);

    I_detection = zeros(size(I));
    indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));
    I_detection(indices) = 100;

    %figure,
    %imshow(I_detection,[])
    file_save = sprintf('detectionImages\\img%0.3d.mat',image_num);
    save(file_save, 'I_detection');
    %imwrite(I_detection, file_save);
    
    close all
end
    
    


