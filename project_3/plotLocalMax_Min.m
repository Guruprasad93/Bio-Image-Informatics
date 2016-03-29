function [] = plotLocalMax_Min(localMax, localMin,I)

%Image dimensions
[r,c] = size(I);

localMax(:,1) = r-localMax(:,1);
localMin(:,1) = r-localMin(:,1);

localMax(:,2) = localMax(:,2) - 1;
localMin(:,2) = localMin(:,2) - 1;

figure,
scatter(localMax(:,2),localMax(:,1),'r')
hold
scatter(localMin(:,2),localMin(:,1),'b')


end
