%Fit gaussian to data (Minimization of square error)

function [FinSig] = gaussianFit(I)

%% Inputs/Outputs

%I/P: I is the Intensity vector along the screen
%O/P: FinSig is the standard deviation of the best gaussian kernel that fits the
%PSF 

%% Implementation

    sigma = [0.005e-7:0.005e-7:10*1e-7]; %Range of sigma being explored
    x = [-50*1e-7:0.1*1e-7:50*1e-7]; %Distance along the screen

     for j=1:size(I,1)


        I(j,find(isnan(I(j,:)) == 1)) = 1;
        min = Inf; %Any Very high value
        for i = 1:length(sigma)

            gaussY = exp(-(x.^2)/(2*sigma(i)^2));
            gaussY(find(isnan(gaussY) == 1)) = 1;

            MeansquareError = sum((gaussY-I(j,:)).^2);

            if min>MeansquareError
                min = MeansquareError;
                sigmaFinal = sigma(i);
            end
           
        end
        

        FinSig(j) = sigmaFinal;
       

end
