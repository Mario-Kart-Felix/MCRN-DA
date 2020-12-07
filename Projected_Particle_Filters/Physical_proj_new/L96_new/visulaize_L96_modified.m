close all;clear all;clc;

% % Q=1e-2,Q=1e-1,Q=1, POD, N=1000, F=8
% a_1=load('L968p_ 1 1_1.000000e-02_1.000000e-02_1000.mat');%Q=1e-2
% a_2=load('L968p_ 1 1_1.000000e-01_1.000000e-02_1000.mat');%Q=1e-1
% a_3=load('L968p_ 1 1_ 1_1.000000e-02_1000.mat');%Q=1

% %% Q=1e-2,Q=1e-1,Q=1, POD, N=100, F=3.5
% a_1= load('L963.5p_ 1 1_1.000000e-02_1.000000e-02_ 100.mat');%Q=1e-2
% a_2= load('L963.5p_ 1 1_1.000000e-01_1.000000e-02_ 100.mat');%Q=1e-1
% a_3=load( 'L963.5p_ 1 1_ 1_1.000000e-02_ 100.mat');%Q=1

% %% Q=1e-2,Q=1e-1,Q=1, POD, N=200, F=3.5
% a_1= load('L963.5p_ 1 1_1.000000e-02_1.000000e-02_ 200.mat');%Q=1e-2
% a_2= load('L963.5p_ 1 1_1.000000e-01_1.000000e-02_ 200.mat');%Q=1e-1
% a_3= load('L963.5p_ 1 1_ 1_1.000000e-02_ 200.mat');%Q=1
%  'L963.5p_ 1 1_1.000000e-02_1.000000e-02_ 300.mat'
%  'L963.5p_ 1 1_1.000000e-01_1.000000e-02_ 300.mat'
%  'L963.5p_ 1 1_ 1_1.000000e-02_ 300.mat
 %% Q=1, POD, N=400, F=4, F=6, F=8
  a_1= load('L964p_ 1 1_ 1_1.000000e-02_ 400.mat');
  a_2= load('L966p_ 1 1_ 1_1.000000e-02_ 400.mat');
  a_3= load('L966p_ 1 1_ 1_1.000000e-02_ 400.mat');
%%
b_1=a_1.results;
c_1=a_1.params;
%%
b_2=a_2.results;
c_2=a_2.params;
%%
b_3=a_3.results;
c_3=a_3.params;
%%
PhysicalProjection=c_1.PhysicalProjection;
DataProjection=c_1.DataProjection;
epsQ=c_1.epsQ;
epsR=c_1.epsR;
numModes=c_1.numModes;
Num=c_1.Num;
Mult=c_1.Mult;
%%
RMSEsave_1=b_1.RMSEsave;
RMSEsave_proj_1=b_1.RMSEsave_proj ;
XCsave_1=b_1.XCsave;
XCprojsave_1=b_1.XCsave_proj ;
ESSsave_1=b_1.ESSsave;
RSpercent_1=b_1.ResampPercent;
Time=b_1.Time;
%%
RMSEsave_2=b_2.RMSEsave;
RMSEsave_proj_2=b_2.RMSEsave_proj ;
XCsave_2=b_2.XCsave;
XCprojsave_2=b_2.XCsave_proj ;
ESSsave_2=b_2.ESSsave;
RSpercent_2=b_2.ResampPercent;
%%
RMSEsave_3=b_3.RMSEsave;
RMSEsave_proj_3=b_3.RMSEsave_proj ;
XCsave_3=b_3.XCsave;
XCprojsave_3=b_3.XCsave_proj ;
ESSsave_3=b_3.ESSsave;
RSpercent_3=b_3.ResampPercent;
%%
% Mult=200/Num;
for j=1:Num
    numModes(j)=j*Mult;
    RMSEave_1(j) = mean(RMSEsave_1(:,j));
    RMSEave_proj_1(j) = mean(RMSEsave_proj_1(:,j));
    XCave_1(j) = mean(XCsave_1(:,j));
    XCave_proj_1(j) = mean(XCprojsave_1(:,j));
    ESSave_1(j)=mean(ESSsave_1(:,j));
    RSpercent_1(j)=RSpercent_1(:,j);
end
%%
for j=1:Num
    numModes(j)=j*Mult;
    RMSEave_2(j) = mean(RMSEsave_2(:,j));
    RMSEave_proj_2(j) = mean(RMSEsave_proj_2(:,j));
    XCave_2(j) = mean(XCsave_2(:,j));
    XCave_proj_2(j) = mean(XCprojsave_2(:,j));
    ESSave_2(j)=mean(ESSsave_2(:,j));
    RSpercent_2(j)=RSpercent_2(:,j);
end
%%
for j=1:Num
    numModes(j)=j*Mult;
    RMSEave_3(j) = mean(RMSEsave_3(:,j));
    RMSEave_proj_3(j) = mean(RMSEsave_proj_3(:,j));
    XCave_3(j) = mean(XCsave_3(:,j));
    XCave_proj_3(j) = mean(XCprojsave_3(:,j));
    ESSave_3(j)=mean(ESSsave_3(:,j));
    RSpercent_3(j)=RSpercent_3(:,j);
end
%%
TOLC=ptc12(12);
figure(1)
tt = tiledlayout(1,2);
ObsErr = linspace(sqrt(epsR),sqrt(epsR),Num);
nexttile
plot(numModes,real(RMSEave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
grid on
hold on
plot(numModes,real(RMSEave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
plot(numModes,real(RMSEave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
plot(numModes,ObsErr,'k-.','LineWidth', 1.5)
% legend('$Q = 1e-2$','$Q = 1e-1$','$Q = 1$',...
%     'interpreter','latex',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% 
legend('F=4','F=6','F=8',...
    'FontWeight','normal',...
    'FontSize',12,...
    'FontName','Times',...
    'Location','Best')
xlabel('Model Dimensions',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
ylabel('Mean RMSE',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

title('RMSE',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
set(gca,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
xlim([min(numModes) max(numModes)])
set(gca,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
hold off
% %% 
% nexttile
% plot(numModes,real(ESSave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(ESSave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(ESSave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
% % 
% % legend('L=05','L=10','L=20',...
% %     'FontWeight','normal',...
% %     'FontSize',12,...
% %     'FontName','Times',...
% %     'Location','Best')
% % legend('Scenario(i)','Scenario(ii)','Scenario(iii)',...
% %     'FontWeight','normal',...
% %     'FontSize',12,...
% %     'FontName','Times',...
% %     'Location','Best')
% legend('01','10','100',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% xlabel('Model Dimensions',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% ylabel('Mean Effective Sample Size',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% 
% title('Effective Sample Size',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% 
% xlim([min(numModes) max(numModes)/2])
% 
% set(gca,...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')

%%
% nexttile
% plot(numModes,real(XCave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(XCave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(XCave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
% legend('5','10','100',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% xlabel('Model Dimensions',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% ylabel('Mean Pattern Correlations ',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% 
% title('Pattern Correlations',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% set(gca,...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% xlim([min(numModes) max(numModes)/2])
% hold off
%%
nexttile
plot(numModes,RSpercent_1,'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
grid on
hold on
plot(numModes,RSpercent_2,'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
plot(numModes,RSpercent_3,'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
xlim([min(numModes) max(numModes)])
% legend('L=05','L=10','L=20',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% legend('Scenario(i)','Scenario(ii)','Scenario(iii)',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% legend('$Q = 1e-2$','$Q = 1e-1$','$Q = 1$',...
%     'interpreter','latex',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
legend('F=4','F=6','F=8',...
    'FontWeight','normal',...
    'FontSize',12,...
    'FontName','Times',...
    'Location','Best')
xlabel('Model Dimensions',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

ylabel('Mean Resampling Percent',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
title('Resampling Percent',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
set(gca,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
hold off
sgtitle(['Covariances: $Q = $',num2str(epsQ), 'I, $R = $', num2str(epsR), 'I'],...
    'interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Times')
% tt.TileSpacing = 'compact';
% tt.Padding = 'compact';

%% Here you can save the file as eps format which is good with Latex
% print -depsc l968podQ1R1e-2%graph name