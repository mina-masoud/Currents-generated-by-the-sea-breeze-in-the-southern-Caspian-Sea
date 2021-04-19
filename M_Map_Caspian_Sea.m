%% Map 4 the Caspian Sea
% This code shows bathymetry of the Caspian Sea and 
%ALSO shows the wind roses at 5 stations of 
%Station 1:Astara, Station 2: Anzali, Station 3: Roodsar,
%Station 4:Noshahr and Station 5: AmirAbad that we have ADCP data measurements.

%Long_Lat=[Longtitude(Astara), Long(Anzali), Long(Roodsar), Long(Noshahr), Long(Amir) ;
%     Latitude(Astara), Lat(Anzali), Lat(Roodsar), Lat(Noshahr), Lat(Amir)];

% wd= Wind Direction;
% ws= Wind Speed;

% bp_wd = Band-Passed filtered Wind Direction 
% bp_ws = Band-Passed filtered Wind Speed 

% ii= Station Number that we want to plot the wind rose for
%% Input
%1) Long and lat stations
Long_Lat=[49.051585 49.447977 50.356192 51.388273 53.411137;
    38.369230 37.491144 37.227110 36.698526 36.914256];

%2) Wind speed and direction
open ('Data4Wind_Corrected.mat')
wd = wd_astara;
ws = ws_astara;

bp_wd = bp_wd_astara;
bp_ws = bp_ws_astara

%3) station Number
ii=1;
% Mina Masoud- Rich Pwolowicz, 2020
%% Adding directory to the m_map code by Rich Pawlowicz
addpath /ocean/rich/home/matlab/cbrewer  
addpath /ocean/rich/home/matlab/m_map  

%% Preparing the figure and subplots
fig = figure(1);
findall(0,'type','figure');gcf;set(gcf, 'Windowstyle', 'normal');
fig.PaperUnits = 'inches';fig.Units = 'inches';
fig.Position = [0.1, 0.1,10,5];
hold on

% SubPlot1: The Caspian Sea
ax11 = axes('Position',[0.1 0.1 0.4 0.9]);
lat11 = [36 43];
long11 =[48 55];

% SubPlot2: the South Caspian Sea with wind roses
ax21 = axes('Position',[0.45 0.55 0.45 0.3]); 
lat21 = [36 39];
long21 =[48 55];

% SubPlot 3 : the south Caspian sea with ghigh frequency wind roses
ax31 = axes('Position',[0.45 0.15 0.45 0.3]); 
lat31 = [36 39];
long31 =[48 55];

%% SubPlot1: The Caspian Sea
ax1 = ax11;

m_proj('lambert', 'lat',lat11, 'long',long11);

[CS,CH]=m_etopo2('contourf',[-1100:1:0 -100 0 1 10 100 1000]-28,'edgecolor','none');

%Plot depth countours at 10 m, 50, 100, 200, 500 and 800 m
[CS1,CH1]=m_etopo2('contour',[-10 -10]-28,'edgecolor','k','LineWidth'  , 1.5); 
[CS2,CH2]=m_etopo2('contour',[-50 -50]-28,'edgecolor','[.4 0.4 0.4]'); 
[CS3,CH3]=m_etopo2('contour',[-100 -100]-28,'edgecolor','k'); 
[CS4,CH4]=m_etopo2('contour',[-200 -200]-28,'edgecolor','[.4 0.4 0.4]','LineWidth'  , 2); 
[CS5,CH5]=m_etopo2('contour',[-500 -500]-28,'edgecolor','[.8 0.8 0.8]','LineWidth'  , 2); 
[CS6,CH6]=m_etopo2('contour',[-800 -800]-28,'edgecolor','[.8 0.8 0.8]');
%[CS6,CH6]=m_etopo2('contour',[-1000 -1000]-28,'edgecolor','k');
legend ([CH1,CH2,CH3,CH4,CH5,CH6],'10 m ','50 m ','100 m ','200 m','500 m ','800 m')
lgd.Interpreter = 'LaTeX';lgd.FontSize = 12;lgd.FontName = 'LaTeX';
lgd.Location='SouthEast'

m_gshhs_f;
caxis([-1100 1000]-28);
colormap([m_colmap('blues',141);m_colmap('land',128)]);  
m_grid('linest','none','tickdir','out','xaxisloc','top','yaxisloc','right','box','fancy','fontsize',12);
set(gcf,'color','w');
m_gshhs_i('color','k');              % Coastline...
m_gshhs_i('speckle','color','k');    % with speckle added

tt=m_line(c_long,c_lat,'marker','s','color','r','linewi',1.5,...
          'markersize',8,'linest','none','markerfacecolor','w','clip','point');      
lgd=legend([tt],'ADCP stations', ... 
    'location','southwest');      
lgd.Interpreter = 'LaTeX';
lgd.FontSize = 12;
lgd.FontName = 'LaTeX';
      
text(0.02,0.98,'a','FontSize',18,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top','Color','k')

%% SubPlot2: the South Caspian Sea with wind roses
ax1=ax21; % Choose second subplot

%plot the map
m_proj('lambert','lat', lat21, 'long', long21); % Specify the lat and long of the study area  
m_gshhs_i('color','k');              % Coastline...
m_gshhs_i('speckle','color','k');    % with speckle added
m_grid('linewi',2,'linest','none','tickdir','out','fontsize',10);

%plot the wind roses at each station
ax2=axes('pos',get(ax1,'position'));
hold on
m_windrose(Long_Lat(1, ii), Long_Lat(2,ii),wd,ws,'nspeeds',[0 1:1:10],'size',.4);
colormap(ax2,m_colmap('jet'));
caxis([0 10]);
m_grid('linest','none','backcolor','none','xtick',[],'ytick',[],'box','off');
axb=m_contfbar(ax2,[.3 .7],-.15,[0 10],[0:1:10]);

axb.YLabel.String='Wind speeds [m~s$^{-1}$]';
axb.YLabel.Interpreter='latex';
   
text(0.02,0.98,'b','FontSize',22,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top','Color','k')

%% Subplot c
ax1=ax31; %Axis of the 3rd subplot

m_proj('lambert','lat', lat31, 'long', long31);
m_gshhs_i('color','k');              % Coastline...
m_gshhs_i('speckle','color','k');    % with speckle added
m_grid('linewi',2,'linest','none','tickdir','out','fontsize',10);
      
%plot the wind roses at each station
ax2=axes('pos',get(ax1,'position'));
hold on
m_windrose(Long_Lat(1, ii), Long_Lat(2,ii),bp_wd,bp_ws,'nspeeds',[0 1:1:10],'size',.4);
colormap(ax2,m_colmap('jet'));
caxis([0 4]);
m_grid('linest','none','backcolor','none','xtick',[],'ytick',[],'box','off');
axb=m_contfbar(ax2,0.9,[.3 .7],[0 4],[0:1:4]);
axb.YLabel.String='Wind speeds [m~s$^{-1}$]';
axb.YLabel.Interpreter='latex';

text(0.02,0.98,'c','FontSize',22,'Units', 'Normalized',...
    'Interpreter', 'latex','VerticalAlignment', 'Top','Color','k')



