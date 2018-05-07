% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: Mutli closed-loop robotic leg
%Number of links 
n=7;

%Degree of fredom of the system
dof=1;

%system type
type=1; %1 for Closed-loop and 0 for open-loop

% Link lengths
% Hoken's mechnisam;
a1=0.025; %crank
a2=0.0625; %output link 
a3=0.125; %connecting link
%Parallelogram amplifier
a4=0.200; a5=0.075; a6=0.300; a7=0.150;
a45=0.050; a67=0.075; 
al=[a1, a2, a3, a4, a5, a6, a7];

%DH PARAMETERs
alp=[0 0 0 0 0 0 0];
a=[0 0 a2 0 a45 a4 a67];
b=[0 0 0 0 0 0 0];
th=[0;  4.5110;  -2.7389;  -0.8764;  -1.4604;  -1.4604;  -1.6812];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1; 1; 1; 1];

%PARENT ARRAY
bt=[0 0 2 0 4 4 6];

%Actuated joints of open tree
aj=[1 0 0 0 0 0 0]; %enter 1 for actuated joints and 0 otherwise

% d - VECTOR FORM ORIGIN TO CG 
dx=[a1/2   a2/2  0  a4/2 a5/2 a6/2 a7/2];    
dy=[ 0     0     0  0    0    0    0];
dz=[ 0     0     0  0    0    0    0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m =[ 0.0047; 0.0117; 0.0234; 0.0374; 0.0140; 0.0562; 0.0281];
g=[0; -9.81; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*m(1)*.01*.01;   Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1); 
Icxx(2)=(1/12)*m(2)*.01*.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=(1/12)*m(3)*.01*.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
Icxx(4)=(1/12)*m(4)*.01*.01;   Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);
Icxx(5)=(1/12)*m(5)*.01*.01;   Icyy(5)=(1/12)*m(5)*al(5)*al(5);  Iczz(5)=(1/12)*m(5)*al(5)*al(5);
Icxx(6)=(1/12)*m(6)*.01*.01;   Icyy(6)=(1/12)*m(6)*al(6)*al(6);  Iczz(6)=(1/12)*m(6)*al(6)*al(6);
Icxx(7)=(1/12)*m(7)*.01*.01;   Icyy(7)=(1/12)*m(7)*al(7)*al(7);  Iczz(7)=(1/12)*m(7)*al(7)*al(7);
end