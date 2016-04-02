%Incorporating white noise
function [I_synthetic] = createSynthetic(finalMaxima, I, noise_mean)

I_detection = zeros(size(I));
indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));
I_detection(indices) = finalMaxima(:,3);

%gaussian conv with point-spread-function
[I_detection] = Gaussian_filter(I,65*1e-9);

%White noise - mean = noise_mean; standard-dev = average of all detected localmaxima
I_noise = randn(size(I))*0.25*mean(finalMaxima(:,3)) + noise_mean;

%Adding noise to psf convolved detected image
I_synthetic = I_detection + I_noise;

figure,
imshow(I_synthetic,[])
title('Synthetic image')

end