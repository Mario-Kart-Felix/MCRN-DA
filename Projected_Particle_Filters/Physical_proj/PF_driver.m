%% Initialization
clear all;clc;
rng(1331);
F = @FLor95; % physical model
N =40; % N: physical model dimension
dt=1.E-2; % Model output time step
Built_Model = buildModel(N,F,dt);
%% Type of particle filter
% Use of standard PF or OP-PF (iOPPF=0 => standard PF, iOPPF=1 => OP-PF)
iOPPF=1;

%% Projection_type(0 = no projection, 1 POD, 2 DMD, 3 AUS)
PhysicalProjection =1;
DataProjection = 2;
tolerance_physical = 0.0001; % POD_modes
tolerance_data = 0.0001; % POD_modes
numModes_physical = 300;% DMD_modes, for physical
numModes_data = 30; % DMD_modes, for data
p_physical = 6;%Rank of projection for physical, in the case PhysicalProjection =0;DataProjection = 0;
p_data = 6; % rank of projection for data
[Ur_physical,p_physical,pzeros_physical] = ...
    Projection_physical_type(PhysicalProjection ,numModes_physical,tolerance_physical,N,Built_Model,dt,p_physical);
[Ur_data,p_data,pzeros_data] = Projection_data_type(DataProjection ,numModes_data,tolerance_data,N,Built_Model,dt,p_data);

%% Particle Filter Information
L=200;%Number of particles
alpha=1;%alpha value for projected resampling
Numsteps = 500;%Number of time steps
ObsMult=5;%Multiple of the step size for observation time
%ICs for particles
IC = zeros(N,1);
IC(1)=1;

h=1.E-3;%Computational time step
%For diagonal (alpha*I) covariance matrices.
%Observation
epsR = 0.01;
%Model
epsQ = 0.01;
%Resampling
% epsOmega = 2.E-3;
epsOmega =0.0027;
%Initial condition
epsIC = 0.01;
%Observe every inth variable.
inth=1;
%Call Init
[M,H,PinvH,IC,q,LE,w,R,Rinv,Q,Omega,ICcov,Lones,Mzeros] = ...
    Init(F,IC,h,N,inth,Numsteps,p_physical,L,epsR,epsQ,epsOmega,epsIC);

%Add noise N(0,ICcov) to ICs to form different particles
Nzeros = zeros(N,1); 
u = repmat(IC,1,L) + mvnrnd(Nzeros,ICcov,L)'; %ICchol*randn(N,L);
%% Generate observations from "Truth"
y=zeros(M,Numsteps);
t=0;
for i = 1:Numsteps
    truth(:,i) = IC;
    if mod(i,ObsMult)==0
        y(:,i)=H*IC;
    end
    IC = dp4(F,t,IC,h);
    t = t+h;
end
y = y + mvnrnd(Mzeros,R,Numsteps)'; %Rchol*rand(M,1); % + Noise from N(0,R)
%% Add projection to data using formulation by Erik- posted on slack April 8/20
[V] =projectionToggle_Physical(PhysicalProjection,N,Ur_physical,p_physical);
[U] =projectionToggle_data(DataProjection,N,Ur_data,p_data);
Rfixed = R;

%%
%Initial time and time step
t=0;
t0=t;
Resamps=0;
RMSEave_orig=0;
RMSEave_proj=0;
iRMSE=1;
%Loop over observation times
[M,H,PinvH] = new_Init(N,inth,V); %M:Observation dimension
Q=V'*Q*V;
x=V'*u;
estimate(:,1) = x*w;


for i=1:Numsteps
    est=estimate(:,i);
    % Get projection of the Data Model    
    [U] = projectionToggle_data(DataProjection,N,Ur_data,p_data); %chooses which q projection we want
    % Update noise covariance
    R = U' * PinvH * Rfixed * PinvH' * U;
    Rinv = inv(R);
    
    if mod(i,ObsMult)==0
        %At observation times, Update weights via likelihood
        if (iOPPF==0)%Standard Particle Filter(Physical projection)
            %Add noise only at observation times
            x = x + mvnrnd(pzeros_physical,Q,L)';
%             Innov = repmat(y(:,i),1,L) - H*x;
            Hnq = U'*PinvH*H*V; % H has already been multiplied by V in new_init            
            Innov=repmat(U'*PinvH*y(:,i),1,L)-Hnq*x;%try to code what Erik wrote on slack
        else % IOPPF ==1, Optimal proposal PF
            Hnq = U'*PinvH*H*V; % H has already been multiplied by V in new_init  
            Qpinv = inv(Q) + Hnq'*Rinv*Hnq;
            Qp = inv(Qpinv);
            Innov=repmat(U'*PinvH*y(:,i),1,L)-Hnq*x;
            x = x + Qp*Hnq'*Rinv*Innov + mvnrnd(pzeros_physical,Qp,L)';
            Rinv = inv(R + Hnq*Q*Hnq');
        end
        Tdiag = diag(Innov'*Rinv*Innov);
        tempering = 2; % including new parameter here for visibility. Tempering usually a little larger than 1.
        Avg=(max(Tdiag)+min(Tdiag))/2;
        Tdiag = (Tdiag-Avg)/tempering;
        %         % NEW CODE: Re weight while avoiding taking large exponentials -
        %         % avoids NAN more often
        Tdiag = -Tdiag/2;
        logw = Tdiag + log(w);
        
        % Identity used to redo normalization: log(sum(a)) = log(a_0) + log(1 + sum exp(log(w0(2:end)) - log(w0(1))))
        % Re-order weights to ensure we take the smallest possible exponents
        [~,idx] = min(abs(logw-((max(logw) - min(logw))/2))); % find index of weight closest to middle value
        logw([1 idx]) = logw([idx 1]);
        x(:,[1 idx]) = x(:,[idx 1]);
        
        toEXP = logw(2:end) - logw(1);
        toEXP=min(toEXP,709);
        toEXP=max(toEXP,-709);
        toSum = exp(toEXP);
        normalizer = logw(1) + log1p(sum(toSum));
        logw = logw - normalizer;
        w = exp(logw);
        
        % End new code
        
        
        %%%LEGACY CODE - normalizing and reweighting
        %         toEXP =(-Tdiag/2); %%%% <<<< divided exponent by 2; this is part of the normal distribution
        %         toEXP=max(toEXP,-709);%700
        %         toEXP=min(toEXP,709);
        %         LH=exp(toEXP);
        %         w=LH.*w;
        %         %%Normalize weights
        %         w=w/(w'*Lones);
        %Resampling (with resamp.m that I provided or using the pseudo code in Peter Jan ,... paper)
        [w,x,NRS] = resamp(w,x,0.1);
        Resamps = Resamps + NRS;
        %Update Particles
        %Note: This can be modified to implement the projected resampling as part of implementation of PROJ-PF:
        %Replace Sigchol*randn(N,L) with (alpha*Q_n*Q_n^T + (1-alpha)I)*Sigchol*randn(N,L)
        if (NRS==1)
            %Standard resampling
            x = x + mvnrnd(pzeros_physical,Q,L)'; %Sigchol*randn(N,L);
        end
        %END: At Observation times
    end
    
    %Predict, add noise at observation times
    %     x = proj*dp4(F,t,proj*x,h);
    x = V'*dp4(F,t,V*x,h);
    
    estimate(:,i+1) = x*w;
    
    diff_orig= truth(:,i) - (V*estimate(:,i));
    diff_proj= (V * V'* truth(:,i)) - (V*estimate(:,i));
    RMSE_orig = sqrt(diff_orig'*diff_orig/N)
    RMSE_proj = sqrt(diff_proj'*diff_proj/N)
    RMSEave_orig = RMSEave_orig + RMSE_orig;
    RMSEave_proj = RMSEave_proj + RMSE_proj;
    
    if mod(i,ObsMult)==0
        %Save RMSE values
        Time(iRMSE)=t;
        RMSEsave(iRMSE)=RMSE_orig;
        RMSEsave_proj(iRMSE)=RMSE_proj;
        iRMSE = iRMSE+1;
    end
    t = t+h;
end
figure(4)
plot(Time,RMSEsave,'.b');
hold on;
plot(Time,RMSEsave_proj,'.r')
legend('RMSE Original','RMSE Projected')
RMSEave_orig = RMSEave_orig/Numsteps
RMSEave_proj = RMSEave_proj/Numsteps
ResampPercent = ObsMult*Resamps/Numsteps

