% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [thi, dthi, ddthi]= trajectory(t, dof, Tp)
%In the case of 3RRR robot platform motion is provided as input 

%Enter trejectories here
%Dimention of equilateral outer triangle form by the base.
bb=1; hh=bb*sin(pi/3);
%Dimention of equilateral triangle form the end effector.
b=0.4;h=b*sin(pi/3);hc=2/3*h;

%platform roatation
alpi=0;
dalp0=0;
ddalp0=0;
alp0=alpi+t*dalp0;


%Platform position
%Center of outer trinagle
xc=bb/2;
yc=1/3*hh;
%Radius represenbting the distennce from COM of outer triangle and
%end-effectorr trinagle
r=1/8*hh;
thri=0;
dthr=4;
ddthr=0;
thr=thri+t*dthr;

%Base or end-effector
%Position
x0=xc+r*cos(thr);
y0=yc+r*sin(thr);
%Velocity
dx0=-r*sin(thr)*dthr;
dy0=r*cos(thr)*dthr;
%Aceeleration
ddx0=-r*sin(thr)*ddthr-r*cos(thr)*dthr*dthr;
ddy0=r*cos(thr)*ddthr-r*sin(thr)*dthr*dthr;


thi=[x0 y0 alp0];
dthi=[dx0 dy0 dalp0];
ddthi=[ddx0 ddy0 ddalp0];