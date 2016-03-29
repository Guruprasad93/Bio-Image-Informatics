function [I_filtered] = filter_image(I)

%Rayleigh's radius
lambda = 515*1e-9;
NA = 1.4;
radius = 0.61*lambda/NA;

%Gaussian kernel sigma
sigma = radius/3;

%Filtered Image
[I_filtered] = Question1_1(I,sigma);

end