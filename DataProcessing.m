clear all
%%
gg=5

%%
addpath /ocean/mmasoud/SB/data/
addpath /ocean/mmasoud/PhD/PhD/codes/Rich_codes
addpath /ocean/mmasoud/Post-Doc/basic/
addpath /ocean/mmasoud/PhD/PhD/codes/
addpath /ocean/mmasoud/PhD/PhD/codes/downloaded_codes/Butterworth_Filters_v1
addpath /ocean/mmasoud/PhD/PhD/codes/windstress
addpath /ocean/mmasoud/Common_Codes/

load original_current_10m

tc1=tcrood(21:end);
crood=crood(1:end,:);
tc2=tc1+hours(4)+minutes(30);   
tc=tc2(1:end);
cs_2m=crood(1:end,3);   cd_2m=crood(1:end,4);
cs_3m=crood(1:end,7);   cd_3m=crood(1:end,8);
cs_4m=crood(1:end,11);  cd_4m=crood(1:end,12);
cs_5m=crood(1:end,15);  cd_5m=crood(1:end,16);
cs_6m=crood(1:end,19);  cd_6m=crood(1:end,20);
cs_7m=crood(1:end,23);  cd_7m=crood(1:end,24);
cs_8m=crood(1:end,27);  cd_8m=crood(1:end,28);
% cs_9m=crood(1:end,31);  cd_9m=crood(1:end,32);
% cs_10m=crood(1:end,35);  cd_10m=crood(1:end,36);

load LocalTime_original_wrf_wind

tw=tw(25:end);
ws=wsrood(25:end);
wd=wdrood(25:end);

%%
% Complex currents
cc_2m=cs_2m.*exp(i*(90-cd_2m)*pi/180);
cc_3m=cs_3m.*exp(i*(90-cd_3m)*pi/180);
cc_4m=cs_4m.*exp(i*(90-cd_4m)*pi/180);
cc_5m=cs_5m.*exp(i*(90-cd_5m)*pi/180);
cc_6m=cs_6m.*exp(i*(90-cd_6m)*pi/180);
cc_7m=cs_7m.*exp(i*(90-cd_7m)*pi/180);
cc_8m=cs_8m.*exp(i*(90-cd_8m)*pi/180);
% cc_9m=cs_9m.*exp(i*(90-cd_9m)*pi/180);
% cc_10m=cs_10m.*exp(i*(90-cd_10m)*pi/180);

% Complex wind - change sign to match oceanographic convention
cwind=-ws.*exp(i*(90-wd)*pi/180);
[TX, TY]=ra_windstr(real(cwind),imag(cwind));
cT=TX+i*TY;

% Get principal axis direction
[theta_2m,~,~,wr_c_pc_2m]=princax(cc_2m);  
[theta_3m,~,~,wr_c_pc_3m]=princax(cc_3m);  
[theta_4m,~,~,wr_c_pc_4m]=princax(cc_4m);  
[theta_5m,~,~,wr_c_pc_5m]=princax(cc_5m);  
[theta_6m,~,~,wr_c_pc_6m]=princax(cc_6m);  
[theta_7m,~,~,wr_c_pc_7m]=princax(cc_7m);  
[theta_8m,~,~,wr_c_pc_8m]=princax(cc_8m);  
% [theta_9m,~,~,wr_c_pc_9m]=princax(cc_9m);  
% [theta_10m,~,~,wr_c_pc_10m]=princax(cc_10m);  

%%
% figure(1);
% clf;
% subplot(1,3,1);
% hold on
% plot(cc_2m);
% plot(cc_3m);
% plot(cc_4m);
% plot(cc_5m);
% plot(cc_6m);
% plot(cc_7m);
% plot(cc_8m);axis equal
% title(sprintf('Principal axis: %.1f',theta_2m));
% subplot(1,3,2);
% plot(cwind);
% axis equal;
% subplot(1,3,3);
% plot(cT);
% axis equal;
%%

% Rotate into our coordinate system
theta_c_pc_2m=-theta_2m-90
theta_c_pc_3m=-theta_3m-90
theta_c_pc_4m=-theta_4m-90
theta_c_pc_5m=-theta_5m-90
theta_c_pc_6m=-theta_6m-90
theta_c_pc_7m=-theta_7m-90
theta_c_pc_8m=-theta_8m-90
% theta_c_pc_9m=-theta_9m-90
% theta_c_pc_10m=-theta_10m-90


uc_2m=real(cc_2m.*exp(i.*theta_c_pc_2m.*pi/180));
vc_2m=imag(cc_2m.*exp(i.*theta_c_pc_2m.*pi/180));
uc_3m=real(cc_3m.*exp(i.*theta_c_pc_3m.*pi/180));
vc_3m=imag(cc_3m.*exp(i.*theta_c_pc_3m.*pi/180));
uc_4m=real(cc_4m.*exp(i.*theta_c_pc_4m.*pi/180));
vc_4m=imag(cc_4m.*exp(i.*theta_c_pc_4m.*pi/180));
uc_5m=real(cc_5m.*exp(i.*theta_c_pc_5m.*pi/180));
vc_5m=imag(cc_5m.*exp(i.*theta_c_pc_5m.*pi/180));
uc_6m=real(cc_6m.*exp(i.*theta_c_pc_6m.*pi/180));
vc_6m=imag(cc_6m.*exp(i.*theta_c_pc_6m.*pi/180));
uc_7m=real(cc_7m.*exp(i.*theta_c_pc_7m.*pi/180));
vc_7m=imag(cc_7m.*exp(i.*theta_c_pc_7m.*pi/180));
uc_8m=real(cc_8m.*exp(i.*theta_c_pc_8m.*pi/180));
vc_8m=imag(cc_8m.*exp(i.*theta_c_pc_8m.*pi/180));
% uc_9m=real(cc_9m.*exp(i.*theta_c_pc_9m.*pi/180));
% vc_9m=imag(cc_9m.*exp(i.*theta_c_pc_9m.*pi/180));
% uc_10m=real(cc_10m.*exp(i.*theta_c_pc_10m.*pi/180));
% vc_10m=imag(cc_10m.*exp(i.*theta_c_pc_10m.*pi/180));

uw=real(cwind.*exp(i.*theta_c_pc_2m.*pi/180));
vw=imag(cwind.*exp(i.*theta_c_pc_2m.*pi/180));

Txp=real(cT.*exp(i.*theta_c_pc_2m.*pi/180));
Typ=imag(cT.*exp(i.*theta_c_pc_2m.*pi/180));

% Bandpass
[bp_uc_2m,~,~] = bandpass_butterworth(fixgaps(uc_2m),[1/30 1/6],1,4);
[bp_vc_2m,~,~] = bandpass_butterworth(fixgaps(vc_2m),[1/30 1/6],1,4);
[bp_uc_3m,~,~] = bandpass_butterworth(fixgaps(uc_3m),[1/30 1/6],1,4);
[bp_vc_3m,~,~] = bandpass_butterworth(fixgaps(vc_3m),[1/30 1/6],1,4);
[bp_uc_4m,~,~] = bandpass_butterworth(fixgaps(uc_4m),[1/30 1/6],1,4);
[bp_vc_4m,~,~] = bandpass_butterworth(fixgaps(vc_4m),[1/30 1/6],1,4);
[bp_uc_5m,~,~] = bandpass_butterworth(fixgaps(uc_5m),[1/30 1/6],1,4);
[bp_vc_5m,~,~] = bandpass_butterworth(fixgaps(vc_5m),[1/30 1/6],1,4);
[bp_uc_6m,~,~] = bandpass_butterworth(fixgaps(uc_6m),[1/30 1/6],1,4);
[bp_vc_6m,~,~] = bandpass_butterworth(fixgaps(vc_6m),[1/30 1/6],1,4);
[bp_uc_7m,~,~] = bandpass_butterworth(fixgaps(uc_7m),[1/30 1/6],1,4);
[bp_vc_7m,~,~] = bandpass_butterworth(fixgaps(vc_7m),[1/30 1/6],1,4);
[bp_uc_8m,~,~] = bandpass_butterworth(fixgaps(uc_8m),[1/30 1/6],1,4);
[bp_vc_8m,~,~] = bandpass_butterworth(fixgaps(vc_8m),[1/30 1/6],1,4);
% [bp_uc_9m,~,~] = bandpass_butterworth(fixgaps(uc_9m),[1/30 1/6],1,4);
% [bp_vc_9m,~,~] = bandpass_butterworth(fixgaps(vc_9m),[1/30 1/6],1,4);
% [bp_uc_10m,~,~] = bandpass_butterworth(fixgaps(uc_10m),[1/30 1/6],1,4);
% [bp_vc_10m,~,~] = bandpass_butterworth(fixgaps(vc_10m),[1/30 1/6],1,4);

[bp_uw,~,~] = bandpass_butterworth(fixgaps(uw),[1/30 1/6],1,4);
[bp_vw,~,~] = bandpass_butterworth(fixgaps(vw),[1/30 1/6],1,4);

[bp_TX,~,~] = bandpass_butterworth(fixgaps(Txp),[1/30 1/6],1,4);
[bp_TY,~,~] = bandpass_butterworth(fixgaps(Typ),[1/30 1/6],1,4);

%% Daily average

uwD=reshape(bp_uw(1: fix(length(uw)/24)*24),24,fix(length(uw)/24) );
vwD=reshape(bp_vw(1: fix(length(vw)/24)*24),24,fix(length(vw)/24) );
uwD=uwD([1:24 1],:);
vwD=vwD([1:24 1],:);

TxD=reshape(bp_TX(1: fix(length(uw)/24)*24),24,fix(length(uw)/24) );
TyD=reshape(bp_TY(1: fix(length(vw)/24)*24),24,fix(length(vw)/24) );

TxD=TxD([1:24 1],:);
TyD=TyD([1:24 1],:);

ucD_2m=reshape(bp_uc_2m(1: fix(length(uc_2m)/24)*24),24,fix(length(uc_2m)/24) );
vcD_2m=reshape(bp_vc_2m(1: fix(length(vc_2m)/24)*24),24,fix(length(vc_2m)/24) );
ucD_2m=ucD_2m([1:24 1],:);
vcD_2m=vcD_2m([1:24 1],:);
ucD_3m=reshape(bp_uc_3m(1: fix(length(uc_3m)/24)*24),24,fix(length(uc_3m)/24) );
vcD_3m=reshape(bp_vc_3m(1: fix(length(vc_3m)/24)*24),24,fix(length(vc_3m)/24) );
ucD_3m=ucD_3m([1:24 1],:);
vcD_3m=vcD_3m([1:24 1],:);
ucD_4m=reshape(bp_uc_4m(1: fix(length(uc_4m)/24)*24),24,fix(length(uc_4m)/24) );
vcD_4m=reshape(bp_vc_4m(1: fix(length(vc_4m)/24)*24),24,fix(length(vc_4m)/24) );
ucD_4m=ucD_4m([1:24 1],:);
vcD_4m=vcD_4m([1:24 1],:);
ucD_5m=reshape(bp_uc_5m(1: fix(length(uc_5m)/24)*24),24,fix(length(uc_5m)/24) );
vcD_5m=reshape(bp_vc_5m(1: fix(length(vc_5m)/24)*24),24,fix(length(vc_5m)/24) );
ucD_5m=ucD_5m([1:24 1],:);
vcD_5m=vcD_5m([1:24 1],:);
ucD_6m=reshape(bp_uc_6m(1: fix(length(uc_6m)/24)*24),24,fix(length(uc_6m)/24) );
vcD_6m=reshape(bp_vc_6m(1: fix(length(vc_6m)/24)*24),24,fix(length(vc_6m)/24) );
ucD_6m=ucD_6m([1:24 1],:);
vcD_6m=vcD_6m([1:24 1],:);
ucD_7m=reshape(bp_uc_7m(1: fix(length(uc_7m)/24)*24),24,fix(length(uc_7m)/24) );
vcD_7m=reshape(bp_vc_7m(1: fix(length(vc_7m)/24)*24),24,fix(length(vc_7m)/24) );
ucD_7m=ucD_7m([1:24 1],:);
vcD_7m=vcD_7m([1:24 1],:);
ucD_8m=reshape(bp_uc_8m(1: fix(length(uc_8m)/24)*24),24,fix(length(uc_8m)/24) );
vcD_8m=reshape(bp_vc_8m(1: fix(length(vc_8m)/24)*24),24,fix(length(vc_8m)/24) );
ucD_8m=ucD_8m([1:24 1],:);
vcD_8m=vcD_8m([1:24 1],:);
% ucD_9m=reshape(bp_uc_9m(1: fix(length(uc_9m)/24)*24),24,fix(length(uc_9m)/24) );
% vcD_9m=reshape(bp_vc_9m(1: fix(length(vc_9m)/24)*24),24,fix(length(vc_9m)/24) );
% ucD_9m=ucD_9m([1:24 1],:);
% vcD_9m=vcD_9m([1:24 1],:);
% ucD_10m=reshape(bp_uc_10m(1: fix(length(uc_10m)/24)*24),24,fix(length(uc_10m)/24) );
% vcD_10m=reshape(bp_vc_10m(1: fix(length(vc_10m)/24)*24),24,fix(length(vc_10m)/24) );
% ucD_10m=ucD_10m([1:24 1],:);
% vcD_10m=vcD_10m([1:24 1],:);


%%
mucD_2m=mean(ucD_2m,2);mvcD_2m=mean(vcD_2m,2);
sucD_2m=std(ucD_2m')'/sqrt(size(ucD_2m,2));svcD_2m=std(vcD_2m')'/sqrt(size(ucD_2m,2));
mucD_3m=mean(ucD_3m,2);mvcD_3m=mean(vcD_3m,2);
sucD_3m=std(ucD_3m')'/sqrt(size(ucD_3m,2));svcD_3m=std(vcD_3m')'/sqrt(size(ucD_3m,2));
mucD_4m=mean(ucD_4m,2);mvcD_4m=mean(vcD_4m,2);
sucD_4m=std(ucD_4m')'/sqrt(size(ucD_4m,2));svcD_4m=std(vcD_4m')'/sqrt(size(ucD_4m,2));
mucD_5m=mean(ucD_5m,2);mvcD_5m=mean(vcD_5m,2);
sucD_5m=std(ucD_5m')'/sqrt(size(ucD_5m,2));svcD_5m=std(vcD_5m')'/sqrt(size(ucD_5m,2));
mucD_6m=mean(ucD_6m,2);mvcD_6m=mean(vcD_6m,2);
sucD_6m=std(ucD_6m')'/sqrt(size(ucD_6m,2));svcD_6m=std(vcD_6m')'/sqrt(size(ucD_6m,2));
mucD_7m=mean(ucD_7m,2);mvcD_7m=mean(vcD_7m,2);
sucD_7m=std(ucD_7m')'/sqrt(size(ucD_7m,2));svcD_7m=std(vcD_7m')'/sqrt(size(ucD_7m,2));
mucD_8m=mean(ucD_8m,2);mvcD_8m=mean(vcD_8m,2);
sucD_8m=std(ucD_8m')'/sqrt(size(ucD_8m,2));svcD_8m=std(vcD_8m')'/sqrt(size(ucD_8m,2));
% mucD_10m=mean(ucD_10m,2);mvcD_10m=mean(vcD_10m,2);
% sucD_10m=std(ucD_10m')'/sqrt(size(ucD_10m,2));svcD_10m=std(vcD_10m')'/sqrt(size(ucD_10m,2));
% mucD_9m=mean(ucD_9m,2);mvcD_9m=mean(vcD_9m,2);
% sucD_9m=std(ucD_9m')'/sqrt(size(ucD_9m,2));svcD_9m=std(vcD_9m')'/sqrt(size(ucD_9m,2));

muwD=mean(uwD,2);mvwD=mean(vwD,2);
suwD=std(uwD')'/sqrt(size(uwD,2));svwD=std(vwD')'/sqrt(size(uwD,2));

mTxD=mean(TxD,2);mTyD=mean(TyD,2);
sTxD=std(TxD')'/sqrt(size(TxD,2));sTyD=std(TyD')'/sqrt(size(TyD,2));

%% 
% figure(2);
% clf;
% subplot(3,3,[1 2]);
% errorbar(0:24,muwD,suwD)
% hold on;
% errorbar(0:24,mvwD,svwD);
% title('Wind');
% set(gca,'xlim',[0 24],'xtick',[0:4:24])
% subplot(3,3,[4 5]);
% plot(0:24,mTxD,'color',[0 .3 .6])
% hold on
% plot(0:24,mTyD,'color',[1 0 0]);
% title('Wind Stress');
% set(gca,'xlim',[0 24],'xtick',[0:4:24])
% 
clearvars -except tc tw mTxD mTyD sTxD sTyD ...
     mucD_10m mvcD_10m svcD_10m sucD_10m ...
      mucD_9m mvcD_9m svcD_9m sucD_9m ...
    mucD_8m mvcD_8m svcD_8m sucD_8m ...
    mucD_7m mvcD_7m svcD_7m sucD_7m ...
    mucD_6m mvcD_6m svcD_6m sucD_6m ...
    mucD_5m mvcD_5m svcD_5m sucD_5m ...
    mucD_4m mvcD_4m svcD_4m sucD_4m ...
    mucD_3m mvcD_3m svcD_3m sucD_3m ...
    mucD_2m mvcD_2m svcD_2m sucD_2m ...
    bp_TX bp_TY bp_uw bp_vw ...
     bp_uc_10m bp_vc_10m  bp_uc_9m bp_vc_9m bp_uc_8m bp_vc_8m bp_uc_7m bp_vc_7m bp_uc_6m bp_vc_6m ...
    bp_uc_5m bp_vc_5m bp_uc_4m bp_vc_4m bp_uc_3m bp_vc_3m ...
    bp_uc_2m bp_vc_2m
 save 'rood2.mat'
%%
figure(2);
p1=subplot(3,5,0+gg)
plot(0:24,mTxD,'color',[0 .3 .6])
hold on
plot(0:24,mTyD,'color',[1 0 0]);

p1=subplot(3,5,5+gg)
hold on
plot(0:24,mucD_2m,'LineWidth', 1.5);
plot(0:24,mucD_3m,'LineWidth', 1.5);
plot(0:24,mucD_4m,'LineWidth', 1.5);
plot(0:24,mucD_5m,'LineWidth', 1.5);
plot(0:24,mucD_6m,'LineWidth', 1.5);
plot(0:24,mucD_7m,'LineWidth', 1.5);
plot(0:24,mucD_8m,'LineWidth', 1.5);
legend('u2m','u3m','u4m','u5m','u6m','u7m','u8m')

p1=subplot(3,5,10+gg)
hold on
plot(0:24,mvcD_2m,'LineWidth', 1.5);
plot(0:24,mvcD_3m,'LineWidth', 1.5);
plot(0:24,mvcD_4m,'LineWidth', 1.5);
plot(0:24,mvcD_5m,'LineWidth', 1.5);
plot(0:24,mvcD_6m,'LineWidth', 1.5);
plot(0:24,mvcD_7m,'LineWidth', 1.5);
plot(0:24,mvcD_8m,'LineWidth', 1.5);
legend('v2m','v3m','v4m','v5m','v6m','v7m','v8m')

plot(0:24,(mucD_8m+mucD_4m)/2,0:24,(mvcD_8m+mvcD_4m)/2);

title('Current');
xlabel('Hour');
set(gca,'xlim',[0 24],'xtick',[0:4:24])

subplot(3,3,3);
plot(muwD,mvwD,'-',muwD(25),mvwD(25),'o',muwD(24),mvwD(24),'x');
title('Rotating from x to o');
axis equal
subplot(3,3,6);
plot(mTxD,mTyD,'-',mTxD(25),mTyD(25),'o',mTxD(24),mTyD(24),'x');
axis equal
subplot(3,3,9);
plot(mucD,mvcD,'-',mucD(25),mvcD(25),'o',mucD(24),mvcD(24),'x');
axis equal



































