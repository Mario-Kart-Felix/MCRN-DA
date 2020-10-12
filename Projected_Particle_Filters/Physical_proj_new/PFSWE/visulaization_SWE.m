close all; clear all;clc;
% a=load('SWE_ 1 1_   1_1.000000e-02_   1.mat');
% a= load('SWE_ 2 1_1.000000e-01_1.000000e-01_1000.mat');
% a=load('SWE_ 2 1_1.000000e-02_1.000000e-02_   1.mat');
% a=load('SWE_ 2 2_   1_1.000000e-01_1000.mat');
% a=load('SWE_ 2 2_   1_1.000000e-02_   1.mat');
a=load('SWEdata_ 2 2_   1_1.000000e-02_   1.mat');
b=a.results;
c=a.params;
%%
PhysicalProjection=c.PhysicalProjection;
DataProjection=c.DataProjection;
epsQ=c.epsQ;
epsR=c.epsR;
iOPPF=c.iOPPF ;
numModes=c.numModes;
Num=c.Num;
%%
RMSEsave=b.RMSEsave;
RMSEsave_proj=b.RMSEsave_proj ;
XCsave=b.XCsave;
XCprojsave=b.XCsave_proj ;
ESSsave=b.ESSsave;
RSpercent=b.ResampPercent;
Time=b.Time;
%%
Mult=10/Num;
for j=1:Num
    numModes(j)=j*Mult;
    RMSEave(j) = mean(RMSEsave(:,j));
    RMSEave_proj(j) = mean(RMSEsave_proj(:,j));
    XCave(j) = mean(XCsave(:,j));
    XCave_proj(j) = mean(XCprojsave(:,j));
    ESSave(j)=mean(ESSsave(:,j));
    RSpercent(j)=RSpercent(:,j);
end
TOLC=ptc12(9);
tt = tiledlayout(1,4);
ObsErr = linspace(sqrt(epsR),sqrt(epsR),Num);
nexttile
plot(numModes,RMSEave,'Color', TOLC(1,:),'LineStyle','--','LineWidth', 1.5)
hold on
plot(numModes,RMSEave_proj,'Color', TOLC(7,:),'LineStyle',':','Marker','x','LineWidth', 1.5)
plot(numModes,ObsErr,'k-.','LineWidth', 1.5)
grid on
legend('Model Space','Projected Space','Observation Error',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times',...
    'Location','Best')
xlabel('Model Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
ylabel('Mean RMSE',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

title('Mean RMSE',...
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

nexttile
plot(numModes,real(XCave),'Color', TOLC(1,:),'LineStyle','-','LineWidth', 1.5)
hold on
plot(numModes, real(XCave_proj),'Color', TOLC(7,:),'LineStyle',':','Marker','x','LineWidth', 1.5)
grid on
legend('Model Space','Projected Space',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times',...
    'Location','Best')

xlabel('Model Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')
ylabel('Mean Pattern Correlations ',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

title('Mean Correlation Coeff',...
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


nexttile
plot(numModes,real(ESSave),'Color', TOLC(4,:),'LineStyle','-','LineWidth', 1.5)
grid on
xlabel('Model Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

ylabel('Mean Effective Sample Size',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

title('Mean Effective Sample Size',...
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

nexttile
plot(numModes,RSpercent,'Color', TOLC(4,:),'LineWidth', 1.5)
grid on
xlabel('Model Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

ylabel('Resampling Percent',...
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

sgtitle(['Covariances: Q = ',num2str(epsQ), 'I, R = ', num2str(epsR), 'I'],...
    'interpreter','latex',...
    'FontSize',14,...
    'FontName','Times')

tt.TileSpacing = 'compact';
tt.Padding = 'compact';
%%
epsOmega =0.0000001;
tt = tiledlayout(1,2);

nexttile
plot(numModes,real(ESSave),'Color', TOLC(4,:),'LineStyle','-','LineWidth', 1.5)
grid on
xlabel('Data Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

ylabel('Mean Effective Sample Size',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

title('Mean Effective Sample Size',...
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

nexttile
plot(numModes,RSpercent,'Color', TOLC(4,:),'LineWidth', 1.5)
grid on
xlabel('Data Dimension',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',14,...
    'FontName','Times')

ylabel('Resampling Percent',...
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

sgtitle(['Covariances: Q = ',num2str(epsQ), 'I, R = ', num2str(epsR), 'I, $\omega$ =', num2str(epsOmega), 'I'],...
    'interpreter','latex',...
    'FontSize',14,...
    'FontName','Times')

% tt.TileSpacing = 'compact';
% tt.Padding = 'compact';

%% Here you can save the file as eps format which is good with Latex
% print -depsc SWE_physical_proj_DMD%graph name
% print -depsc SWE_physical_proj_DMD_inth1000%graph name
% print -depsc SWE_physical_proj_DMDPOD_inth1000%graph name
% print -depsc SWE_data_proj_POD_inth1%graph name
print -depsc SWE_data_proj_dmd_inth1%graph name
