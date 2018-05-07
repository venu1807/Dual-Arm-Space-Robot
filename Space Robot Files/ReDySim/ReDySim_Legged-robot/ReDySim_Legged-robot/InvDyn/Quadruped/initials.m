% ReDySim initials module. The initial conditions are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [yo, ti, tf, incr, rtol, atol, type]=initials()

%NO. OF LINK
s=0;
[thh dthh ddthh xh yh zh dxh dyh dzh]=trajectory(s);
Xh=yh;Yh=zh;Zh=xh;
dXh=dyh;dYh=dzh;dZh=dxh;

%Base motions
q=[Xh; Yh; Zh; (0/180)*pi; (0/180)*pi; (0/180)*pi ];
dq=[dXh; dYh; dZh; 0; 0; 0];
grnden=0; 
acten=0;

%Vecotor of all the initial State Variable
yo=[q;dq; grnden; acten];

%Simulation time and tolerence
ti=0;tf=2;incr=0.01;
atol=1e-06;
rtol=1e-04;
type=1; % '0' for ode45 non stiff solver and '1' for ode15s stiff solver