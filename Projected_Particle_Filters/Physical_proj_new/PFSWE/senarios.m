close all;clear all;clc;

%%
% a_1=load('SWEp_ 2 2_ 1_1.000000e-02_   1_1_5.mat');%senario=1
a_1=load('SWEp_ 1 1_ 1_1.000000e-02_   1_1_5.mat');%senario=1

b_1=a_1.results;
c_1=a_1.params;

% a_2=load('SWEp_ 2 2_ 1_1.000000e-02_   1_2_5.mat');%senario=2
a_2=load('SWEp_ 1 1_ 1_1.000000e-02_   1_2_5.mat');%senario=2

b_2=a_2.results;
c_2=a_2.params;

% a_3=load('SWEp_ 2 2_ 1_1.000000e-02_   1_3_5.mat');%senario=3
a_3=load('SWEp_ 1 1_ 1_1.000000e-02_   1_3_5.mat');%senario=3
b_3=a_3.results;
c_3=a_3.params;
%%
PhysicalProjection=c_1.PhysicalProjection;
DataProjection=c_1.DataProjection;
epsQ=c_1.epsQ;
epsR=c_1.epsR;
epsOmega_1=c_1.epsOmega;
iOPPF=c_1.iOPPF ;
numModes=c_1.numModes;
Num=c_1.Num;

%%
RMSEsave_1=b_1.RMSEsave;
RMSEsave_proj_1=b_1.RMSEsave_proj ;
XCsave_1=b_1.XCsave;
XCprojsave_1=b_1.XCsave_proj ;
ESSsave_1=b_1.ESSsave;
RSpercent_1=b_1.ResampPercent;
Time=b_1.Time;
epsOmega=c_1.epsOmega;
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
Mult=100/Num;
for j=1:Num
    numModes(j)=j*Mult;
    RMSEave_1(j) = mean(RMSEsave_1(:,j));
    RMSEave_proj_1(j) = mean(RMSEsave_proj_1(:,j));
    XCave_1(j) = mean(XCsave_1(:,j));
    XCave_proj_1(j) = mean(XCprojsave_1(:,j));
    ESSave_1(j)=mean(ESSsave_1(:,j));
    RSpercent_1(j)=RSpercent_1(:,j);
    RMSEave_2(j) = mean(RMSEsave_2(:,j));
    RMSEave_proj_2(j) = mean(RMSEsave_proj_2(:,j));
    XCave_2(j) = mean(XCsave_2(:,j));
    XCave_proj_2(j) = mean(XCprojsave_2(:,j));
    ESSave_2(j)=mean(ESSsave_2(:,j));
    RSpercent_2(j)=RSpercent_2(:,j);
    RMSEave_3(j) = mean(RMSEsave_3(:,j));
    RMSEave_proj_3(j) = mean(RMSEsave_proj_3(:,j));
    XCave_3(j) = mean(XCsave_3(:,j));
    XCave_proj_3(j) = mean(XCprojsave_3(:,j));
    ESSave_3(j)=mean(ESSsave_3(:,j));
    RSpercent_3(j)=RSpercent_3(:,j);
end
%%
% for j=1:Num
%     numModes(j)=j*Mult;
%     RMSEave_3(j) = mean(RMSEsave_3(:,j));
%     RMSEave_proj_3(j) = mean(RMSEsave_proj_3(:,j));
%     XCave_3(j) = mean(XCsave_3(:,j));
%     XCave_proj_3(j) = mean(XCprojsave_3(:,j));
%     ESSave_3(j)=mean(ESSsave_3(:,j));
%     RSpercent_3(j)=RSpercent_3(:,j);
% end
%%
TOLC=ptc12(12);
tt = tiledlayout(1,2);
ax(1) =nexttile;
ObsErr = linspace(sqrt(epsR),sqrt(epsR),Num);
plot(numModes,real(RMSEave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
grid on
hold on
plot(numModes,real(RMSEave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
plot(numModes,real(RMSEave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
plot(numModes,ObsErr,'k-.','LineWidth', 1.5)
xlim([min(numModes) max(numModes)/2])
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
legend('Scenario(i)','Scenario(ii)','Scenario(iii)',... %scenario
    'FontWeight','normal',...
    'FontSize',12,...
    'FontName','Times',...
    'Location','Best')
set(gca,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
 hold off
% plot(numModes,real(ESSave_1),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
% grid on
% hold on
% plot(numModes,real(ESSave_2),'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
% plot(numModes,real(ESSave_3),'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
% xlim([min(numModes) max(numModes)])
% % xlabel('Model Dimension',...
% %     'FontUnits','points',...
% %     'FontWeight','normal',...
% %     'FontSize',12,...
% %     'FontName','Times')
% 
% ylabel('Mean Effective Sample Size',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times')
% 
% title('Effective Sample Size',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times')
% set(gca,...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times')
% legend('Scenario(i)','Scenario(ii)','Scenario(iii)',... %scenario
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times',...
%     'Location','Best')
%  hold off
ax(2)=nexttile;
plot(numModes,RSpercent_1,'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
grid on
hold on
plot(numModes,RSpercent_2,'Color', TOLC(11,:),'LineStyle',':','LineWidth', 1.5)
plot(numModes,RSpercent_3,'Color', TOLC(4,:),'LineStyle','--','LineWidth', 1.5)
xlim([min(numModes) max(numModes)/2])
% xlabel('Model Dimension',...
%     'FontUnits','points',...
%     'FontWeight','normal',...
%     'FontSize',12,...
%     'FontName','Times')

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
legend('Scenario(i)','Scenario(ii)','Scenario(iii)',...
    'FontWeight','normal',...
    'FontSize',12,...
    'FontName','Times',...
    'Location','Best')
 hold off


sgtitle(['Covariances: $$Q = $$',num2str(epsQ), 'I, $$R = $$', num2str(epsR), 'I'],...
        'interpreter','latex',...
     'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Times')
han=axes(gcf,'visible','off'); 
han.XLabel.Visible='on';
xlabel(han,'Model Dimensions',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times');


%% Here you can save the file as eps format which is good with Latex
% print -depsc SWE_physical_proj_DMD%graph name
% print -depsc SWE_physical_proj_DMD_inth1000%graph name
% print -depsc SWE_physical_proj_DMDPOD_inth1000%graph name
% print -depsc SWE_data_proj_POD_inth1%graph name
%print -depsc SWE_data_proj_dmd_inth1%graph name
print -depsc scenarios%graph name