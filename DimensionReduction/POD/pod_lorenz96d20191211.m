clear; clc;
% used to create consistent interesting intitial conditions 
% (sets rng seed)


%% Collect data on full lorenz96 model



%% Find and plot singular values and importance

figure(1)
plot(sig,'ko','Linewidth',(1.5)),grid on
xlabel('k')
ylabel('Singular value, \sigma_k')
title('Standard plot of singular values')
 
figure(2)
semilogy(diag(S),'bo','LineWidth',1.5), grid on
xlabel('k')
ylabel('Semilogy of diag(S)')
hold off
title('log plot of singular values')

%% Find how many s values are needed to achieve tol% of the information

figure(3)
plot(cdS,'ko','LineWidth',1.2),grid on
xlabel('k')
ylabel('Cumulative')

%% Truncate matrix


%% Try to visualize the POD effect (difficult to do with 40 dimensions)

figure(4)
surfl(X(:,:));shading interp;
title ('X' )
figure(5)
surfl(X_r(:,:));shading interp;
title ('X_r' )
figure(6)
waterfall(X(:,:))
title ('X')
figure(7)
waterfall(X_r(:,:))
title ('X_r' )

%% We have a truncated matrix.  Now we'll create a reduced order model.
% Steps from Slack.
% Let Q denote the first r columns of U and P = QQ^T. 
% Let u' = F(u) denote the Lorenz '96 system and consider the reduced order 
% model v' = G(v) where v = Q^T u and G(v) = Q^T F(Q v). 
%
% Let w = Q v so that w = QQ^T u.
% Note that the IC for v is v(0)=Q^T u(0). 
% Then compare the solution u to the original Lorenz '96 system with the 
% solution to the reduced order model (but comparing w = Q v with the 
% original variable u).

rng(1331); % set a random number seed for consistent simulations.

dimension = 400;  % dimension of the Lorenz96 system.
lorenzinit = rand(dimension,1);  % initial conditions.
outputtimes = linspace(0,10,400);  % output times for the ode45 calls.
[t,y] = ode45(@lorenz96,outputtimes,lorenzinit);

tol = 0.9999; % This is the amount of information we keep in the SVD reduction.
lorenz96run = y';  % This is the output of the original model run.

[r, X_r, U_r, V_r, S_r] = orderreduction(tol, lorenz96run);

Q = U_r;            % Let Q denote the first r columns of U
P = Q*transpose(Q);  %  and P = QQ^T.
v = transpose(Q)*lorenz96run;    % v = Q^T u
w = Q*v;    % Let w = Q v so that w = QQ^T u.  This is an approximation
% of u where we've used the reduced basis to represent the data.

% We also createa a reduced order diff eq model,
% and run that.
% (Meaning, an ode45 call happens here with G(v)):
% the reduced order model is v' = G(v) where v = Q^T u and G(v) = Q^T F(Q v). 
% The IC for v is v(0)=Q^T u(0), so transpose(Q)*lorenzinit.
[t,yr] = ode45(@(t,v) reducedlorenz96(t,v,Q),outputtimes,transpose(Q)*lorenzinit);
reduced96 = yr';
wr = Q*reduced96;

%%
tollist = [0.9, 0.99, 0.999, 0.9999, 0.99999];

tol = 0.9999; % This is the amount of information we keep in the SVD reduction.
for k = 1:5
subplot(5,1,k)
tol = tollist(k);
[lorenz96run,w,wr] = comparereduction(tol);
hold off
plot(outputtimes,lorenz96run(1,:),'linewidth',2)
hold on
plot(outputtimes,w(1,:),'linewidth',2)
plot(outputtimes,wr(1,:),'linewidth',2)
xlabel('time')
ylabel('output')
legend({'model output','reduced output','reduced model'},'location','southeast')
title(['tolerance = ' num2str(tol)])
end
%%
% u' = F(u) -> Pu' = PF(Pu), P=QQ^T -> Q^T u' = Q^T F(QQ^T u) and let 
% v = Q^T u -> v' = Q^T F(Q v) = G(v) where G(v) = Q^TF(Q v)
% u' = F(u) + Noise (Physical Model). 
% The idea with projected models is to replace the physical model 
% with a projected model: v' = G(v) + P*Noise (Projected physical model in continuous time).
%
% In discrete time: u_{n+1} = F(u_n) + Noise -> Pu_{n+1} = PF(P u_n) + P*Noise 
% and if P = Q Q^T, then Q^T u_{n+1} = Q^T F(Q Q^T u_n) + Q^T*Noise. 
% Let v_n = Q^T u_n, so v_{n+1} = Q^T F(Q v_n) + Q^T*Noise
% u' = F(u) is Lorenz '96. Evolve from u(0) = e_1 Then evolve using P_r = Q_r Q_r^T, 
% i.e., v_r' = G(v_r), v_r(0) = Q_r^T u(0) for r -> N=40 to see how the results compare. 
% Plot w_r(t) = Q_r v_r(t)
% Start with r=40. In this case u and w_r should basically agree. 
% For smaller r we are losing information but hopefully not too badly.
% 

function dydt = reducedlorenz96(t, y, Q)
lorenz96out = lorenz96(t, Q*y);
dydt = transpose(Q)*lorenz96out;
end


function [truncationdim, Xr, Ur, Vr, Sr] = orderreduction(tol, modeloutput)
[U,S,V] = svd(modeloutput,'econ');
sig=diag(S);
cdS =cumsum(sig.^2)./sum(sig.^2);% cumulative 
r = find(cdS>tol, 1 ); 
truncationdim = r;
Ur = U(:,1:r);  
Sr = S(1:r,1:r);  
Vr = V(:,1:r)'; % Truncate U,S,V using the rank r
Xr = Ur*Sr*Vr; % Truncated matrix
end


function [lorenz96run,w,wr] = comparereduction(tol)
rng(1331); % set a random number seed for consistent simulations.

dimension = 400;  % dimension of the Lorenz96 system.
lorenzinit = rand(dimension,1);  % initial conditions.
outputtimes = linspace(0,10,400);  % output times for the ode45 calls.
[t,y] = ode45(@lorenz96,outputtimes,lorenzinit);

lorenz96run = y';  % This is the output of the original model run.

[r, X_r, U_r, V_r, S_r] = orderreduction(tol, lorenz96run);

Q = U_r;            % Let Q denote the first r columns of U
P = Q*transpose(Q);  %  and P = QQ^T.
v = transpose(Q)*lorenz96run;    % v = Q^T u
w = Q*v;    % Let w = Q v so that w = QQ^T u.  This is an approximation
% of u where we've used the reduced basis to represent the data.

% We also createa a reduced order diff eq model,
% and run that.
% (Meaning, an ode45 call happens here with G(v)):
% the reduced order model is v' = G(v) where v = Q^T u and G(v) = Q^T F(Q v). 
% The IC for v is v(0)=Q^T u(0), so transpose(Q)*lorenzinit.
[t,yr] = ode45(@(t,v) reducedlorenz96(t,v,Q),outputtimes,transpose(Q)*lorenzinit);
reduced96 = yr';
wr = Q*reduced96;
end







