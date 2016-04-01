%Find radius of all airy disks
function [radius] = findradius(Intensity, y)

%% Inputs/Outputs

%I/P: Intensity is the Intensity vector along the screen
%O/P: radius is the calculated value of distance from bright maxima to
%first minima in the PSF

%% Implementation

I = Intensity;

for i = 1:size(I,1)
    
    %Inverting data to find minima
    DataInv = 1.01*max(I(i,:)) - I(i,:);
    [Minima,MinIdx] = findpeaks(DataInv);
    
    %Finding index for bright maxima
    maxIdx = find(I(i,:) == max(I(i,:)));
    
    %Finding closest minima to the central bright maxima
    MinIdxchanged = abs(MinIdx - maxIdx(1));
    
    %Distance between bright maxima and first minima
    radius(i) = y(maxIdx(1)) - y(MinIdx(find(MinIdxchanged == min(MinIdxchanged))));
end
    
    