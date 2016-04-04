function [bkgdMean, bkgdStd, crop_width, crop_height] = crop_background(I, num_iterations)
% I is read image

%NEW CODE
I_vals_r = [];

%Display figure
figure, 
imshow(I,[])
I = double(I);

for iter = 1:num_iterations
    
    %Selecting Background area
    h = imrect;
    pos = getPosition(h);
    xmin = floor(pos(1));
    ymin = floor(pos(2));
    width = floor(pos(3));
    height = floor(pos(4));

    %Cropping ROI, visualizing cropped image
    I2{iter} = I(ymin: ymin+height, xmin: xmin+width); %height - rows; width - columns
    

	%NEW CODE
	% save all the intensity values in one row, including from previous iterations
	for y = ymin:ymin+height
		I_vals_r = [I_vals_r I(y,xmin:xmin+width)];
	end
	
	%NEW CODE: for better visualization
	h = rectangle('Position',pos);
	par = h.Parent;
	
    crop_width(iter,:) = [width, xmin];
    crop_height(iter,:) = [height, ymin];

end

%Show cropped figures
for iter = 1:num_iterations
	figure,
	imshow(I2{iter}, [])
end
	
%NEW CODE
bkgdMean = mean(I_vals_r);
bkgdStd = std(I_vals_r);

close all