%serverDir='Z:\Shared\data\Holden-Seamus\200828_zdynamic_simulations';
%simulations of Z-ring dynamics for Whitley 2020 et al bioRxiv 2020
serverDir='D:\z dynamics paper\nascent_zdynamic_sim'; %location where the sims get saved
% nascentTrackData.mat is the experimentally measured filament dynamics from which the similations are bootstrapped
load("nascentTrackData.mat","T","S","Diam","nascentTracks");

nRepeat=100;

%all experimentally derived parameters to match nascent Zrings 
%and then we increase the FtsZ filament density to see if it 
%biases the measurements

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
%density = avg number of filaments per Z ring in experimental data
savePath=fullfile(serverDir,'nascentDensity');
saveName='simZRing_nAvg6';
nTrackAvg=6;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%2.6xnasent density (approx mature)
% density = nascent Z ring density multiplied by the amount 
% that mature Zrings are brighter than the nascent zrings. 
% minimizes potenial undercounting issues in estimation of density
savePath=fullfile(serverDir,'matureDensity');
saveName='simZRing_nAvg15.6';
nTrackAvg=15.6;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%2x mature = 5.2nasent density
% 2x estimated mature z-ring density
savePath=fullfile(serverDir,'2xmatureDensity');
saveName='testSimRing_nAvg31.2';
nTrackAvg=31.2;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
%erickson density
% 30x nascent filament density, and 11.5x estimated mature filament density
% designed to make sure no bias in key metrics - speed, ratio of static:motile
% filaments, even at v high filament denstiy
% for the record it's called erickson density because its estimated from 
% estimated filament dimensions and concentrations of FtsZ in 
% Erickson et al Microbiol Mol Biol Rev (2010)
savePath=fullfile(serverDir,'ericksonDensity');
saveName='testSimRing_nAvg180';
nTrackAvg=180;
batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar);
