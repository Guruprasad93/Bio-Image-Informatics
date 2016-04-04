%Incorporating white noise
function [I_synthetic] = createSynthetic(finalMaxima, I, noise_mean, noise)
%% Input
% finalMaxima : Load detectMaxima. mat file which contains the variable finalMaxima. It contains the x,y co-ordinate of detected particles and
% the corresponding intensity value
% I :  Original Image
% noise_mean : mean background noise computed from B2 section of the assignment  
% noise : percentage of mean intensity of detected pixel.

% Create the raw image by setting the background to zero
% The detected points are assigned their respective intensity values
% FinalMaxima. mat contains the x,y co-ordinate of detected particles and
% the corresponding intensity value
I_detection = zeros(size(I));
indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));
I_detection(indices) = finalMaxima(:,3);

% Convolve Gaussian with Raw image  

[I_detection] = Gaussian_filter(I_detection,65*1e-9); 
%White noise - mean = noise_mean; standard-dev = average of all detected localmaxima
I_noise = randn(size(I))*noise*mean(finalMaxima(:,3)) + noise_mean;


%Adding noise to psf convolved detected image
I_synthetic = I_detection + I_noise;

figure,
imshow(I_synthetic,[])
title(['Synthetic image',' : ',num2str(noise*100),' % ', 'noise']);


end