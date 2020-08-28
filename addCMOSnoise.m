function Fnoisy_DU = addCMOSnoise(F_DU,gain,rmsNoise)
%gain G is units of e/DU -> e=G*DU
% rmsNoise is electrons

F_e= gain*F_DU;
Fnoisy_e = poissrnd(F_e);
Fnoisy_e = Fnoisy_e + rmsNoise*randn(size(Fnoisy_e));
Fnoisy_DU = Fnoisy_e/gain;

