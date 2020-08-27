function [ringStack, track]=genTrackRingImage(track,nFrame, pixSizenm ,sigmaPSFnm, imSizePix)
% function [ringStack, posSim]=genTrackRingImage(track,nFrame, pixSizenm ,imSizePix)

ringStack=zeros(imSizePix,imSizePix,nFrame);
sigmaPSFpix= sigmaPSFnm/pixSizenm;

%account for asymmetry of initial position due to finite pixel size
%matlab image coordinates centre of top left edge pizel is (1,1), 
% so image midpoint is (imWidth+1)/2
ringCentroid= [(imSizePix+1)/2+(rand(1)-0.5),(imSizePix+1)/2+(rand(1)-0.5)];
track.xIm = ringCentroid(1)+track.x/pixSizenm;
track.yIm = ringCentroid(2)+track.y/pixSizenm;

%compute spot profile for all frames containing a track
nPt = size(track,1);
for ii =1:nPt
    fr = track.fr(ii);
    posX=track.xIm(ii);
    posY=track.yIm(ii);
    im= generateGaussPSFIm([posX,posY],sigmaPSFpix,imSizePix);
    ringStack(:,:,fr)=im;
end
