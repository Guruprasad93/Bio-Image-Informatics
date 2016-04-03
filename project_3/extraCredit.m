%Extra credit Problem

function [Algo_subPixelMaxima, Real_subPixelMaxima] = extraCredit(I_synthetic, I_syntheticNoNoise, finalMaxima)

%Passing the (Un)convolved original image for gaussian level detection
[Algo_subPixelMaxima, Real_subPixelMaxima] = subPixelDetection(finalMaxima, I_synthetic, I_syntheticNoNoise);

end   