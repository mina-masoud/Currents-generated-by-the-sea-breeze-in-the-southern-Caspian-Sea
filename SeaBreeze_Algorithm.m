 %% Sea Breeze Algorithm
% This code is selecting sea breeze days based on these conditions:
%A sea breeze day is counted when
%1) the wind direction during the day (from 10 am to 11 pm) is from the sea breeze direction
%(onshore), but the wind overnight (from 11 pm to 10 am) is not from the same direction 
%(has greater than 60 degree wind direction difference); and
%2) the wind direction in the afternoon and morning are both from the sea breeze direction 
%(onshore), but afternoon (noon to 11 pm) wind speed is larger than wind speed 
%in the morning (10 am to noon).


%Mina Masoud, 2020

%% Input
t = tw;  
wd = bp_wd; % Band-Passed Wind direction
ws = bp_ws; % Band-Passed Wind Speed

% Determine the onshore and offshore angle of wind based on each coastline
%angle of each station:
%on_ang=[60 120];  off_ang=[180 360]; %For Astara
%on_ang=[30 330];  off_ang=[60 300]; % FOR Anzali 
on_ang=[30 90];  off_ang=[150 330]; %For Roodsar
%on_ang=[30 330];  off_ang=[90 270]; % FOR  Noshahr
%on_ang=[10 310];  off_ang=[70 250]; % FOR AAmir

%Aft_time=[11 24]; % Range of Afternoon time 

%% divide morning (1am to 14 pm) and afternoon
% extract hours, minutes and seconds from the datetime 
hours =hour(t);

% Preallocate category vector
cat = (categorical({'Mor', 'Aft'}))';

% Assign categories to the rows depending from hours
for k = 1:length(hours)
    if hours(k) > Aft_time(1) & hours(k) < Aft_time(2)
        cat(k) = 'Aft'; 
    else 
        cat(k) = 'Mor'; 
    end
end
% build a timetable from those above
tab = timetable(t,ws,wd,cat);
% Assign names to the vars
%tab_new_all.Properties.VariableNames = {'Value', 'Category'};
% Table with the day-times
tab_Aft = tab (cat == 'Aft',:);
% Table with the night-times 
tab_Mor = tab (cat == 'Mor',:);

%% Condition of sea breeze algorithm 
%For Astara and Roodsar stations
ii=find((tab.wd(tab.cat == 'Aft')<=on_ang(2) & tab.wd(tab.cat == 'Aft')>=on_ang(1)) & ...
        (tab.wd(tab.cat == 'Mor')<off_ang(2) & tab.wd(tab.cat == 'Mor')>off_ang(1) ));
    
%For Anzali, AmirAbad and Noshahr stations
% ii=find((tab.wd(tab.cat == 'Aft')<=on_ang(1) | tab.wd(tab.cat == 'Aft')>=on_ang(2)) & ...
%        (tab.wd(tab.cat == 'Mor')<off_ang(2) & tab.wd(tab.cat == 'Mor')>off_ang(1)));  
     
%% Extracting SB days
t_SB1=tab_Aft.t(ii);
ws_SB1=tab_Aft.ws(ii);
wd_SB1=tab_Aft.wd(ii);
t_Mor_SB1=tab_Mor.t(ii);
wd_Mor_SB=tab_Mor.wd(ii);

kk=datefind([t_SB1],t);
t_SB=t(kk);

days2=day(t_SB); %extract only days from t_SB

for ww=1:length (days2)-1 
    if days2(ww)~=days2(ww+1)
    Tii2(ww)=t_SB(ww);
    end
end
Tii2=Tii2(:);
uu2=find(~isnat(Tii2));
Time_SB=Tii2(uu2);
Time_SB=datetime(Time_SB, 'Format','dd-MMM-yyyy'); %this is a SB time that shows a cndidate day of SB

%% convert to 24-hour method (Daily cycle)
kk=datefind(Time_SB,t);
for oo=1:length(kk)-1
    dy(1:24,oo)=find((fix(datenum(t)))==fix(datenum(t(kk(oo)))));
end

di_SB_time=t(dy);
di_SB_ws=ws(dy);
di_SB_wd=wd(dy);

%% create a SB time series with 24 hours for each day
[n,m]=size(di_SB_time);

Te(1:24,1)=di_SB_time(:,1);
for hh=1:m-1
Te(1+24*hh:24*(hh+1),1)=[di_SB_time(:,hh+1)];
end

SB_time=Te; %this is SB time that each candidate sb day has 24 hours  

eew=datefind(SB_time,tab.t);
SB_time=tab.t(eew);
SB_ws=tab.ws(eew);
SB_wd=tab.wd(eew);
% creat time table for sea breeze day
SB_tab = timetable(SB_time,SB_ws,SB_wd);

%% Divide Sea Breeze from Land Breeze
%create an semidiurnal time of SB in  the morning that SB exsits
ee=datefind(SB_time,tab_Aft.t);
eee=datefind(SB_time,tab_Mor.t);

SB_time_Aft=tab_Aft.t(ee);
SB_ws_Aft=tab_Aft.ws(ee);
SB_wd_Aft=tab_Aft.wd(ee);

SB_time_Mor=tab_Mor.t(eee);
SB_ws_Mor=tab_Mor.ws(eee);
SB_wd_Mor=tab_Mor.wd(eee);

semidi_SB_time_Aft(1:12,1)=SB_time_Aft(1:12,1);
semidi_SB_ws_Aft(1:12,1)=SB_ws_Aft(1:12,1);
semidi_SB_wd_Aft(1:12,1)=SB_wd_Aft(1:12,1);

semidi_SB_time_Mor(1:12,1)=SB_time_Mor(1:12,1);
semidi_SB_ws_Mor(1:12,1)=SB_ws_Mor(1:12,1);
semidi_SB_wd_Mor(1:12,1)=SB_wd_Mor(1:12,1);

for pp=1:round(length(SB_time_Aft)/12)-1
   semidi_SB_time_Aft(1:12,pp+1)=SB_time_Aft((12*pp)+1:12*(pp+1));
   semidi_SB_ws_Aft(1:12,pp+1)=SB_ws_Aft((12*pp)+1:12*(pp+1));
   semidi_SB_wd_Aft(1:12,pp+1)=SB_wd_Aft((12*pp)+1:12*(pp+1));
end

for pp=1:round(length(SB_time_Mor)/12)-1
   semidi_SB_time_Mor(1:12,pp+1)=SB_time_Mor((12*pp)+1:12*(pp+1));
   semidi_SB_ws_Mor(1:12,pp+1)=SB_ws_Mor((12*pp)+1:12*(pp+1));
   semidi_SB_wd_Mor(1:12,pp+1)=SB_wd_Mor((12*pp)+1:12*(pp+1));
end


%% find how many sB days exsit in each month 
months_SB2=month(Time_SB);

ii_Dec2=find(months_SB2== 12);ii_Jan2=find(months_SB2== 1);
ii_Feb2=find(months_SB2== 2);ii_Mar2=find(months_SB2== 3);
ii_Apr2=find(months_SB2== 4);ii_May2=find(months_SB2== 5);
ii_Jun2=find(months_SB2== 6);ii_July2=find(months_SB2== 7);
ii_Aug2=find(months_SB2== 8);ii_Sep2=find(months_SB2== 9);
ii_Oct2=find(months_SB2== 10);ii_Nov2=find(months_SB2== 11);

nSB2=[length(ii_Jan2) length(ii_Feb2) length(ii_Mar2) ...
     length(ii_Apr2) length(ii_May2) length(ii_Jun2) length(ii_July2) ...
     length(ii_Aug2) length(ii_Sep2) length(ii_Oct2) length(ii_Nov2) length(ii_Dec2)];

err_nSB2=[ std((ii_Jan2))/sqrt(length(ii_Jan2)) ...
    std((ii_Feb2))/sqrt(length(ii_Feb2))...
    std((ii_Mar2))/sqrt(length(ii_Mar2))...
     std(ii_Apr2)/sqrt(length(ii_Apr2))...
     std(ii_May2)/sqrt(length(ii_May2)) ...
     std(ii_Jun2)/sqrt(length(ii_Jun2))...
     std(ii_July2)/sqrt(length(ii_July2))...
     std(ii_Aug2)/sqrt(length(ii_Aug2)) ...
     std(ii_Sep2)/sqrt(length(ii_Sep2)) ...
     std(ii_Oct2)/sqrt(length(ii_Oct2)) ...
     std(ii_Nov2)/sqrt(length(ii_Nov2)) ...
     std(ii_Dec2)/sqrt(length(ii_Dec2))];

WS2=[nanmean(semidi_SB_ws_Aft(:,ii_Jan2),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Feb2),2),nanmean(semidi_SB_ws_Aft(:,ii_Mar2),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Apr2),2),nanmean(semidi_SB_ws_Aft(:,ii_May2),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Jun2),2),nanmean(semidi_SB_ws_Aft(:,ii_July2),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Aug2),2),nanmean(semidi_SB_ws_Aft(:,ii_Sep2),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Oct2),2),nanmean(semidi_SB_ws_Aft(:,ii_Nov2-1),2),...
    nanmean(semidi_SB_ws_Aft(:,ii_Dec2),2)];


err_WS2=[std(semidi_SB_ws_Aft(:,ii_Jan2),[],2)/sqrt(length(ii_Jan2)),...
    std(semidi_SB_ws_Aft(:,ii_Feb2),[],2)/sqrt(length(ii_Feb2)),...
    std(semidi_SB_ws_Aft(:,ii_Mar2),[],2)/sqrt(length(ii_Mar2)),...
    std(semidi_SB_ws_Aft(:,ii_Apr2),[],2)/sqrt(length(ii_Apr2)),...
    std(semidi_SB_ws_Aft(:,ii_May2),[],2)/sqrt(length(ii_May2)),...
    std(semidi_SB_ws_Aft(:,ii_Jun2),[],2)/sqrt(length(ii_Jun2)),...
    std(semidi_SB_ws_Aft(:,ii_July2),[],2)/sqrt(length(ii_July2)),...
    std(semidi_SB_ws_Aft(:,ii_Aug2),[],2)/sqrt(length(ii_Aug2)),...
    std(semidi_SB_ws_Aft(:,ii_Sep2),[],2)/sqrt(length(ii_Sep2)),...
    std(semidi_SB_ws_Aft(:,ii_Oct2),[],2)/sqrt(length(ii_Oct2)),...
    std(semidi_SB_ws_Aft(:,ii_Nov2-1),[],2)/sqrt(length(ii_Nov2)),...
    std(semidi_SB_ws_Aft(:,ii_Dec2),[],2)/sqrt(length(ii_Dec2))];

%%
%[n,m]=size(semidi_SB_wd_Aft);

%for ii=1:m
%    for jj=1:n
%if semidi_SB_wd_Aft(jj,ii) <= 180
%   semidi_SB_wd_Aft(jj,ii) = semidi_SB_wd_Aft(jj,ii);
%else
%    semidi_SB_wd_Aft(jj,ii)=semidi_SB_wd_Aft(jj,ii)-360;
%end
%end
%end

%%
WD2=[mode(semidi_SB_wd_Aft(:,ii_Jan2),2),...
    mode(semidi_SB_wd_Aft(:,ii_Feb2),2),mode(semidi_SB_wd_Aft(:,ii_Mar2),2),...
    mode(semidi_SB_wd_Aft(:,ii_Apr2),2),mode(semidi_SB_wd_Aft(:,ii_May2),2),...
    mode(semidi_SB_wd_Aft(:,ii_Jun2),2),mode(semidi_SB_wd_Aft(:,ii_July2),2),...
    mode(semidi_SB_wd_Aft(:,ii_Aug2),2),mode(semidi_SB_wd_Aft(:,ii_Sep2),2),...
    mode(semidi_SB_wd_Aft(:,ii_Oct2),2),mode(semidi_SB_wd_Aft(:,ii_Nov2-1),2),...
    mode(semidi_SB_wd_Aft(:,ii_Dec2),2)];

err_WD2=[std(semidi_SB_wd_Aft(:,ii_Jan2),[],2)/sqrt(length(ii_Jan2)),...
    std(semidi_SB_wd_Aft(:,ii_Feb2),[],2)/sqrt(length(ii_Feb2)),...
    std(semidi_SB_wd_Aft(:,ii_Mar2),[],2)/sqrt(length(ii_Mar2)),...
    std(semidi_SB_wd_Aft(:,ii_Apr2),[],2)/sqrt(length(ii_Apr2)),...
    std(semidi_SB_wd_Aft(:,ii_May2),[],2)/sqrt(length(ii_May2)),...
    std(semidi_SB_wd_Aft(:,ii_Jun2),[],2)/sqrt(length(ii_Jun2)),...
    std(semidi_SB_wd_Aft(:,ii_July2),[],2)/sqrt(length(ii_July2)),...
    std(semidi_SB_wd_Aft(:,ii_Aug2),[],2)/sqrt(length(ii_Aug2)),...
    std(semidi_SB_wd_Aft(:,ii_Sep2),[],2)/sqrt(length(ii_Sep2)),...
    std(semidi_SB_wd_Aft(:,ii_Oct2),[],2)/sqrt(length(ii_Oct2)),...
    std(semidi_SB_wd_Aft(:,ii_Nov2-1),[],2)/sqrt(length(ii_Nov2)),...
    std(semidi_SB_wd_Aft(:,ii_Dec2),[],2)/sqrt(length(ii_Dec2))];




%% Plot
hold on
fig = figure(2);
findall(0,'type','figure')
set(gcf, 'Windowstyle', 'normal')
fig.PaperUnits = 'inches'; fig.Units = 'inches';
fig.Position = [0.1, 0.1, 5,5];

p1=subplot(211)
hold on

err1=errorbar([1:12],nSB2,-err_nSB2,err_nSB2);
set(err1,'LineStyle', '-','Color', '[0 .3 .6]','LineWidth', 1.5)
YLable=ylabel('Number','Interpreter', 'latex','FontSize',12,'Color','k')
tit=title('Sea Breeze')
ylim([0, 31])
p1.YTick=[0:10:40];
set(gca,'ytick');set(gca,'FontSize',12);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off','XGrid', 'off');
text(0.02,0.98,'i','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
xlim([0 12])
set(gca,'xtick',[1:12])
p1.XTickLabel=[];

p2=subplot(212) 
hold on

err2=errorbar([1:12],WS2(11,1:12),-err_WS2(11,1:12),err_WS2(11,1:12));
set(err2,'LineStyle', '-','Color', '[0 .3 .6]','LineWidth', 1.5)
ax=gca; ax.YLim=[0 4];
ax=gca; ax.YTick=[0:2:6];
text(0.02,0.98,'ii','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
YLable=ylabel('WS [$m~s^{-1}$]','Interpreter', 'latex','FontSize',12,'Color','k');
set(gca,'ytick');set(gca,'FontSize',12);set(gca, 'TickLabelInterpreter', 'LaTeX');
set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
    'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off','XGrid', 'off');
xlim([0 12])
set(gca,'xtick',[1:12])
p2.XTickLabel=[];


% p3=subplot(313) 
% hold on
% 
% err3=errorbar([1:12],WD2(11,1:12)',-err_WD2(11,1:12)',err_WD2(11,1:12)');
% set(err3,'LineStyle', '-','Color', '[0 .3 .6]','LineWidth', 1.5)
% YLable=ylabel('WD [Deg]','Interpreter', 'latex','FontSize',12,'Color','k');
% p3.XLim=[0 12];
% p3.YLim=[-180 180];
% p3.YTick=[-180:90:180]
% 
% set(gca,'ytick');set(gca,'FontSize',12);set(gca, 'TickLabelInterpreter', 'LaTeX');
% set(gca,'Box','off','TickDir','out','TickLength', [.01 .01] , ...
%     'YMinorTick', 'off','XMinorTick', 'off','YGrid', 'off','XGrid', 'off');
% text(0.02,0.98,'iii','FontSize',12,'Units', 'Normalized','Interpreter', 'latex','VerticalAlignment', 'Top');
% 
% linkaxes([p1,p2,p3],'x')
xlim([0 12])
names = {'Jan';'Feb';'Mar';'Apr';'May';'Jun';'July';'Aug';'Sep';'Oct';'Nov';'Dec'};
set(gca,'xtick',[1:12],'xticklabel',names,'fontsize',12)
%xtickangle(45)
set(0,'DefaultTextInterpreter', 'latex')

XLable=xlabel('Time','Interpreter', 'latex','FontSize',12,'Color','k');

%%
%  'rood'           , [0 .3 .6], ...   
%  'rood'           , [0 .3 .6], ...   
%  'rood'           ,[0 .3 .6], ...   
%  'rood'           ,[0 .3 .6], ...   
%  'rood'            , [0.9 0 0], ...   


%% Output

%clearvars -except  SB_tab di_SB_time semidi_SB_time_Aft ...
%    Pure_SB_tab di_Pure_SB_time semidi_Pure_SB_time

SB_tab_rood=SB_tab;
di_SB_time_rood=di_SB_time;
semidi_SB_time_Aft_rood=semidi_SB_time_Aft;

clearvars -except  SB_tab_rood di_SB_time_rood semidi_SB_time_Aft_rood

%save SB_Nosh SB_tab di_SB_time semidi_SB_time_Aft ...
%    Pure_SB_tab di_Pure_SB_time semidi_Pure_SB_time



