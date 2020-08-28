load("nascentTrackData.mat","T","S","Diam","nascentTracks");

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

nTrackAvg=6;
[simRingStack groundTruth]= simulateVerciniDynamics(nascentTracks,nTrackAvg,simPar);
tiffwrite('testSimRing6trackAvg.tif',simRingStack);