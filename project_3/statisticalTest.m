function [finalMaxima] = statisticalTest(Quantile, associationMat, localMin, Tri_indices, bkgdStd, I)

%Size of association Matrix
num_rows = size(associationMat,1);

%Find I_BG average from the delaunay triangle
ctr = 1;
for i = 1:num_rows
    
    rows = localMin(Tri_indices(associationMat(i,4),:),1);
    cols = localMin(Tri_indices(associationMat(i,4),:),2);
    
    indices = sub2ind(size(I),rows, cols);
    
    I_BG = mean(I(indices));
   
    var_deltaI = (1/3*(bkgdStd)^2);
    
    T = abs(associationMat(i,3) - I_BG)/sqrt(var_deltaI);
    
    if T>=Quantile
        finalMaxima(ctr,:) = [associationMat(i,2),associationMat(i,1)]; %[row, col]
        ctr = ctr + 1;
    end
    

end