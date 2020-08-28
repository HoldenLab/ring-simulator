function trackBootstrapped=genSimTrackTS(trackTable,nTrackKymoAvg)
%function trackBootstrapped=genSimTrackTS(trackTable,nTrackKymoAvg)
% trackTable is a table of track cata, each row is a different track, each column 
%   lists a track property including but not limited to lifetime and speed

nTrackData=size(trackTable,1);
nId=poissrnd(nTrackKymoAvg);
bootId=randi(nTrackData,nId,1);
trackBootstrapped=trackTable(bootId,:);

