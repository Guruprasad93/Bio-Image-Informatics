%Extra credit Problem

function [Algo_subPixelMaxima, Real_subPixelMaxima] = extraCredit(I_synthetic, I_syntheticNoNoise, finalMaxima)
% finalMaxima : Load FinalMaxima. mat. It contains the x,y co-ordinate of detected particles and
% the corresponding intensity value
% I_synthetic :  Synthetic Image(ground truth)
% I_syntheticNoNoise :  This is an optional parameter used in the extra
% credit section of Main.m. This is an image which contains only the
% detected particle intensities with no added noise(raw image).

% Algo_subPixelMaxima : subpixel co-ordinates detected by the algorithm
% Real_subPixelMaxima : Subpixel co-ordinates in the raw synthetic image / gold standard
% image

%Passing the (Un)convolved original image for gaussian level detection
[Algo_subPixelMaxima, Real_subPixelMaxima] = subPixelDetection(finalMaxima, I_synthetic, I_syntheticNoNoise);

end   