% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [thh dthh ddthh xh yh zh dxh dyh dzh]=trajectory(s)
% %Quadruped-In this program hip trjectories are found using IPM whlie joint
% %trejectories by direct relation ships

%Trejectories
Ts=1;  %time interval for one step
%shank and thigh length and angles
sl2=0.3;tl2=0.3;tl1=0.3;sl1=0.3;
xi=-0.15;
% ofs=0.1;%offste requre in y direction on the both side
% yi=-0.06;
zc=0.5;
gg=9.81;w=sqrt(gg/zc);%w=sqrt(g(2)/zc);
hf=0.09;%max foot-tip height
Sl=0.3;%stride
wf=pi/Ts;
%Step size, cycle time, and max lift of the foot
% step=0.01;

% Biped Trajectories
% Main for loop starts
ti=s;
% i=1;
% for ti=0:step:Tfi
if rem(ti,Ts)~= 0
    t=rem(ti,Ts);
    chk=ceil(ti/Ts);
elseif ti==0
    t=0;
    chk=1;
else
    t=Ts;
    chk=ti/Ts;
end

%Leg 1 foot trajectory generation
%X, dX, ddX
xt1=-Sl*cos(wf*t);
dxt1=wf*Sl*sin(wf*t);
ddxt1=wf*wf*Sl*cos(wf*t);
zt1=(hf/2)*(1-cos(2*wf*t));
dzt1=(2*wf)*(hf/2)*(sin(2*wf*t));
ddzt1=(2*wf)*(2*wf)*(hf/2)*(cos(2*wf*t));

%Leg 2 foot trajectory generation
%X, dX, ddX
xt2=0;
dxt2=0;
ddxt2=0;
%Y, dY, ddY
zt2=0;
dzt2=0;
ddzt2=0;

%Hip trajectory generation
%X, dX, ddX
dxi=((1+exp(w*Ts))/(1-exp(w*Ts)))*xi*w;
Co1=0.5*(xi+(dxi/w));Co2=0.5*(xi-(dxi/w));
xh=Co1*exp(w*t)+Co2*exp(-w*t);
dxh=w*Co1*exp(w*t)-w*Co2*exp(-w*t);
ddxh=w*w*(Co1*exp(w*t)+Co2*exp(-w*t));

zh=zc;
dzh=0;
ddzh=0;

%Y Only for spatial case
% if rem(chk,2)==1
%     yi=-yi;
%     yii=-yi;
%     dyi=((1-exp(w*Ts))/(1+exp(w*Ts)))*yi*w;
%     Co3=0.5*(yi+(dyi/w));Co4=0.5*(yi-(dyi/w));
%     yh=yii+Co3*exp(w*t)+Co4*exp(-w*t);
%     dyh=w*Co3*exp(w*t)-w*Co4*exp(-w*t);
%     ddyh=w*w*(Co3*exp(w*t)+Co4*exp(-w*t));
% else
%     yii=-yi;
%     dyi=((1-exp(w*Ts))/(1+exp(w*Ts)))*yi*w;
%     Co3=0.5*(yi+(dyi/w));Co4=0.5*(yi-(dyi/w));
%     yh=yii+Co3*exp(w*t)+Co4*exp(-w*t);
%     dyh=w*Co3*exp(w*t)-w*Co4*exp(-w*t);
%     ddyh=w*w*(Co3*exp(w*t)+Co4*exp(-w*t));
%
% end
yh=0;
dyh=0;
ddyh=0;

yt1=0;dyt1=0;ddyt1=0;
yt2=0;dyt2=0;ddyt2=0;

% inverse position analysis
%Leg 1 inverse kinamatics
%th2
th2=pi/2; dth2=0; ddth2=0;
%th1
alp1=atan2(yh-yt2,zh);
dalp1=(dyh-dyt2)*cos(alp1)*cos(alp1)/zh;
ddalp1=((ddyh-ddyt2)*cos(alp1)*cos(alp1)/zh)-2*tan(alp1)*dalp1;
th1=alp1;
dth1=dalp1;
ddth1=ddalp1;

%th6
th6=-th1;
dth6=-dth1;
ddth6=-ddth1;
%lo
lo1s=(xh-xt2)*(xh-xt2)+(yh-yt2)*(yh-yt2)+(zh-zt2)*(zh-zt2);
lo1=sqrt(lo1s);
dlo1=((xh-xt2)*(dxh-dxt2)+(yh-yt2)*(dyh-dyt2)+(zh-zt2)*(dzh-dzt2))/lo1;
ddlo1=((xh-xt2)*(ddxh-ddxt2)+(yh-yt2)*(ddyh-ddyt2)+(zh-zt2)*(ddzh-ddzt2)+...
    (dxh-dxt2)*(dxh-dxt2)+(dyh-dyt2)*(dyh-dyt2)+(dzh-dzt2)*(dzh-dzt2)-dlo1*dlo1)/lo1;
%alp4,th4
alp4=acos((lo1*lo1-tl1*tl1-sl1*sl1)/(2*sl1*tl1));
dalp4=-(lo1*dlo1)/(sin(alp4)*sl1*tl1);
ddalp4=-(lo1*ddlo1+dlo1*dlo1)/(sin(alp4)*sl1*tl1)-cot(alp4)*dalp4*dalp4;
th4=-alp4;
dth4=-dalp4;
ddth4=-ddalp4;
%gama1
gama1=asin(tl1*sin(alp4)/lo1);
dgama1=(tl1*cos(alp4)*dalp4-dlo1*sin(gama1))/(lo1*cos(gama1));
ddgama1=(tl1*(cos(alp4)*ddalp4-sin(alp4)*dalp4*dalp4)+...
    (lo1*dgama1*dgama1-ddlo1)*sin(gama1)-2*dlo1*cos(gama1)*dgama1)/(lo1*cos(gama1));
%bita1
bita1=asin((xh-xt2)/lo1);
dbita1=((dxh-dxt2)/(lo1*cos(bita1)))-(dlo1/lo1)*tan(bita1);
ddbita1=((ddxh-ddxt2)/(lo1*cos(bita1)))-((ddlo1/lo1)-dbita1*dbita1)*tan(bita1)-2*(dlo1/lo1)*dbita1;
%th3
th3=alp4-(gama1+bita1);
dth3=dalp4-(dgama1+dbita1);
ddth3=ddalp4-(ddgama1+ddbita1);
%th5
th5=bita1+gama1;
dth5=dbita1+dgama1;
ddth5=ddbita1+ddgama1;

%Leg 2
%th8
th8=pi/2; dth8=0; ddth8=0;
%th7
alp7=atan2(yh-yt1,zh);
dalp7=(dyh-dyt1)*cos(alp7)*cos(alp7)/zh;
ddalp7=((ddyh-ddyt1)*cos(alp7)*cos(alp7)/zh)-2*tan(alp7)*dalp7;

%th12
th7=alp7;
dth7=dalp7;
ddth7=ddalp7;

%th12
th12=-th7;
dth12=-dth7;
ddth12=-ddth7;
%lo2
lo2s=(xh-xt1)*(xh-xt1)+(yh-yt1)*(yh-yt1)+(zh-zt1)*(zh-zt1);
lo2=sqrt(lo2s);
dlo2=((xh-xt1)*(dxh-dxt1)+(yh-yt1)*(dyh-dyt1)+(zh-zt1)*(dzh-dzt1))/lo2;
ddlo2=((xh-xt1)*(ddxh-ddxt1)+(yh-yt1)*(ddyh-ddyt1)+(zh-zt1)*(ddzh-ddzt1)+...
    (dxh-dxt1)*(dxh-dxt1)+(dyh-dyt1)*(dyh-dyt1)+(dzh-dzt1)*(dzh-dzt1)-dlo2*dlo2)/lo2;
%alp10,th10
alp10=acos((lo2*lo2-tl2*tl2-sl2*sl2)/(2*sl2*tl2));
dalp10=-(lo2*dlo2)/(sin(alp10)*sl2*tl2);
ddalp10=-(lo2*ddlo2+dlo2*dlo2)/(sin(alp10)*sl2*tl2)-cot(alp10)*dalp10*dalp10;
th10=-alp10;
dth10=-dalp10;
ddth10=-ddalp10;
%gama2
gama2=asin(tl2*sin(alp10)/lo2);
dgama2=(tl2*cos(alp10)*dalp10-dlo2*sin(gama2))/(lo2*cos(gama2));
ddgama2=(tl2*(cos(alp10)*ddalp10-sin(alp10)*dalp10*dalp10)+...
    (lo2*dgama2*dgama2-ddlo2)*sin(gama2)-2*dlo2*cos(gama2)*dgama2)/(lo2*cos(gama2));
%bita2
bita2=asin((xh-xt1)/lo2);
dbita2=((dxh-dxt1)/(lo2*cos(bita2)))-(dlo2/lo2)*tan(bita2);
ddbita2=((ddxh-ddxt1)/(lo2*cos(bita2)))-((ddlo2/lo2)-dbita2*dbita2)*tan(bita2)-2*(dlo2/lo2)*dbita2;
%th9
th9=alp10-(gama2+bita2);
dth9=dalp10-(dgama2+dbita2);
ddth9=ddalp10-(ddgama2+ddbita2);
%th11
th11=bita2+gama2;
dth11=dbita2+dgama2;
ddth11=ddbita2+ddgama2;

if rem(chk,2)==1
    ath3=th3;
    ath4=th4;
    ath5=th5;
    ath9=th9;
    ath10=th10;
    ath11=th11;
    
    ath1=th1;
    ath6=th6;
    ath7=th7;
    ath12=th12;
    dath3=dth3;
    dath4=dth4;
    dath5=dth5;
    dath9=dth9;
    dath10=dth10;
    dath11=dth11;
    dath1=dth1;
    dath6=dth6;
    dath7=dth7;
    dath12=dth12;
    ddath3=ddth3;
    ddath4=ddth4;
    ddath5=ddth5;
    ddath9=ddth9;
    ddath10=ddth10;
    ddath11=ddth11;
    ddath1=ddth1;
    ddath6=ddth6;
    ddath7=ddth7;
    ddath12=ddth12;
else
    ath3=th9;
    ath4=th10;
    ath5=th11;
    ath9=th3;
    ath10=th4;
    ath11=th5;
    ath1=th6;
    ath6=th1;
    ath7=th12;
    ath12=th7;
    dath3=dth9;
    dath4=dth10;
    dath5=dth11;
    dath9=dth3;
    dath10=dth4;
    dath11=dth5;
    dath1=dth6;
    dath6=dth1;
    dath7=dth12;
    dath12=dth7;
    ddath3=ddth9;
    ddath4=ddth10;
    ddath5=ddth11;
    ddath9=ddth3;
    ddath10=ddth4;
    ddath11=ddth5;
    ddath1=ddth6;
    ddath6=ddth1;
    ddath7=ddth12;
    ddath12=ddth7;
end
ath2=th2;ath8=th8;
dath2=dth2;dath8=dth8;
ddath2=ddth2;ddath8=ddth8;

%spatial
thh1=ath1;   dthh1=dath1;    ddthh1=ddath1;
thh2=ath2;   dthh2=dath2;    ddthh2=ddath2;
thh3=ath3;   dthh3=dath3;    ddthh3=ddath3;
thh4=ath4;   dthh4=dath4;    ddthh4=ddath4;
thh5=ath5;   dthh5=dath5;    ddthh5=ddath5;
thh6=ath6;   dthh6=dath6;    ddthh6=ddath6;
thh7=ath7;   dthh7=dath7;    ddthh7=ddath7;
thh8=ath8;   dthh8=dath8;    ddthh8=ddath8;
thh9=ath9;   dthh9=dath9;    ddthh9=ddath9;
thh10=ath10; dthh10=dath10;  ddthh10=ddath10;
thh11=ath11; dthh11=dath11;  ddthh11=ddath11;
thh12=ath12; dthh12=dath12;  ddthh12=ddath12;

%     i=i+1;
% end
% ti=0:step:Tfi;
thh=[0;  -pi/2; thh3; thh4; -pi/2; thh9; thh10; -pi/2; thh9; thh10; -pi/2; thh3; thh4];
dthh=[0; 0; dthh3; dthh4; 0; dthh9; dthh10; 0; dthh9; dthh10; 0; dthh3; dthh4];
ddthh=[0; ddthh3; ddthh4; 0; ddthh9; ddthh10; 0; ddthh9; ddthh10; 0; ddthh3; ddthh4];
% set(0,'DefaultLineLineWidth',2.5)
% figure(12)
% r2d=180/pi;
% %Foot stationalary
% % plot(ti,thh1*r2d,ti,thh2*r2d,ti,thh3*r2d,ti,thh4*r2d,ti,thh5*r2d,ti,thh6*r2d)
% % Foot moving
% % plot(ti,thh7*r2d,ti,thh8*r2d,ti,thh9*r2d,ti,thh10*r2d,ti,thh11*r2d,ti,thh12*r2d)
% plot(ti,thh3*r2d,ti,thh4*r2d,ti,thh9*r2d,ti,thh10*r2d)
