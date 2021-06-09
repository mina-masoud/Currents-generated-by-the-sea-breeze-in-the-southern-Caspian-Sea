
%% Image of daily cycle of Alongshore and Cross-shore Current velocity 

%Mina Masoud, 2020
%%


addpath /ocean/rich/home/matlab/m_map 

gg=7;
% Ts=[(uc_2m)*0 (uc_2m)*0 (uc_2m) (uc_3m) (uc_4m) ...
%     (uc_5m) (uc_6m) (uc_7m)...
%     (uc_8m) (uc_9m) (uc_10m) ];      
% depth=[0 1 2 3 4 5 6 7 8 9 10];
% days = datenum(tc);
% imagesc(days,depth',Ts');
% ccu=max(max(Ts(:)));
% ccu=max(max(Ts(5000:5400,:)));
% clu=linspace(-ccu,ccu,10);
% 
% contourf(days(5000:5200),depth,Ts(5000:5200,:)',clu)
% caxis([-ccu ccu]);
% 
% colormap(m_colmap('div'));
% 
% t=colorbar;
% t.Label.String = 'uc [m~s$^{-1}$] ';
% t.FontSize=12;t.Label.Interpreter='latex';t.TickLabelInterpreter='laTeX';
% 
% XLable=xlabel('Time','Interpreter','latex')
% YLable=ylabel('Depth from bed','Interpreter','latex')
% 
% set(gca,'ytick');set(gca,'FontSize',12);set(gca, 'TickLabelInterpreter', 'LaTeX');
% set(gca,'xtick');set(gca,'FontSize',12);set(gca, 'TickLabelInterpreter', 'LaTeX');
% set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
%    'YMinorTick', 'off','XMinorTick', 'off','XGrid', 'off','YGrid', 'off');
% axdate
% 
% text(0.02,0.98,'amir','FontSize',16,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');


%%
subplot(10,2,gg+1)
figure(2)
di_Ts=[ nanmean(di_bp_uc_2m(:,1:end),2)*NaN nanmean(di_bp_uc_2m(:,1:end),2)*NaN ...
     nanmean(di_bp_uc_2m(:,1:end),2)...
     nanmean(di_bp_uc_3m(:,1:end),2)...
     nanmean(di_bp_uc_4m(:,1:end),2) nanmean(di_bp_uc_5m(:,1:end),2)...
     nanmean(di_bp_uc_6m(:,1:end),2) nanmean(di_bp_uc_7m(:,1:end),2) ...
     nanmean(di_bp_uc_8m(:,1:end),2) nanmean(di_bp_uc_8m(:,1:end),2)*NaN ...
     nanmean(di_bp_uc_8m(:,1:end),2)*NaN];% ...
     %nanmean(di_bp_uc_8m(:,1:end),2)*NaN nanmean(di_bp_uc_8m(:,1:end),2)*NaN];

% di_Ts2=[ nanmean(di_bp_uc_9m(:,1:end),2)...
%     nanmean(di_bp_uc_10m(:,1:end),2) nanmean(di_bp_uc_10m(:,1:end),2)*NaN];

depth=[0 1 2 3 4 5 6 7 8 9 10];% 11 12 13.7];% 10.5];
% depth2=[ 9 10 13.7];

di_ccu=max(max(di_Ts(:)));
di_clu=linspace(-di_ccu,di_ccu,15);

% di_ccu2=max(max(di_Ts2(:)));
% di_clu2=linspace(-di_ccu2,di_ccu2,10);
[CS,CH]=contourf([0:24]',depth,di_Ts',di_clu)
%caxis([-di_ccu di_ccu]);
caxis([-0.01 0.01]);
axb=m_contfbar(1.05,[.01 1],(CS),CH);
axb.YLabel.String='uc [m~s$^{-1}$]';
axb.YLabel.Interpreter='latex';
%axb.YTick=CH;
colormap(m_colmap('div'));


% XLable=xlabel('Hours','Interpreter','latex')
 YLable=ylabel('[m]','Interpreter','latex')
% 
set(gca,'ytick');set(gca,'FontSize',8);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'xtick');set(gca,'FontSize',8);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
   'YMinorTick', 'off','XMinorTick', 'off','XGrid', 'off','YGrid', 'off');

%text(0.02,0.98,'e-AmirAbad','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');


%%

% Tsv=[fixgaps(bp_vc_2m) fixgaps(bp_vc_3m) fixgaps(bp_vc_4m) ...
%     fixgaps(bp_vc_5m) fixgaps(bp_vc_6m) fixgaps(bp_vc_7m)...
%     fixgaps(bp_vc_8m) ];      
% depth=[2 3 4 5 6 7 8];
% days = datenum(tc);
% %imagesc(days,depth,Tsv');
% ccv=max(max(Tsv(5000:5400,:)));
% clv=linspace(-ccv,ccv,10);
% 
% %contourf(days(5000:5200),depth,Tsv(5000:5200,:)',clv)
% caxis([-ccv ccv]);
% 
% colormap(m_colmap('div'));

subplot(10,2,gg)
figure(2)

di_Tsv=[nanmean(di_bp_vc_2m(:,1:end),2)*NaN nanmean(di_bp_vc_2m(:,1:end),2)*NaN ...
    nanmean(di_bp_vc_2m(:,1:end),2) ...
    nanmean(di_bp_vc_3m(:,1:end),2)...
    nanmean(di_bp_vc_4m(:,1:end),2) nanmean(di_bp_vc_5m(:,1:end),2)...
    nanmean(di_bp_vc_6m(:,1:end),2) nanmean(di_bp_vc_7m(:,1:end),2) ...
    nanmean(di_bp_vc_8m(:,1:end),2) nanmean(di_bp_vc_8m(:,1:end),2)*NaN ...
    nanmean(di_bp_vc_8m(:,1:end),2)*NaN];% ...
    %nanmean(di_bp_vc_8m(:,1:end),2)*NaN nanmean(di_bp_vc_8m(:,1:end),2)*NaN];% nanmean(di_bp_vc_8m(:,1:end),2)*NaN];

    % di_Tsv2=[nanmean(di_bp_vc_9m(:,1:end),2) ...
%     nanmean(di_bp_vc_10m(:,1:end),2) nanmean(di_bp_vc_10m(:,1:end),2)*0  ];

depth=[0 1 2 3 4 5 6 7 8 9 10];% 11 12 13.7];% 10.5];
% depth2=[9 10 13.7];

di_ccv=max(max(di_Tsv(:)));
di_clv=linspace(-di_ccv,di_ccv,10);

% di_ccv2=max(max(di_Tsv2(:)));
% di_clv2=linspace(-di_ccv2,di_ccv2,8);

hold on
% di_clu2=linspace(-di_ccu2,di_ccu2,10);
[CSv,CHv]=contourf([0:24]',depth,di_Tsv',di_clv)
caxis([-.01 .01]);
axb=m_contfbar(1.05,[.01 1],(CSv),CHv);
axb.YLabel.String='vc [m~s$^{-1}$]';
axb.YLabel.Interpreter='latex';

colormap(m_colmap('div'));

% contourf(x/1e3,flipud(t/3600),-u,-clu);
% title(sprintf('u, max = %f',ccu));xlabel('x/km');ylabel('t/hr');
% caxis([-ccu ccu]);


% 
% XLable=xlabel('Hours [IRDT]','Interpreter','latex')
% YLable=ylabel('Depth [m]','Interpreter','latex')

set(gca,'ytick');set(gca,'FontSize',8);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'xtick');set(gca,'FontSize',8);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
   'YMinorTick', 'off','XMinorTick', 'off','XGrid', 'off','YGrid', 'off');

text(0.02,0.98,'e-AmirAbad','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');

