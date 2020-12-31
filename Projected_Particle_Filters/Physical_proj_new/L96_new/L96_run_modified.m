close all; clear;clc;
F = 8; % Lorenz'96 Forcing
ObsMult=5; % % Observe and every ObsMult steps(10 with F=3.5, 5 with F=8)
epsQ=1;
epsR=1E-2;
N=40;
Num=5;
Mult=N/Num;
%% Projection_type(0 = no projection, 1 POD, 2 DMD, 3 AUS)


PhysicalProjection =2;
DataProjection =2 ;
Num_trials=10;
for j=1:Num
    for k=1:Num_trials
        numModes_physical=j*Mult+1;%DMD
        tolerance_physical=j*Mult;%POD
        nummodes=numModes_physical-1;
        if nummodes==N
            PhysicalProjection=0;
        end
        [Time(:,j,k),RMSEsave(:,j,k), RMSEsave_proj(:,j,k), ResampPercent(:,j,k)]= L96_modified...
            (numModes_physical,epsQ, epsR,tolerance_physical,PhysicalProjection,DataProjection,ObsMult,N, F);
    end
end
%% Save to mat file
PhysicalProjection=2;

filename = sprintf('L96_F%d_%s_%s_Q%1.2f_R%1.2f_N%04d.mat',...
    F,...
    proj2string(PhysicalProjection),...
    proj2string(DataProjection),...
    epsQ,...
    epsR,...
    N)
params.PhysicalProjection = PhysicalProjection;
params.DataProjection = DataProjection;
params.epsQ = epsQ;
params.epsR=epsR;
params.numModes=numModes_physical;
params.Num=Num;
params.N=N;
params.Mult=Mult;

results.RMSEsave = RMSEsave;
results.RMSEsave_proj = RMSEsave_proj;
%% TEMPORARILY NOT SAVING THESE
% results.XCsave = XCsave;
% results.XCsave_proj =XCprojsave;
% results.ESSsave= ESSsave;
results.ResampPercent =ResampPercent;
results.Time =Time;

save(filename,'params','results');

function out = proj2string(val)
switch(val)
    case 0
        out = 'NON';
    case 1
        out = 'POD';
    case 2
        out = 'DMD';
    case 3
        out = 'AUS';
    otherwise
        error("Unknown method")
end
end
