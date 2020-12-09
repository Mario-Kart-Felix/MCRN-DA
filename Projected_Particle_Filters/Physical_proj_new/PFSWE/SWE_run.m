close all; clear;clc;

%Runs
epsOmega =0.0000001; %For inth = 1
%Observe every inth variable.
inth=1;
Numsteps=100;
%Q=1E-2, R=1E-2
epsQ=1;
epsR=1E-2;
Num=10;
Mult=100/Num;

%% Type of particle filter
% Use of standard PF or OP-PF (iOPPF=0 => standard PF, iOPPF=1 => OP-PF)
iOPPF=1;
%% Projection_type(0 = no projection, 1 POD, 2 DMD, 3 AUS)
PhysicalProjection =2;
DataProjection =2 ;
% Observed variables scenario following Paulina et al.
% scenario 1: observe inth u and v's
% scenario 2: observe inth everything
% scenario 3: observe inth h
scenario =1 ;
for j=1:Num
    numModes_physical=j*Mult;%DMD
    tolerance_physical=j*Mult;%POD
    [Time(:,j),RMSEsave(:,j), RMSEsave_proj(:,j), XCsave(:,j), XCprojsave(:,j), ESSsave(:,j), ResampPercent(:,j)]=PFSWErun...
        (numModes_physical,epsQ,epsR,tolerance_physical,iOPPF,PhysicalProjection,DataProjection,scenario,epsOmega, inth,Numsteps);
end
L=5;
% % %% Save to mat file
filename = sprintf('SWEp_%2d%2d_%2d_%2d_%4d_%d_%d.mat',PhysicalProjection,DataProjection,epsQ,epsR,inth,scenario,L)
params.PhysicalProjection = PhysicalProjection;
params.DataProjection = DataProjection;
params.epsQ = epsQ;
params.epsR=epsR;
params.iOPPF = iOPPF;
% params.ObsErr=ObsErr;
params.numModes=numModes_physical;
params.Num=Num;
params.Mult=Mult;
params.epsOmega=epsOmega;

results.RMSEsave = RMSEsave;
results.RMSEsave_proj = RMSEsave_proj;
results.XCsave = XCsave;
results.XCsave_proj =XCprojsave;
results.ESSsave= ESSsave;
results.ResampPercent =ResampPercent;
results.Time =Time;
save(filename,'params','results');
