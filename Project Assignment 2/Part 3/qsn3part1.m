
%Set of Inputs (Wavelength(lammbda) and Numerical Aperture(NA)
lambda = [480*1e-9, 520*1e-9, 680*1e-9, 520*1e-9, 520*1e-9, 680*1e-9]; 
NA = [0.5, 0.5, 0.5, 1.0, 1.4, 1.5];

%Distance along the screen
y = [-50*1e-7:0.1*1e-7:50*1e-7]; 

%Airy disk Intensity along the screen for each of the wavelength-NA pairs
for i = 1:6
    I(i,:) = PlotAiryDisk(lambda(i),NA(i));
end

%Plot Airy disks for each of the wavelength-NA pairs
plot(y,I(1,:),'r',y,I(2,:),'b',y,I(3,:),'g',y,I(4,:),'c',y,I(5,:),'k',y,I(6,:),'y')
legend('Lambda=480nm, NA=0.5','Lambda=520nm, NA=0.5','Lambda=680nm, NA=0.5','Lambda=520nm, NA=1.0','Lambda=520nm, NA=1.4','Lambda=680nm, NA=1.5')
xlabel('Distance along screen (y) in m')
ylabel('Intensity profile (I) in units')