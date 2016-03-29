function [localMax, localMin] = findLocalMaxMin (I, maskSize)

%Image dimensions
[r,c] = size(I);

%mask Size
N = maskSize;

%Image padding
I = padarray(I,[floor(N/2) floor(N/2)]);

%Local Maxima & Minima vector
%localMax = zeros(r*c,1);
%localMin = zeros(r*c,1);
ctr = 1;

%Determining local maxima (within 2 for loops)
for i = 1+floor(N/2):r-floor(N/2)
    for j = 1+floor(N/2):c-floor(N/2)
        mask = I(i-(N-1)/2:i+(N+1)/2, j-(N-1)/2:j+(N+1)/2);
        if I(i,j) == max(mask(:))
            localMax(ctr,:) = [i,j,I(i,j)];
            ctr = ctr + 1;
        end
    end
end

ctr = 1;
%Determining local minima (within 2 for loops)
for i = 1+floor(N/2):r-floor(N/2)
    for j = 1+floor(N/2):c-floor(N/2)
        mask = I(i-(N-1)/2:i+(N+1)/2, j-(N-1)/2:j+(N+1)/2);
        if I(i,j) == min(mask(:))
            localMin(ctr,:) = [i,j,I(i,j)];
            ctr = ctr + 1;
        end
    end
end     

end