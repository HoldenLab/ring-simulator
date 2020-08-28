%------------------------------------------
function F= ringAndGaussBG(par,imSz,nSector)
%parameters: x0, y0, r,widthRing, AmplitudeRing, bg_flat, cytoplasmBgWidth

 % Create a logical image of a ring with specified
% inner diameter, outer diameter center, and image size.
% First create the image.
imageSizeX = imSz(2);
imageSizeY = imSz(1);
% Next create the circle in the image.
X0 = par(1);
Y0 = par(2);
R0 = par(3);
stdRing = par(4);
A = par(5);
bg_flat = par(6);
cytoBg = par(7);
cytoBgWidth=par(8);
cytoBg2 = par(9);
cytoBgWidth2=par(10);
sectorAmp(1:nSector) = par(11:11+nSector-1);

[X, Y] = meshgrid(1:imageSizeX, 1:imageSizeY);

F_bg= 0.*X;
F_ring=0.*X;
F_cyto=0.*X;


R = sqrt((X-X0).^2+(Y-Y0).^2);

%sectored ring contribution
%calculate the sectored regions
%gives you an image going round in nSector sectors 1:nSector
thetaIm = atan2((Y-Y0),(X-X0));
%alternative approach
thetaLim = -pi:(2*pi)/(nSector):pi;
sectoredImage=0.*thetaIm;
for ii = 1:nSector
    sectoredImage(thetaIm>thetaLim(ii) & thetaIm<thetaLim(ii+1)) = ii;
end

for ii = 1:nSector
    F_ring(sectoredImage==ii) = sectorAmp(ii)*A.*exp(-(R(sectoredImage==ii)-R0).^2./(2.*stdRing.^2));
end
%flat background contribution
F_bg = bg_flat;
%defocussed cyto contribution
% Gauss + Cauchy background
% cauchy function defined as 
%simple extension from 1d defined in kim et al 2013
%'Resolution recovery reconstruction for a Compton camera'
% using transform r^2 = x^2+y^2
F_cytoG = cytoBg.*exp(-((X-X0).^2+(Y-Y0).^2)./(2.*cytoBgWidth.^2));
F_cytoC = cytoBg2.*(cytoBgWidth2.^2./((X-X0).^2+(Y-Y0).^2+cytoBgWidth2.^2));
F_cyto = F_cytoG+F_cytoC;

F=F_bg+F_ring+F_cyto;


