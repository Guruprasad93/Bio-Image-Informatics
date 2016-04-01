%% Question 3 - Part 2

%Set of Inputs (Wavelength(lammbda) and Numerical Aperture(NA)
lambda = [480*1e-9, 520*1e-9, 680*1e-9, 520*1e-9, 520*1e-9, 680*1e-9]; 
NA = [0.5, 0.5, 0.5, 1.0, 1.4, 1.5];

%Distance along the screen
y = [-50*1e-7:0.1*1e-7:50*1e-7]; 

%Airy disk Intensity along the screen for each of the wavelength-NA pairs
for i = 1:6
    I(i,:) = PlotAiryDisk(lambda(i),NA(i));
end

%Determining Radii of the Airy disks.
radius = findradius(I, y); 

%Determining sigma for best fitted gaussian kernel
BestFittedSigma = gaussianFit(I); 
