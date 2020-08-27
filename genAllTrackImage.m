function [ringStack, trackCoordAll] = genAllTrackImage(trackList,diam,dt,nFr, pixSizenm ,sigmaPSFnm, imSizePix)

nTrack = size(trackList,1);

ringStack=zeros(imSizePix,imSizePix,nFr);

trackCoordAll=table();
for ii=1:nTrack
    tau=trackList.T(ii);
    s=trackList.S(ii);

    trackCoord=genTrackCoord(tau,s,diam,dt,nFr);
    trackCoord.id=ii*ones(size(trackCoord.x));
    [ringStackN, trackCoord]=genTrackRingImage(trackCoord,nFr, pixSizenm ,sigmaPSFnm, imSizePix);
    ringStack=ringStack+ringStackN;

    trackCoordAll=[trackCoordAll;trackCoord];
end
