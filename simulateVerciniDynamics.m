function [simRingStack groundTruth]= simulateVerciniDynamics(trackDynamicSeedTable,nTrackAvg,simPar,ringBackgroudIm)
% simulate ring dynamics using by bootstrapping filaments from 
% list of real track speed+lifetimes
% trackDynamicSeedTable: table with required T (lifetime) and S (speed) columns)
% nTrackAvg: Average number of tracks per kymograph
% simPar
%   simParDefault.diam=880
%   simParDefault.nFr=120;
%   simParDefault.dt=1;
%   simParDefault.pixSizenm=65;
%   simParDefault.imSizePix=60;
%   simParDefault.FWHMPSFnm=300; %approx PSF size measured ages ago on beads 
%   simParDefault.filamentSznm=150;
%   simParDefault.filamentIntensity=525;
%   simParDefault.nTrackKymo=6;
%   simParDefault.cameraGain=0.65;
%   simParDefault.cameraRmsNoise=1.7;

simParDefault.diam=880;
simParDefault.nFr=120;
simParDefault.dt=1;
simParDefault.pixSizenm=65;
simParDefault.imSizePix=60;
simParDefault.FWHMPSFnm=300; %approx PSF size measured ages ago on beads 
simParDefault.filamentSznm=150;
simParDefault.filamentIntensity=525;
simParDefault.nTrackKymo=6;
simParDefault.cameraGain=0.65;
simParDefault.cameraRmsNoise=1.7;
DEFAULT_RING_BG_FNAME='ringBG_avgpar.mat';

%populate any missing fields from default
if ~exist('simPar','var')
    simPar=simParDefault;
else
   % List fields in both structs
    sf = fieldnames(simPar); 
    df = fieldnames(simParDefault); 
    % List fields missing in s
    missingIdx = find(~ismember(df,sf));
    % Assign missing fields to s
    for i = 1:length(missingIdx)
        simPar.(df{missingIdx(i)}) = simParDefault.(df{missingIdx(i)}); 
    end 
end

if ~exist('ringBackgroudIm')
    load(DEFAULT_RING_BG_FNAME,'F_ringBG');
    ringBackgroudIm=F_ringBG;
end

trackBootstrapped=genSimTrackTS(trackDynamicSeedTable,simPar.nTrackKymo);
groundTruth.trackTable= trackBootstrapped;

FWHM_Znm=sqrt(simPar.FWHMPSFnm^2+simPar.filamentSznm^2);
sigmaZnm=FWHM_Znm/2.35;

[ringStack, trackCoord] = genAllTrackImage(trackBootstrapped,...
    simPar.diam,simPar.dt,simPar.nFr,simPar.pixSizenm ,sigmaZnm, simPar.imSizePix);
groundTruth.trackCoord=trackCoord;

ringStackIntense=ringStack*simPar.filamentIntensity;

BG_allFrame=repmat(ringBackgroudIm,[1 1 simPar.nFr]);
ringStackIntense=ringStackIntense+BG_allFrame;

simRingStack= addCMOSnoise(ringStackIntense,simPar.cameraGain,simPar.cameraRmsNoise);
