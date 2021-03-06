clear; clc;
% used to create consistent interesting intitial conditions 
% (sets rng seed)
rng(1331);

%% Collect data on full lorenz96 model
dimension = 400;
[t,y] = ode45(@lorenz96,[0,10],rand(dimension,1));

X = y';
[U,S,V] = svd(X,'econ');

%% Find and plot singular values and importance
sig=diag(S);
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
Tol=0.5;
cdS =cumsum(sig.^2)./sum(sig.^2);% cumulative 
r = find(cdS>Tol, 1 ); 
figure(3)
plot(cdS,'ko','LineWidth',1.2),grid on
xlabel('k')
ylabel('Cumulative')

%% Truncate matrix
U_r = U(:,1:r);  S_r = S(1:r,1:r);  V_r = V(:,1:r)'; % Truncate U,S,V using the rank r
X_r = U_r*S_r*V_r; % Truncated matrix


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
% Let Q denote the first r columns of U and P = QQ^T. Let u' = F(u) denote 
% the Lorenz '96 system and consider the reduced order model v' = G(v)
% where v = Q^T u and G(v) = Q^T F(Q v). 
% Let w = Q v so that w = QQ^T u. 
% Note that the IC for v is v(0)=Q^T u(0). 
% Then compare the solution u to the original Lorenz '96 system with the 
% solution to the reduced order model (but comparing w = Q v with the 
% original variable u).

% u' = F(u) -> Pu' = PF(Pu), P=QQ^T -> Q^T u' = Q^T F(QQ^T u) and let v=Q^T u -> v' = Q^T F(Q v) = G(v) where G(v) = Q^TF(Q v)
% u' = F(u) + Noise (Physical Model). The idea with projected models is to replace the physical model with a projected model: v' = G(v) + P*Noise (Projected physical model in continuous time).
% In discrete time: u_{n+1} = F(u_n) + Noise -> Pu_{n+1} = PF(P u_n) + P*Noise and if P = Q Q^T, then Q^T u_{n+1} = Q^T F(Q Q^T u_n) + Q^T*Noise. Let v_n = Q^T u_n, so v_{n+1} = Q^T F(Q v_n) + Q^T*Noise
% Erik Van Vleck 5:38 PM
% u' = F(u) is Lorenz '96. Evolve from u(0) = e_1 Then evolve using P_r = Q_r Q_r^T, i.e., v_r' = G(v_r), v_r(0) = Q_r^T u(0) for r -> N=40 to see how the results compare. Plot w_r(t) = Q_r v_r(t)
%  Start with r=40. In this case u and w_r should basically agree. For smaller r we are losing information but hopefully not too badly.
% 


function 










