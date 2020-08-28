function batchVerciniSimulator(savePath, saveName,nRepeat,nascentTracks,nTrackAvg,simPar)

if ~exist(savePath,'dir')
    mkdir(savePath);
end

for ii = 1:nRepeat
    saveNameIm = fullfile(savePath, [saveName,sprintf('_%03i.tif', ii)])
    saveNameGT = fullfile(savePath, [saveName,sprintf('_%03i_GT.mat', ii)])
    
    [simRingStack groundTruth]= simulateVerciniDynamics(nascentTracks,nTrackAvg,simPar);
    tiffwrite(saveNameIm,simRingStack);
    save(saveNameGT,'groundTruth','simPar','nTrackAvg');
end


