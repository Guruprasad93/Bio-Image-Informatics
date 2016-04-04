
I_completeSubpixel = imresize(I,5,'bilinear');

% I_complete = zeros(size(I_completeSubpixel));
% 
% indices = sub2ind(size(I_completeSubpixel),finalsubPixelMaxima(:,1),finalsubPixelMaxima(:,2));
% 
% I_detection(indices) = 500;



figure,
imshow(I_completeSubpixel,[])
hold on
scatter(finalsubPixelMaxima(:,2),finalsubPixelMaxima(:,1))
title(['Size of image:', num2str(size(I_completeSubpixel,1)), ' x ', num2str(size(I_completeSubpixel,2)) ])