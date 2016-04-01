%Question 3
%% Part 3.1

fname = 'Question3.tiff';
info = imfinfo(fname);
num_images = numel(info);

for k = 1:num_images
    A = imread(fname, k);
    
    A = im2double(A);
    
    A(:) = A(:)/max(A(:));
    figure;
    imshow(A)
    
    A(:) = A(:)*(2^16);
    nbins = 1000;
    
    figure;
    hist(A(:),nbins)
    xlabel('Image Intensity')
    ylabel('Frequency')
    
end

%% Part 3.2


fname = 'Question3.tiff';
info = imfinfo(fname);
num_images = numel(info);

for k = 1:1
    A = imread(fname, k);
    
    A = im2double(A);
    
    A(:) = A(:)/max(A(:));
    %figure;
    %imshow(A)
    
    imcrop(A)
    
end


