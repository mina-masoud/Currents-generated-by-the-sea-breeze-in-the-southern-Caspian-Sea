
%% Process the Raw Data and prepare it for the Time series Analysis

%ii= depth that we want to process the current data
%Mina Masoud & Rich Pawlowicz 2020

%%
clear all
addpath /ocean/mmasoud/SB/data/
addpath /ocean/mmasoud/PhD/PhD/codes/Rich_codes
addpath /ocean/mmasoud/Post-Doc/basic/
addpath /ocean/mmasoud/PhD/PhD/codes/
addpath /ocean/mmasoud/PhD/PhD/codes/downloaded_codes/Butterworth_Filters_v1
addpath /ocean/mmasoud/PhD/PhD/codes/windstress

%% Load the Raw Wind and Current data
load Original_Current
 %Convert from Global Time to the Local Time; The time difference 
  %at the South Caspian with the GMT is 4:30 Hours in the summer 
tc = tc_astara(1:end) + hours(4) + minutes(30);  
cs = cs_astara (: , ii);
cd = cd_astara (: , ii);

load LocalTime_original_wrf_wind
tw = tw_astara; % Wind time
ws = ws_astara; % Wind speed
wd = wd_astara; % Wind direction

%% Processing the current data

% Convert current speed and direction to alongshore and cross-shore current
[UC VC]=spdir2uv(cs,cd);

% Rotate alongshore and Cross-shore current along the coastline
% Calculating principle axis for finding the angle of the rotation
[theta_c_pc,~,~,wr_c_pc]=princax(UC+i*VC); %Rotate uc and vc
theta_c_pc_2m=theta_c_pc_2m+90;
uc=real(((UC+i*VC)).*exp(1i.*-theta_c_pc.*pi/180));
vc=imag(((UC+i*VC)).*exp(1i.*-theta_c_pc.*pi/180));

% Check against the Richard Thomson, Chatper 5 formula
% mm=([UC_2m].*cos(theta_c_pc_2m.*pi/180))+([VC_2m].*sin(theta_c_pc_2m.*pi/180));
% nn=-UC_2m*sin(theta_c_pc_2m.*pi/180)+VC_2m*cos(theta_c_pc_2m.*pi/180);

% Remove mean current
uc=uc-nanmean(uc);
vc=vc-nanmean(vc);

% Band-Pass_Filtered using ButterWorth filter:
% using 4th order of this filter and just retaining data with window of 6 to 30 Hours
[bp_uc,~,~] = bandpass_butterworth(fixgaps(uc),[1/30 1/6],1,4); 
[bp_vc,~,~] = bandpass_butterworth(fixgaps(vc),[1/30 1/6],1,4);

% High-Passed filter with using moving average filter
hf_uc=uc -nanmoving_average(uc ,12,0); 
hf_vc=vc -nanmoving_average(vc ,12,0); 
hf_ucvc=(uc +1i*vc )-nanmoving_average((uc +1i*vc ),12,0); 

clc
% Calculating ratio of variance of data to high frequency data
var_vc = nanvar(hf_vc)/nanvar(vc )*100;
var_uc = nanvar(hf_uc)/nanvar(uc )*100;
var_ucvc = nanvar(hf_ucvc)/nanvar((uc +1i*vc ))*100;

% Creat a daily cycle; 24 is 24 Hours a day
for ii=0:round(length(tc)./24)     
    di_tc(1:24,ii+1) = tc((24*ii)+1:24*(ii+1),1);
    di_bp_uc(1:24,ii+1) = bp_uc ((24*ii)+1:24*(ii+1),1);
    di_bp_vc(1:24,ii+1) = bp_vc ((24*ii)+1:24*(ii+1),1);
end

%% Processing the Raw Wind data

% Convert meteorological wind direction to Azimuth Wind direction
for ii=1:length(wd)
    wd_azimuth(ii,1)=wd(ii)-180;
end

% change range of -180 degree to 180 degree winds to 0 to 360 degree
for ii=1:length(wd_azimuth)
    if wd_azimuth(ii) < 0
       winddir(ii,1) = wd_azimuth(ii)+360;
    else
       winddir(ii,1)=wd_azimuth(ii);
    end
end

% Convert twind speed and direction to alongshore and cross-shore wind
[uuw vvw]=spdir2uv(ws,winddir);

[bp_uuw,~,~] = bandpass_butterworth(fixgaps(uuw),[1/30 1/6],1,4);
[bp_vvw,~,~] = bandpass_butterworth(fixgaps(vvw),[1/30 1/6],1,4);
[bp_wss bp_wdd]=uv2spdir(bp_uuw,bp_vvw);

for ii=1:length(bp_wdd)
if bp_wdd(ii) <= 0
   bp_wwdd(ii,1) = bp_wdd(ii)+360;
else
    bp_wwdd(ii,1)=bp_wdd(ii);
end
end
bp_wwdd_final=bp_wwdd;

%convert originl wind to azimuth direction consistent with current data
%Direction:
[UW VW]=spdir2uv(ws,winddir); 

%Convert Alongshore and cross-shore wind to wind stress
[TX, TY]=ra_windstr(UW,VW);

% band passed filter wind stress
[bp_TX,~,~] = bandpass_butterworth(fixgaps(TX),[1/30 1/6],1,4);
[bp_TY,~,~] = bandpass_butterworth(fixgaps(TY),[1/30 1/6],1,4);

% Calculating principle axis for finding the angle of the rotation
[theta_pc_w,~,~,wr_pc_w]=princax(UW+i*VW); %Rotate uw and vw
[theta_pc_T,~,~,wr_pc_T]=princax(TX+i*TY);

%After analysis with both wind angle rotation and current data
%we have decided to rotate wind data besed on the same angle of rotation for current data
theta_pc_T=theta_c_pc; 

Tx=real((TX+(i.*TY)).*exp(i.*-theta_pc_T.*pi/180));
Ty=imag((TX+(i.*TY)).*exp(i.*-theta_pc_T.*pi/180));
uw=real((UW+(i.*VW)).*exp(i.*-theta_pc_T.*pi/180));
vw=imag((UW+(i.*VW)).*exp(i.*-theta_pc_T.*pi/180));

% Check against Principle axes analysis
% uuw=imag(wr_pc_w);
% vvw=real(wr_pc_w);
% Ty=TX*cos(theta_c_pc_2m)+TY*sin(theta_c_pc_2m);
% Tx=-TX*sin(theta_c_pc_2m)+TY*cos(theta_c_pc_2m);

% Band-Pass_Filtered using ButterWorth filter:
% using 4th order of this filter and just retaining data with window of 6 to 30 Hours
[bp_uw,~,~] = bandpass_butterworth(fixgaps(uw),[1/30 1/6],1,4);
[bp_vw,~,~] = bandpass_butterworth(fixgaps(vw),[1/30 1/6],1,4);
[bp_Tx,~,~] = bandpass_butterworth(fixgaps(Tx),[1/30 1/6],1,4);
[bp_Ty,~,~] = bandpass_butterworth(fixgaps(Ty),[1/30 1/6],1,4);

% Calculating band-passed wind speed and direction with using band-passed
% alongshore and cross-shore wind 
% Note [ speed Direction ] = uv2spdir (East Component , North component);
%After rotation we have East component as - alongshore wind and north
%component as cross-shore wind
[bp_ws bp_wd]=uv2spdir(-bp_vw,bp_uw); 

%convert range of -180 to 180 degree to range 0 to 360 degree 
for ii=1:length(bp_wd)
if bp_wd(ii) <= 0
   bp_winddir(ii,1) = bp_wd(ii)+360;
else
    bp_winddir(ii,1)=bp_wd(ii);
end
end

bp_wind_final=bp_winddir;

% Check against converting from cartesian coordinate code
% bp_wd_cart=bp_winddir+270;
% for ii=1:length(bp_wd_cart)
%     if bp_wd_cart(ii) >360
%     bp_WD_cart(ii,1) = bp_wd_cart(ii)-360;
%     else
%     bp_WD_cart(ii,1)=bp_wd_cart(ii);
%     end
% end

% Finally convert the data to daily cycle (24 Hours)
for ii=1:round(length(tw)./24)-4  
    di_tw(1:24,ii+1)=tw((24*ii)+1:24*(ii+1),1);
 
    di_wd(1:24,ii+1)=wd((24*ii)+1:24*(ii+1),1);
    di_ws(1:24,ii+1)=ws((24*ii)+1:24*(ii+1),1);
    
    di_bp_wss(1:24,ii+1)=bp_wss((24*ii)+1:24*(ii+1),1);
    di_bp_ws(1:24,ii+1)=bp_ws((24*ii)+1:24*(ii+1),1);
     
    di_bp_wd(1:24,ii+1)=bp_wind_final((24*ii)+1:24*(ii+1),1);
    di_bp_wwdd(1:24,ii+1)=bp_wwdd_final((24*ii)+1:24*(ii+1),1);
    
    di_Tx(1:24,ii+1)=Tx((24*ii)+1:24*(ii+1),1);
    di_Ty(1:24,ii+1)=Ty((24*ii)+1:24*(ii+1),1);
    
    di_bp_uw(1:24,ii+1)=bp_uw((24*ii)+1:24*(ii+1),1);
    di_bp_vw(1:24,ii+1)=bp_vw((24*ii)+1:24*(ii+1),1);
    
    di_bp_Tx(1:24,ii+1)=bp_Tx((24*ii)+1:24*(ii+1),1);
    di_bp_Ty(1:24,ii+1)=bp_Ty((24*ii)+1:24*(ii+1),1);
     
end  

