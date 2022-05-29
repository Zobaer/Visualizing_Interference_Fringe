clear; 
close all; 
clc;

disp('To set the default values press Enter.');

D=input('Distance of sources from the screen in m(Default val 10m):');
if isempty(D)
    D = 10;
end

Lam=input('Wavelength of the light in m(Default value 570*10^-3 m):');
if isempty(Lam)
    Lam = 570*10^-3;
end

row=input('Number of rows on the square screen (Default value 555):');
if isempty(row)
    row = 555;
end
col = row;

s=input('Length of the screen in m (Default val sqrt(600*D*Lam)m):');
if isempty(s)
    s=sqrt(600*D*Lam);
end
unit = s/row;                     % distance between succesive pixels.

rm=input('Row co-ord of projectn of source1 (Default ceil(row/2)):');
if isempty(rm)
    rm = ceil(row/2); 
end

cm=input('Col coord of projectn of source1(Default ceil(col/2)-80):');
if isempty(cm)
    cm = ceil(col/2)-80; 
end
for r = 1:row
    for c = 1:col
        d1 = sqrt(((rm-r)^2 + (cm-c)^2))*unit;

   % distance from the 1st source
        effD1 = sqrt(d1^2 + D^2) ; 

   % phases of the wavefront from the 1st source
        phase1 = (2*pi/Lam) * effD1;  

   % keeping the phases between 0 to 2*pi   
   phi1(r,c) = mod(phase1,2*pi);
    end
end

phi_temp = flipud(phi1);
phi2 = fliplr(phi_temp);     % phases of wavefront from the 2nd source
I = (cos((phi1-phi2)/2)).^2;               % calculating the intensity

figure;
imshow(I);
title('Interference fringe');
colormap(autumn); colorbar;

figure;
imshow(phi1/max(max(phi1)));
title('The wave front falling on the screen from 1st source');
colormap(autumn); colorbar;

figure;
imshow(phi2/max(max(phi2)));
title('The wave front falling on the screen from 2nd source');
colormap(cool); colorbar;

figure;
del_ph=phi1-phi2;
imshow(del_ph/max(max(del_ph)));
title('Superimposed wave fronts showing nodal and anti-nodal lines');
colormap(cool); colorbar;
