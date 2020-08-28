serverDir='Z:\Shared\data\Holden-Seamus\200828_zdynamic_simulations';
load("nascentTrackData.mat","T","S","Diam","nascentTracks");

nRepeat=100;

simPar.diam=880;
simPar.nFr=120;
simPar.dt=1;
simPar.pixSizenm=65;
simPar.imSizePix=60;
simPar.FWHMPSFnm=300; %approx PSF size measured ages ago on beads 
simPar.filamentSznm=150;
simPar.filamentIntensity=525;
simPar.nTrackKymo=6;
simPar.cameraGain=0.65;
simPar.cameraRmsNoise=1.7;

nascentFilamentDensity=6;

%nasent density
savePath=fullfile(serverDir,'nascentDensity');
saveName='simZRing_nAvg6';
nTrackAvg=6;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%2.6xnasent density (approx mature
savePath=fullfile(serverDir,'matureDensity');
saveName='simZRing_nAvg15.6';
nTrackAvg=15.6;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%2x mature = 5.2nasent density
savePath=fullfile(serverDir,'2xmatureDensity');
saveName='testSimRing_nAvg31.2';
nTrackAvg=31.2;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%erickson density
savePath=fullfile(serverDir,'ericksonDensity');
saveName='testSimRing_nAvg180';
nTrackAvg=180;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
