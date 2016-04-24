function [cand_pts, eigVal] = detectCurve(im, sigma)

%Checking arguments input to function
if nargin<2
    %Initialize value for sigma
    sigma = 3;
end

%Converting image to double
im = double(im);

%Size of gaussian kernel (N) and indices (ind)
N = 2*(3*ceil(sigma))+1;
ind = -floor(N/2):floor(N/2)';
X = ind;
Y = X';

%Gaussian derivative kernels in the x-dir and y-dir
Gauss_xDer = (exp(-(X.^2)/2*sigma^2).*(-X))/(sigma^3*sqrt(2*pi));
Gauss_yDer = (exp(-(Y.^2)/2*sigma^2).*(-Y))/(sigma^3*sqrt(2*pi));

%Convolving the x-dir kernel with image to get $r'_x$
Rx = conv2(im, Gauss_xDer, 'same');
Ry = conv2(im, Gauss_yDer, 'same');

%Taking Rx gradient in the x-direction
% Rxx = imageGradient(Rx,1);
% Rxy_1 = imageGradient(Rx,2);
% Rxy_2 = imageGradient(Ry,1);
% Ryy = imageGradient(Ry,2);

s_I = sigma;  
g = fspecial('gaussian',max(1,fix(6*s_I+1)), s_I);  
Rxx = conv2(Rx.^2, g, 'same'); % Smoothed squared image derivatives  
Ryy = conv2(Ry.^2, g, 'same');  
Rxy_1 = conv2(Rx.*Ry, g, 'same');  


%For every pixel in image, take hessian and compute eigen-vectors
for r = 1:size(im,1)
    for c = 1:size(im,2)
        
        %Hessian matrix for each pixel
        H = [Rxx(r,c),Rxy_1(r,c);Rxy_1(r,c),Ryy(r,c)];
        %Determine eigenvector with largest eigenvalue
        [v,d] = eig(H);
        
        if (abs(d(1,1))>abs(d(2,2)))
            v = [v(1,1),v(2,1)];
            eigVal(r,c) = abs(d(1,1));
        else
            v = [v(1,2),v(2,2)];
            eigVal(r,c) = abs(d(2,2));
        end
        
        t = -(Rx(r,c)*v(1) + Ry(r,c)*v(2))/(Rxx(r,c)*v(1)^2 + 2*Rxy_1(r,c)*v(1)*v(2)+Ryy(r,c)*v(2)^2);
        
        %Px, Py 
        px(r,c) = t*v(1);
        py(r,c) = t*v(2);
        
        
    end
end

[cand_X, cand_Y] = find(abs(px)<=0.5 & abs(py)<=0.5 &eigVal>0.005);
cand_pts = [cand_X, cand_Y];

figure,
imshow(im, [])
hold on
scatter(cand_pts(:,2), cand_pts(:,1), 'g.');
hold off
   

% [eigenvalue1, eigenvalue2, eigenvectorx, eigenvectory]=eig2image(Rxx, Rxy_1, Ryy); 
% 
% t = -(Rx.*eigenvectorx + Ry .* eigenvectory) ./...  
%     (Rxx .* eigenvectorx.^2 + 2*Rxy_1.*eigenvectorx.*eigenvectory + Ryy.*eigenvectory.^2 );  
% 
% px = t.*eigenvectorx;  
% py = t.*eigenvectory;  
% 
% [candidateX1, candidateY1] = find(px >= -0.5 & px <= 0.5 & py >= -0.5 & py <= 0.5);  
% cand_pts = [candidateX1, candidateY1];  
% 
% figure,
% imshow(im, []);  
% hold on  
% scatter(cand_pts(:,2), cand_pts(:,1), 'g.');  
% hold off;



end