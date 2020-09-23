clear all;close all;clc
% load('SWE.mat')
load('SWE_run_4days.mat');
modeloutput= x_save;
[U,S,V] = svd(modeloutput,'econ');
N =size(modeloutput,1);
sig=diag(S);
%%
% figure(1)
% plot(sig,'ko','Linewidth',(1.5)),grid on
% xlabel('k','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
% ylabel('Singular Values', 'fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
%  set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
% % title('Standard plot of singular values')
TOLC=ptc12(9,'check');
figure(2)
semilogy(sig(1:800),'-ok','LineWidth',1.5), grid on, hold on
xlabel('k','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
ylabel('Singular Values','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
txt = ' $\longrightarrow r =10$' ;
txt_1 = ' $\longrightarrow  r = 30$';
txt_2 =(  ' $\longrightarrow  r = 300$');
txt_3 =(  ' $\longrightarrow  r = 750$');
plot(10, sig(10),'o','Color', TOLC(4,:),'LineWidth',1.5)
plot(30, sig(30),'o','Color', TOLC(4,:),'LineWidth',1.5)
plot(300, sig(300),'o','Color', TOLC(4,:),'LineWidth',1.5)
plot(750, sig(750),'o','Color', TOLC(4,:),'LineWidth',1.5)
h=text(10,sig(10),txt);
h_1=text(30,sig(30),txt_1);
h_2=text(300,sig(300),txt_2);
h_3=text(750,sig(750),txt_3);
set([h,h_1,h_2,h_3], 'Color', TOLC(4,:),'interpreter','latex','fontsize',11,'FontName', 'Times New Roman','fontweight','bold')
ylim([1.000000000000000e-16, 10^09]);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
hold off
% 
% figure(3)
% semilogy(sig,'-ok','LineWidth',1.5), grid on
% xlabel('k','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
% ylabel('Singular Values','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
% %  title('log plot of singular values')
%% 
cdS =cumsum((sig.^2)./sum(sig.^2));% cumulative 
figure(4)
semilogy(1-cdS,'ko','LineWidth',1),grid on
txt = (' Error=$$\sqrt{\sum_{k=R+1}^{K} \sigma_{k}^{2}}$$') ;
h_1=text(150,1,txt);
set(h_1, 'Color', TOLC(4,:),'interpreter','latex','fontsize',11,'FontName', 'Times New Roman','fontweight','bold')
xlabel('k','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
ylabel('Error','fontsize',14,'interpreter','latex','FontName', 'Times New Roman','fontweight','bold')
ylim([1.000000000000000e-16, 10^09]);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
% r=30;
% Ur = U(:,1:r);
% Sr = S(1:r,1:r);
% Vr = V(:,1:r)'; % Truncate U,S,V using the rank r
% Xr = Ur*Sr*Vr; % Truncated matrix
% modeloutput_truncated=Xr;
% % % % save('SWE_POD_r20.mat','modeloutput_truncated','x','y','H','dt','t_save')
% save('SWE_POD_r30_new.mat','modeloutput_truncated','x','y','H','dt','t_save')