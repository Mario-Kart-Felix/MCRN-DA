close all;clear all;clc;
%% POD Physical and data Q=1e-1 R=1e-2
% a_1=load('SWEp_ 1 1_1.000000e-01_1.000000e-02_   1_2_5.mat');%inth=1
% a_2=load('SWEp_ 1 1_1.000000e-01_1.000000e-02_  10_2_5.mat');%inth=10
% a_3=load('SWEp_ 1 1_1.000000e-01_1.000000e-02_ 100_2_5.mat');%inth=100
% a_4=load('SWEp_ 1 1_1.000000e-01_1.000000e-02_1000_2_5.mat');  %inth=1000
%% POD Physical and data Q=1 R=1e-2
% a_1= load('SWEp_ 1 1_ 1_1.000000e-02_   1_1_5.mat');%inth=1
% a_2=load('SWEp_ 1 1_ 1_1.000000e-02_  10_2_5.mat');%inth=10
% a_3=load('SWEp_ 1 1_ 1_1.000000e-02_ 100_2_5.mat');%inth=100
% a_4=load('SWEp_ 1 1_ 1_1.000000e-02_1000_2_5.mat');  %inth=1000
%% DMD Physical and data Q=1 R=1e-2
a_1=load('SWEp_ 2 2_ 1_1.000000e-02_   1_2_5.mat');%inth=1
a_2=load('SWEp_ 2 2_ 1_1.000000e-02_  10_2_5.mat');%inth=10
a_3=load( 'SWEp_ 2 2_ 1_1.000000e-02_ 100_2_5.mat');%inth=100
a_4=load('SWEp_ 2 2_ 1_1.000000e-02_1000_2_5.mat');  %inth=1000
%% DMD Physical and data Q=1E-1 R=1e-2
% a_1= load('SWEp_ 2 2_1.000000e-01_1.000000e-02_   1_2_5.mat');%inth=1
% a_2=load('SWEp_ 2 2_1.000000e-01_1.000000e-02_  10_2_5.mat');%inth=10
% a_3=load('SWEp_ 2 2_1.000000e-01_1.000000e-02_ 100_2_5.mat');%inth=100
% a_4=load('SWEp_ 2 2_1.000000e-01_1.000000e-02_1000_2_5.mat');  %inth=1000
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
b_4=a_4.results;
c_4=a_4.params;
%%
PhysicalProjection=c_1.PhysicalProjection;
DataProjection=c_1.DataProjection;
epsQ=c_1.epsQ;
epsR=c_1.epsR;
numModes=c_1.numModes;
Num=c_1.Num;
Mult=c_4.Mult;
%%
RMSEsave_1=b_1.RMSEsave;
RSpercent_1=b_1.ResampPercent;
Time=b_1.Time;
%%
RMSEsave_2=b_2.RMSEsave;
RSpercent_2=b_2.ResampPercent;
%%
RMSEsave_3=b_3.RMSEsave;
RSpercent_3=b_3.ResampPercent;
%%
RMSEsave_4=b_4.RMSEsave;
RSpercent_4=b_4.ResampPercent;
%%
RSpercent_1 = mean(squeeze(RSpercent_1),[2]);

for j=1:Num
    numModes(j)=j*Mult;
    RMSEave_1(j) = mean(RMSEsave_1(:,j,:), [1 3]); %time, trails, 
%     RSpercent_1(j)=mean(squeeze(RSpercent_1(:,j,:)),[2]);
%     RMSEave_2(j) = mean(RMSEsave_2(:,j,:), [1 3]);
%     RSpercent_2(j)=mean(RSpercent_2(:,j,:),[3]);
%     RMSEave_3(j) = mean(RMSEsave_3(:,j,:), [1 3]);
%     RSpercent_3(j)=mean(RSpercent_3(:,j,:),[3]);
%     RMSEave_4(j) = mean(RMSEsave_4(:,j,:), [1 3]);
%     RSpercent_4(j)=mean(RSpercent_4(:,j,:),[3]);
end
TOLC=ptc12(12);
figure(1)
tt = tiledlayout(1,2);
% tt=tiledlayout('flow');
ObsErr = linspace(sqrt(epsR),sqrt(epsR),Num);
nexttile
plot(numModes,real(RMSEave_1),'Color', TOLC(9,:),'LineStyle','-.','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(RMSEave_2),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% plot(numModes,real(RMSEave_3),'Color', TOLC(4,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(RMSEave_4),'Color', TOLC(2,:),'LineStyle','--','LineWidth', 1.5)
% plot(numModes,ObsErr,'k-.','LineWidth', 1.5)
% legend('01','10','100','1000','ObsErr',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
% plot( 1:10, rand(10, 4) )
h = legend({'100%','10%', '1%', '0.1%'});
title(h, 'Grid nodes used')
yline(0.1, '--', 'Obs.Error','HandleVisibility','off');
xlabel('Model Dimensions',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',12,...
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
% xlim([min(numModes)+5 max(numModes)])
% magnifyOnFigure(fig);
hold off

%%
nexttile
plot(numModes,RSpercent_1,'Color', TOLC(9,:),'LineStyle','-.','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,RSpercent_2,'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% plot(numModes,RSpercent_3,'Color', TOLC(4,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,RSpercent_4,'Color', TOLC(2,:),'LineStyle','--','LineWidth', 1.5)
% xlim([min(numModes)+5 max(numModes)])
% h = legend({'100%','10%', '1%', '0.1%'});
% title(h, 'Grid nodes used')
% yline(0.1, '--', 'ObsErr','HandleVisibility','off');
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
sgtitle(['Covariances: $Q = $',num2str(epsQ), '$I$, $R = $', num2str(epsR), '$I$'],...
    'interpreter','latex',...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Times')
tt.TileSpacing = 'compact';
tt.Padding = 'compact';

%% Here you can save the file as eps format which is good with Latex
% print -depsc l968podQ1R1e-2%graph name

% %%b_1=a_1.results;
% c_1=a_1.params;
% %%
% b_2=a_2.results;
% c_2=a_2.params;
% %%
% b_3=a_3.results;
% c_3=a_3.params;
% %%
% aa=a_0.results;
% %%
% PhysicalProjection=c_1.PhysicalProjection;
% DataProjection=c_1.DataProjection;
% epsQ=c_1.epsQ;
% epsR=c_1.epsR;
% iOPPF=c_1.iOPPF ;
% numModes=c_1.numModes;
% Num=c_1.Num;
% %%
% RMSEsave_1=b_1.RMSEsave;
% RMSEsave_proj_1=b_1.RMSEsave_proj ;
% XCsave_1=b_1.XCsave;
% XCprojsave_1=b_1.XCsave_proj ;
% ESSsave_1=b_1.ESSsave;
% RSpercent_1=b_1.ResampPercent;
% Time=b_1.Time;
% %%
% RMSEsave_2=b_2.RMSEsave;
% RMSEsave_proj_2=b_2.RMSEsave_proj ;
% XCsave_2=b_2.XCsave;
% XCprojsave_2=b_2.XCsave_proj ;
% ESSsave_2=b_2.ESSsave;
% RSpercent_2=b_2.ResampPercent;
% %%
% RMSEsave_3=b_3.RMSEsave;
% RMSEsave_proj_3=b_3.RMSEsave_proj ;
% XCsave_3=b_3.XCsave;
% XCprojsave_3=b_3.XCsave_proj ;
% ESSsave_3=b_3.ESSsave;
% RSpercent_3=b_3.ResampPercent;
% %% 
% RMSEsave_01=aa.RMSEsave;
% RMSEsave_proj_01=aa.RMSEsave_proj ;
% XCsave_01=aa.XCsave;
% XCprojsave_01=aa.XCsave_proj ;
% ESSsave_01=aa.ESSsave;
% RSpercent_01=aa.ResampPercent;
% 
% %%
% Mult=100/Num;
% for j=1:Num
%     numModes(j)=j*Mult;
%     RMSEave_1(j) = mean(RMSEsave_1(:,j));
%     RMSEave_proj_1(j) = mean(RMSEsave_proj_1(:,j));
%     XCave_1(j) = mean(XCsave_1(:,j));
%     XCave_proj_1(j) = mean(XCprojsave_1(:,j));
%     ESSave_1(j)=mean(ESSsave_1(:,j));
%     RSpercent_1(j)=RSpercent_1(:,j);
% end
% %%
% for j=1:Num
%     numModes(j)=j*Mult;
%     RMSEave_2(j) = mean(RMSEsave_2(:,j));
%     RMSEave_proj_2(j) = mean(RMSEsave_proj_2(:,j));
%     XCave_2(j) = mean(XCsave_2(:,j));
%     XCave_proj_2(j) = mean(XCprojsave_2(:,j));
%     ESSave_2(j)=mean(ESSsave_2(:,j));
%     RSpercent_2(j)=RSpercent_2(:,j);
% end
% %%
% for j=1:Num
%     numModes(j)=j*Mult;
%     RMSEave_3(j) = mean(RMSEsave_3(:,j));
%     RMSEave_proj_3(j) = mean(RMSEsave_proj_3(:,j));
%     XCave_3(j) = mean(XCsave_3(:,j));
%     XCave_proj_3(j) = mean(XCprojsave_3(:,j));
%     ESSave_3(j)=mean(ESSsave_3(:,j));
%     RSpercent_3(j)=RSpercent_3(:,j);
% end
% %%
% for j=1:Num
%     numModes(j)=j*Mult;
%     RMSEave_01(j) = mean(RMSEsave_01(:,j));
%     RMSEave_proj_01(j) = mean(RMSEsave_proj_01(:,j));
%     XCave_01(j) = mean(XCsave_01(:,j));
%     XCave_proj_01(j) = mean(XCprojsave_01(:,j));
%     ESSave_01(j)=mean(ESSsave_01(:,j));
%     RSpercent_01(j)=RSpercent_01(:,j);
% end
% %% 
% nexttile
% plot(numModes,real(ESSave_01),'Color', TOLC(9,:),'LineStyle','-.','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(ESSave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% plot(numModes,real(ESSave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(ESSave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
% legend('01','10','100','1000',...
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
% xlim([min(numModes) max(numModes)])
% 
% set(gca,...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',14,...
%     'FontName','Times')
% 
% %%
% nexttile
% plot(numModes,real(XCave_01),'Color', TOLC(9,:),'LineStyle','-.','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(XCave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% plot(numModes,real(XCave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(XCave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
% legend('01','10','100','1000',...
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
% xlim([min(numModes) max(numModes)])
% hold off