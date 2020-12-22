close all;clear all;clc;
%% This code to driveL96 for all of the physical model with fixing the data model projection with OP-PF
rng(1331);

PhysicalProjection =3;
DataProjection=3;
inth = 1;
iOPPF = 1;
%Q=1E-2, R=1E-2
epsQ=1;
epsR=1e-2;
Num=40;
N=40;
Mult=N/Num;
for j=1:Num
    numModes_physical=j*Mult;
    tolerance_physical = j*Mult;
    if numModes_physical==N
        PhysicalProjection=0;
    end
    [Time(:,j),RMSEsave(:,j), RMSEsave_proj(:,j), XCsave(:,j), XCprojsave(:,j), ESSsave(:,j), ResampPercent(:,j)]=...
        PFL96run_1(tolerance_physical,numModes_physical,PhysicalProjection,DataProjection,epsQ,epsR, iOPPF,N);
    
end
%change this value with every run
PhysicalProjection =3;
% to save the file
filename = sprintf('L98new_%2d%2d_%2d_%2d_%2d_%2d.mat',PhysicalProjection,DataProjection,epsQ,epsR,iOPPF,N)
params.PhysicalProjection = PhysicalProjection;
params.DataProjection = DataProjection;
params.epsQ = epsQ;
params.epsR=epsR;
params.iOPPF = iOPPF;
params.numModes=Mult:Mult:Num;
params.Num=Num;
params.Mult = Mult;
results.RMSEsave = RMSEsave;
results.RMSEsave_proj = RMSEsave_proj;
results.XCsave = XCsave;
results.XCsave_proj =XCprojsave;
results.ESSsave= ESSsave;
results.ResampPercent =ResampPercent;
results.Time =Time;
save(filename,'params','results');