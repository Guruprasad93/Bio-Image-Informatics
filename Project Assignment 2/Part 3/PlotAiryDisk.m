function [I] = PlotAiryDisk(lambda, NA) %Input to Function is Wavelength and Numerical Aperture

%% Inputs/Outputs

%I/P: lambda is the wavelength, and NA is the Numerical Aperture
%O/P: I is the Intensity vector along the screen

%%
I0 = 1; 

y = [-50*1e-7:0.1*1e-7:50*1e-7]; %Distance along the screen
x = (2*pi/lambda)*NA*y; %x = k*a*sin(theta)
I = I0*(2*besselj(1,x)./x).^2; %Intensity = 2*[J1(x)/x]^2 
I = I/max(I); %Normalizing by setting peak intensity = 1

end
