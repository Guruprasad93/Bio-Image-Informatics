
function[imGauss] = Question1_3_new(pathToImage,sigma_x, sigma_t, phi)
%% The Inputs to the function are as follows
% pathToImage : Takes as input a string which specifies the path to the
% image
% Example : pathToImage = 'image01.tiff'
% sigma_x : std dev along x-axis
% sigma_t : std dev along t-axis (lateral axis)

% phi : Is a vector variable that takes as input the values of phi (in
% radians)
% For Example phi = [pi/2,pi/4]

% The output of the function consists of a series of images for different
% phi values, and the images (after filtering)

%% Parameter values
% pathToImage = 'image1.tif';
% sigma_x = 5;
% sigma_t = 10;
% phi = pi/4;


%% Read in the image

im = double(imread(pathToImage));
% figure,
% imshow(im,[]);
% title('Original Image')


%% Apply the Gaussian filter for all sigma
for phiVal = phi
    
    % Define size of Gaussian mask
    N = (2*(3*sigma_x))+1;
    Nx = N;
    Nt = (2*(3*sigma_t))+1;
    
    %Display the size of the gaussian mask
    display(strcat('Size of the 2 gaussian kernels for sigma = ',num2str(sigma_x),' ',' is ', num2str(N),' : ', num2str(Nt))); 

    % Reference :  http://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
    % Create a Gaussian mask
    ind = -floor(Nx/2) : floor(Nx/2);
    X = ind;
    
    %Gaussian filtering in x dimension
    h = (exp(-(X.^2)/(2*sigma_x*sigma_x)))/(sqrt(2*pi)*sigma_x);
    h = h./sum(h(:)); %Normalized 1D Mask
    
    % As a check i implemented the convolution using conv2 and for loops and both implementations return the same
    % value with significant precision
    % Note : using conv2 is much faster !! 
    % blur =conv2(im, h,'same');

    % Pad the image with zeros
    imPad = padarray(im,[floor(2*Nt/2) floor(2*Nt/2)]);
    imGauss = zeros(size(imPad,1),size(imPad,2));
    
    imGauss_x = zeros(size(imPad,1),size(imPad,2));
    
    %Along x direction
    for ii = floor(2*Nt/2)+1: size(imPad,1)-floor(2*Nt/2)
       for jj = floor(2*Nt/2)+1:size(imPad,2)-floor(2*Nt/2)
          imVal=imPad(ii,jj-floor(N/2):jj+floor(N/2));
          filtIm = imVal.* h;
          imGauss_x(ii,jj)=sum(filtIm(:));
        end
    end    
    
    figure,
    imshow(imGauss_x(floor(2*Nt/2)+1: size(imPad,1)-floor(2*Nt/2),floor(2*Nt/2)+1:size(imPad,2)-floor(2*Nt/2)),[]);
    title(['Blurred Image along x direction for sigma_x = ',' ',num2str(sigma_x), 'phi = ', num2str(phiVal*180/pi)]);
    
    %% Gaussian Filtering along y-axis
%      h = h';
%     
%      for jj = floor(N/2)+1:size(imPad,2)-floor(N/2)
%         for ii = floor(N/2)+1: size(imPad,1)-floor(N/2)
%             imVal=imGauss_x(ii-floor(N/2):ii+floor(N/2), jj);
%             filtIm = imVal.* h;
%             imGauss(ii,jj)=sum(filtIm(:));
%         end
%      end    
    
     %% Gaussian Filtering along T-direction
     
     % Reference :  http://www.mathworks.com/matlabcentral/answers/81689-how-to-implement-convolution-instead-of-the-built-in-imfilter
     % Create a Gaussian mask
    ind = -floor(Nt/2) : floor(Nt/2);
    T = ind; %Here, T is the index, along the "t-axis".
    
    %Gaussian filtering in y dimension
    ht = (exp(-(T.^2)/(2*sigma_t*sigma_t)))/(sqrt(2*pi)*sigma_t);
    ht = ht./sum(ht(:)); %Normalized 1D Mask
    mu = tan(phiVal);
    
    Tmod = T/mu;
        
    %Along T direction
    for x = floor(2*Nt/2)+1:size(imPad,2)-floor(2*Nt/2)
        for y = floor(2*Nt/2)+1: size(imPad,1)-floor(2*Nt/2)
            
            %For every element
            
            tDirxEle = x+Tmod;
            tDiryEle = y-T;
            
            %Interpolate if element is not a pixel
            arr1 = floor(tDirxEle)+1;
            arr2 = floor(tDirxEle);
            
            % Considering special cases, when 
            if arr2(1) == 0
                arr2(1) = 1;
            end
            
            if arr1(end) > size(imGauss_x,2)
                arr1(end) = size(imGauss_x,2);
            end
                
                
            
            pos1 = sub2ind(size(imGauss_x),tDiryEle, arr1); %Ceil
            pos2 = sub2ind(size(imGauss_x),tDiryEle, arr2); %Floor
            
            
            interpolPar = (tDirxEle-floor(tDirxEle)); %interpolation parameters
            
            imgInterpolation = interpolPar.*imGauss_x(pos1)+(1-interpolPar).*imGauss_x(pos2);
            filtIm = imgInterpolation.*ht;
            
            imGauss(y,x) = sum(filtIm(:));
            

        end
    end    

    figure,
    imshow(imGauss(floor(2*Nt/2)+1: size(imPad,1)-floor(2*Nt/2),floor(2*Nt/2)+1:size(imPad,2)-floor(2*Nt/2)),[]);
    title(['Blurred Image along x+t dir for sigma_x = ',' ',num2str(sigma_x),'Sigma_t =  ', num2str(sigma_t),'Phi = ',num2str(phiVal*180/pi)]);
    
    
end
%%
% %// Convert filter into a column vector
% h = h(:);
% 
% % Blur the image using a gaussian kernel
% 
% I = im2double(im);
% % pad the image with zeros around the boundary
% I_pad = padarray(I, [floor(N/2) floor(N/2)]);
% C = im2col(I_pad, [N N], 'sliding');
% C_filter = sum(bsxfun(@times, C, h), 1);
% blurred_image = col2im(C_filter, [N N], size(I_pad), 'sliding');
