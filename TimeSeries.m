clear all
fig = figure(1);
findall(0,'type','figure')
gcf
set(gcf, 'Windowstyle', 'normal')
%fig.PaperPositionMode = 'manual';
fig.PaperUnits = 'inches';
fig.Units = 'inches';
%fig.Position = [0.1, 0.1,10,12.5];
fig.Position = [0.1, 0.1,4,4];
clf;orient tall;wysiwyg;
set(gcf,'defaultaxestickdir','out','defaultaxestickdirmode','manual');


for gg=1:5
    
    switch gg
        case 1 %Astara
            load Astara.mat
        case 2 %Astara
            load Anzali.mat
        case 3 %Astara
            load Rood.mat
        case 4 %Astara
            load Nosh.mat
        case 5 %Astara
            load Amir.mat
    end

bp_vc=bp_vc_2m;
bp_uc=bp_uc_2m;

subplot(7,2,2*gg-1)
stickplot(datenum(tc(5500:5600)), -bp_vw(5500:5600), bp_uw(5500:5600),0.13,... 
    [datenum(tc(5500)) datenum(tc(5600))],...
    'Color', '[1 0 0]','LineWidth', 1.5);
set(gca,'ytick');set(gca,'FontSize',10);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off');
xlim([datenum(tc(5495)) datenum(tc(5605))])
xticks([datenum(datetime(2013,07,21,00,00,00):hours(12):datetime(2013,07,25,12,00,00) )])
%xticklabels([datenum(datetime(2013,07,21,00,00,00):hours(24):datetime(2013,07,25,00,00,00) )])
ax=gca; ax.XTickLabel=[];
ylim([-4 4])



subplot(7,2,2*gg)
stickplot(datenum(tc(5500:5600)), -bp_vc(5500:5600), bp_uc(5500:5600),5,... 
    [datenum(tc(5500)) datenum(tc(5600))],...
    'Color', '[1 0 0]','LineWidth', 1.5);
set(gca,'ytick');set(gca,'FontSize',10);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off');
xlim([datenum(tc(5495)) datenum(tc(5605))])
xticks([datenum(datetime(2013,07,21,00,00,00):hours(12):datetime(2013,07,25,12,00,00) )])
%xticklabels([datenum(datetime(2013,07,21,00,00,00):hours(12):datetime(2013,07,25,00,00,00) )])
ax=gca; ax.XTickLabel=[];
ylim([-0.1 0.1])


end

%%
load SL2.mat
subplot(7,2,[11,12])
plot(tsl_anzali(1177:1285), bp_sl_anzali(1177:1285),'Color', '[0 .3 .6]','LineWidth', 1.5)
xlim([(tsl_anzali(1177)) (tsl_anzali(1285))])
text(0.02,0.98,'a-Anzali','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ax=gca; ax.XTickLabel=[];
ylim([-0.06 0.07])
set(gca,'ytick');set(gca,'FontSize',10);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off');
text(0.02,0.98,'iii-Time series of sea level','FontSize',11,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top')
xticks([datenum(datetime(2013,07,21,00,00,00):hours(12):datetime(2013,07,25,12,00,00) )])


subplot(7,2,[13,14])
plot(tsl_amir(1177:1285), bp_sl_amir(1177:1285),'Color', '[1 0 0]','LineWidth', 1.5)
xlim([(tsl_anzali(1177)) (tsl_anzali(1285))])
text(0.02,0.98,'b-AmirAbad','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ylim([-0.06 0.07])
set(gca,'ytick');set(gca,'FontSize',10);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off');
YLable=ylabel('Se level[m]','Interpreter', 'latex','FontSize',10,'Color','k')
xticks([datenum(datetime(2013,07,21,00,00,00):hours(12):datetime(2013,07,25,12,00,00) )])


%%

ax=gca; ax.XTickLabel=[];
% XLable=xlabel('Time','Interpreter','latex')
%axdate;

text(0.02,0.98,'i-Stickplot of wind','FontSize',11,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top')



set(gca,'ytick');set(gca,'FontSize',10);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off');
axdate;
ax=gca; ax.XTickLabel=[];

XLable=xlabel('Time','Interpreter','latex')
YLable=ylabel('Current speed [m~s$^{-1}$]','Interpreter', 'latex','FontSize',10,'Color','k')
YLable=ylabel('Wind speed [m~s$^{-1}$]','Interpreter', 'latex','FontSize',10,'Color','k')


text(0.02,0.98,'ii-Stickplot of bottom current','FontSize',11,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top')


ylim([-4 4])

%%
text(0.02,0.98,'a-Astara','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ax=gca; ax.XTickLabel=[];

text(0.02,0.98,'b-Anzali','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ax=gca; ax.XTickLabel=[];

text(0.02,0.98,'c-Roodsar','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ax=gca; ax.XTickLabel=[];

text(0.02,0.98,'d-Noshahr','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
ax=gca; ax.XTickLabel=[];

text(0.02,0.98,'e-AmirAbad','FontSize',9,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
axdate;




















