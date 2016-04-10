
I_completeSubpixel = imresize(I_gaussFilter,5,'bilinear');

% I_complete = zeros(size(I_completeSubpixel));
% 
% indices = sub2ind(size(I_completeSubpixel),finalsubPixelMaxima(:,1),finalsubPixelMaxima(:,2));
% 
% I_detection(indices) = 500;

%Raw synthetic image   
I_detection = zeros(size(I));
indices = sub2ind(size(I),finalMaxima(:,1),finalMaxima(:,2));
I_detection(indices) = finalMaxima(:,3);

I_noNoise = imresize(I_detection,5,'bilinear');

figure,
%imshow(I_completeSubpixel,[])
imshow(I_noNoise)
a = 10;
hold on
%scatter(finalsubPixelMaxima(:,2),finalsubPixelMaxima(:,1),a,'b','filled')

scatter(Algo_subPixelMaxima(:,2),Algo_subPixelMaxima(:,1),a,'b','filled')
hold on
scatter(Real_subPixelMaxima(:,4),Real_subPixelMaxima(:,3),a,'g','filled')
%scatter(

title(['Size of image:', num2str(size(I_completeSubpixel,1)), ' x ', num2str(size(I_completeSubpixel,2)) ])