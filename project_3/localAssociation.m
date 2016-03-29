function [associationMat, Tri_indices] = localAssociation(localMax, localMin, I)

%Image dimensions
[r,c] = size(I);

localMax(:,1) = r-localMax(:,1);
localMin(:,1) = r-localMin(:,1);

localMax(:,2) = localMax(:,2) - 1;
localMin(:,2) = localMin(:,2) - 1;

%Applying delaunay Triangulation for localMin
Tri_indices = delaunay(localMin(:,2),localMin(:,1));

%List of delaunay triangles
num_tri = size(Tri_indices,1)

%Converting from indices to vertices

associationMat = zeros(size(localMax,1),4); %[localMax(xpos), localMax(ypos), localMax(intensity), triangle#]
revertLocalMax = zeros(size(localMax,1),3);

    for i = 1:num_tri
        %triIndex = Tri_indices(i,:);
        xv = localMin(Tri_indices(i,:),2);
        yv = localMin(Tri_indices(i,:),1);
        localMax;
        [in] = inpolygon(localMax(:,2),localMax(:,1),xv,yv);
        
        a = find (in == 1);
        
        if (size(a,1) ~= 0)
 
            c = ones(size(a,1),1)*i;
            revertLocalMax(a,2) = localMax(a,2) + 1;

            revertLocalMax(a,1) = r-localMax(a,1);
            indices = sub2ind(size(I),revertLocalMax(a,1),revertLocalMax(a,2));
            revertLocalMax(a,3) = I(indices)';
            revertLocalMax(a,:);
            associationMat(a,:) = [revertLocalMax(a,2),revertLocalMax(a,1),revertLocalMax(a,3),ones(size(a,1),1)*i];
            associationMat(a,:);    
        end
    end

   %Removing all elements where localMaxima is outside the triangulation
   %plane
   
   associationMat(all(associationMat == 0,2),:) = [];
end
    
    
    