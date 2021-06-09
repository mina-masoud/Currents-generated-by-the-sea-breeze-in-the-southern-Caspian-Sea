
%% Spectra Analysis using Pwelch Method
%[pxx,w] = pwelch(data,window,noverlap,nfft,fs);

% n=1; % Astara
% n=2; % Anzali
% n=3; % Roodsar
% n=4; % Noshahr
% n=5; % AmirAbad


%Mina Masoud & Rich Pawlowicz; 2020
%% Input
n=1; %Station number

%Since we are plotting 5 spectra in one plot with logarithmic axis we need to shift each plot
scale = 100^n; 

uc = UC; %Alongshore current
vc = VC; %Cross-shore current

Tx = TX;  %Alongshore
Ty = TY;  %Alongshore

data= fixgaps (Tx + i.*Ty);
fs=24; % Data time interval = 1 Hour 
nff = max(256,2^nextpow2(length(data)));
N = 1024; 

Coriolis=[1.24146492861577,1.21728545343883,1.20998235442400,1.19521912350598,1.1728545343883]

%%  Pwelch 4 Wind stress data
[pxx,w,pxxc]  = pwelch(data,[],[],nff,fs,'centered','ConfidenceLevel',0.95);

%% cPwelch 4 Current data
cdata=fixgaps (uc(1:end) + i.*vc(1:end));
fs=24; % Data time interval = 1 Hour
cnff = max(256,2^nextpow2(length(cdata)));
cN = 1024; 
[cpxx,cw,cpxxc]  = pwelch(cdata,[],[],cnff,fs,'centered','ConfidenceLevel',0.95);

%% Plot wind stress spectra 

subplot(1,4,1)

s=semilogy(w,(pxx)/scale,'color', '[1 0 0]','LineStyle','-','LineWidth', 1.5);
ax=gca; ax.XLim=[-5 5];
ax=gca; ax.XTick=[-5:1:5];
ax=gca; ax.XTickLabel=[-5:1:5];

hold on
%Plot error bar
clim=7000; %Specify the location of the Error bar that you wanna show
e=errorbar(w(clim),(pxx(clim))/scale*n,pxxc(clim)/scale*n/2,...
    'color','k','LineStyle','-','LineWidth',1.5);

%% Plot current spectra
subplot(1,4,2)
sc=semilogy(cw,(cpxx)/scale,'color', '[1 0 0]','LineStyle','-','LineWidth', 1.5);
ax=gca; ax.XLim=[ -5 5];
ax=gca; ax.XTick=[-5 -4 -3 -2 -1 0 1 2 3 4 5];
ax=gca; ax.XTickLabel=[-5 -4 -3 -2 -1 0 1 2 3 4 5];

hold on
ec=errorbar(cw(clim),(cpxx(clim))/scale*n,cpxxc(clim)/scale*n/2,...
    'color','k','LineStyle','-','LineWidth',1.5)

% Specify tide frequencies
o1=line([-0.9662 -0.9662],ylim(),'linest','--','color','k','linewi',0.5);
k1=line([-1.0027 -1.0027],ylim(),'linest','-.','color','k','linewi',.5);
M2=line([-1.9323 -1.9323],ylim(),'linest',':','color','k','linewi',.5);

lgd = legend([ sc1 sc2 sc3 sc4 sc5 o1 k1 M2],...
   'Astara','Anzali','Roodsar','Noshahr','AmirAbad', '$O_1$','$K_1$','$M_2$')
lgd.Interpreter='latex';lgd.FontSize=12;lgd.Box = 'off';lgd.Location='NorthEast';

% Inertial Frequency
Inertia_posFreq=line([Coriolis(n) Coriolis(n)],ylim(),'linest',':','color','k','linewi',1);
Inertia_negFreq=line(-[Coriolis(n) Coriolis(n)],ylim(),'linest',':','color','k','linewi',1);

%% Plot stuff
ax=gca; ax.YLim=[5e-17 1e-3];
ax=gca; ax.YTickLabel=[]
ax=gca; ax.YTickLabel=[-30:10:30];
ax=gca; ax.XLim=[ -2.1 -.5];
set(gca,'ytick');set(gca,'FontSize',11);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'xtick');set(gca,'FontSize',11);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
   'YMinorTick', 'on','XMinorTick', 'on','XGrid', 'off');
lgd = legend('Astara','Anzali','Roodsar','Noshahr','AmirAbad','$O_1$','$K_1$','$M_2$')
lgd.Interpreter='latex';lgd.FontSize=12;lgd.Box = 'off';lgd.Location='NorthEast';
XLable=xlabel('Frequency [cpd]','Interpreter','latex')
YLable=ylabel('Power Spectral Density','Interpreter','latex')
text(0.02,0.98,'Wind stress spectra','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');





