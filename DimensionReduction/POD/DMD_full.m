clc;clear all;close all;
load('rotor_oscillator_vf.mat')
whos
%The data have:
%Ux-Horizontal velocity components
%Uy-Vertical velocity components
%x-dim,y-dim for each dt-time step and t is the time
%% Build a matrix such that time x-dir and space y-dir 
L=length(t);%number of snapshots
m=length(y);%x-dimension
n=length(x);%y-dimension
N_gridpoints=m*n;%each snapshot has x*y-dimensions
Ux_reshaped = reshape( Ux, [], L);
Uy_reshaped = reshape( Uy, [], L);
X=[Ux_reshaped;Uy_reshaped];
 
%% DMD method
X1 = X(:,1:end-1);%The data matrix
X2 = X(:,2:end); %shifted data matrix

%% Step1:SVD to the data matrix
[U,S,V] = svd(X1, 'econ');
%% Step2:%% Matrix Truncation
r=20;%number of singular values that we will use
U_r=U(:,1:r);S_r=S(1:r,1:r);V_r=(V(:,1:r));%trancated matrices

Atilde = U_r'*X2*V_r*pinv(S_r);

%% Step 3:DMD mode
[W,D] = eig(Atilde);
lambda= diag(D); 
Phi = X2*V_r*pinv(S_r)*W;%DMD mode
omega = log(lambda)/(dt);%eigenvalue of the solution

%%
x1=X1(:,1);%the sloution at  t=0
b=Phi\x1;%how much time to project
%Time dynamic
time_dynamics=zeros(r,length(t));
for iter = 1:length(t)
time_dynamics(:,iter) =(b.*exp(omega*t(iter)));%make full matrix space and time fot updating t
end
X_dmd = Phi*time_dynamics;
%% Step3: Regenarate the horizontal and vertical velocity components
Uxr=X_dmd(1:N_gridpoints,:);
Uyr=X_dmd(N_gridpoints+1:end,:);

Uxr_H=reshape(Uxr,m,n,L);%Horizontal velocity truncated
Uyr_V=reshape(Uyr,m,n,L);%Vertical velocity truncated


