% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps ]=inputs() 

%System: Fourbar Mechanism
% INPUTS
%Number of links 
n=7;

%Degree of fredom of the system
dof=3;

% Type of mechanism
type=1; % 1 for closed-loop and 0 for open-loop

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1; 1; 1; 1];

%Actuated joints of open tree
aj=[1 0 0 1 0 1 0]; %enter 1 for actuated joints and 0 otherwise


%Time steps and span 
Tp=2; steps=0.01;

% Link lengths
% Subsystem I
a1=0.4; b1=0.6; d1=0.4;
% Subsystem II
a2=0.4; b2=0.6;
% Subsystem III
a3=0.4; b3=0.6;
al=[a1; b1; d1; a2; b2; a3; b3];

%DH PARAMETERs
alp=[0 0 0 0 0 0 0];
a=[0 a1 b1 0 a2 0 a3];
b=[0 0 0 0 0 0 0];
th=[ 1.9814   -2.3099    0.3284   -1.6050   -2.8061    0.5403   -2.5131];
%PARENT ARRAY
bt=[0 1 2 0 4 0 6];

% d - VECTOR FORM ORIGIN TO CG 
dx=[al(1)/2 al(2)/2 0.2      al(4)/2   al(5)/2      al(6)/2     al(7)/2];
dy=[0       0       0.1155       0        0          0          0];
dz=[0       0       0            0        0          0          0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[3; 4; 8; 3; 4; 3; 4];
g=[0; -9.81; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*m(1)*.01*.01;   Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1); 
Icxx(2)=(1/12)*m(2)*.01*.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=(1/12)*m(3)*.01*.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=0.16; %Iczz(3)=(1/12)*m(3)*al(3)*al(3);
Icxx(4)=(1/12)*m(4)*.01*.01;   Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);
Icxx(5)=(1/12)*m(5)*.01*.01;   Icyy(5)=(1/12)*m(5)*al(5)*al(5);  Iczz(5)=(1/12)*m(5)*al(5)*al(5);
Icxx(6)=(1/12)*m(6)*.01*.01;   Icyy(6)=(1/12)*m(6)*al(6)*al(6);  Iczz(6)=(1/12)*m(6)*al(6)*al(6);
Icxx(7)=(1/12)*m(7)*.01*.01;   Icyy(7)=(1/12)*m(7)*al(7)*al(7);  Iczz(7)=(1/12)*m(7)*al(7)*al(7);
