% ReDySim initials module. The initial conditions are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [yo, t_initial, t_final, incr, rtol, atol, type]=initials()

%Inverse kinematics for obtaining initial configuration
s=0;
[thh dthh ddthh xh yh zh dxh dyh dzh]=trajectory(s);
Xh=xh;Yh=zh;Zh=yh;
dXh=dxh;dYh=dzh;dZh=dyh;

%Base motions
q=[Xh; Yh; Zh; (0/180)*pi; (0/180)*pi; (0/180)*pi ];
dq=[dXh; dYh; dZh; 0; 0; 0];

% Joint variables
th=thh;
dth=dthh;
grnden=0; 
acten=0;
qq=q;
dqq=dq;
n=length(th);
%Vecotor of all the initial State Variable
% yo=[q; th(2:n) ;dq;dth(2:n); grnden; acten];
yo=[q; th(2:n) ;dq;dth(2:n); grnden; acten;qq;dqq];

%Simulation time and tolerence
t_initial=0;
t_final=2;
incr=0.01;

%INTERATION TOLERANCES
rtol=1e-4;         %relative tolerance in integration 
atol=1e-6;         %absolute tolerances in integration 
type=1;            % 0 for ode45 and 1 for ode15s