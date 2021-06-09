%% Image daily plots of wind directio for observing sea breeze 

% Long_Lat=[Longtitude(Astara), Long(Anzali), Long(Roodsar), Long(Noshahr), Long(Amir) ;
%     Latitude(Astara), Lat(Anzali), Lat(Roodsar), Lat(Noshahr), Lat(Amir)];

% wd= Wind Direction;
% ws= Wind Speed;

% bp_wd = Band-Passed filtered Wind Direction 
% bp_ws = Band-Passed filtered Wind Speed 

% n= Station Number that we want to plot the wind rose 
% n=1; % Astara
% n=2; % Anzali
% n=3; % Roodsar
% n=4; % Noshahr
% n=5; % AmirAbad

% Mina Masoud, 2020

%% Path tp colormap Rich
addpath /ocean/rich/home/matlab/cbrewer  
addpath /ocean/rich/home/matlab/m_map  

%% Input

%1) Long and lat stations
Long_Lat=[49.051585 49.447977 50.356192 51.388273 53.411137;
    38.369230 37.491144 37.227110 36.698526 36.914256];

%2) Wind speed and direction
open ('Data4Wind_Corrected.mat')
wd = WD;
ws = WS;

bp_wd = bp_WD;
bp_ws = bp_WS;

%3) station Number
n=1;

% Coriolis frequency for each station
w_coriolic=[1.24146492861577,1.21728545343883,1.20998235442400,...
    1.19521912350598,1.20126132439061];

%Coriolis Period for each station
T_coriolic=[19.332 19.716 19.835 20.08 19.979]; %hours


%% Plot
hold on
subplot(1,5,0+n)  %
Ts=(fixgaps(di_bp_wd)); 

days = datenum(tw);
imagesc(days,([0.5:23.5]'),Ts);
axdate

colormap(m_colmap('1cyclic'));

%% Sunrise and Sunset 
% Plot sunrise and sunset times in the Image for each station 
% The matlab script of sunrise citation Beauducel, 2001

hold on;
[srise,sset,noon]=sunrise(c_lat(gg),c_long(gg),28,3.5,days); %SUNRISE(LAT,LON,ALT,TZ,DATE)
plot(days,rem([srise]',1)*24,'LineStyle', '-','Color', '[0 0 0]','linewidth',1)
%plot(days,rem([noon]',1)*24,'LineStyle', '-.','Color', '[0 0 0]','linewidth',1)
plot(days,rem([sset]',1)*24,'LineStyle', '--','Color', '[0 0 0]','linewidth',1)
SUNSET=datestr(sset,'HH:MM'); SUNRISE=datestr(srise,'HH:MM');

%% Plot stuff
ax=gca; ax.XLim=[datenum(datetime(2013,01,01)) datenum(datetime(2013,11,30))]
xt=datenum(2013,01:12,1);
xtickl={'Jan/13','','','Apr','','', 'Jul','','','Oct','','Dec'}
set(gca,'xtick',xt);
set(gca,'XMinorTick', 'off');
set(gca,'xticklabel',xtickl);

lgd = legend( 'Sunrise','sunset')
lgd.Interpreter='latex';lgd.FontSize=12;lgd.Box = 'off';lgd.Location='NorthEast';

t=colorbar;
t.Label.String = 'Wind direction [Deg]';
t.FontSize=10;
t.Label.Interpreter='latex';
t.TickLabelInterpreter='laTeX'
t.Limits=[0 360];
t.YTick=[0:90:360]


