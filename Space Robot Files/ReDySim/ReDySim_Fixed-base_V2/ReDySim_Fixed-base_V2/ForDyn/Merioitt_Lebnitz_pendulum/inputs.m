% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: ML pendulum
%Number of links 
n=2;

%Degree of fredom of the system
dof=2;

%system type
type=0; %1 for Closed-loop and 0 for open-loop

% Link lengths
al=[0.36;.18]; 

%DH PARAMETERs
alp=[0;pi/2];
a=[0.2;0];
b=[0;0.17];
th=[0;pi/6];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1];

%PARENT ARRAY
bt=[0;1];

%Actuated joints of open tree
aj=[1 1]; %enter 1 for actuated joints and 0 otherwise


% d - VECTOR FORM ORIGIN TO CG 
dx=[0,-.18];   % all X coordinates
dy=[0.19,0];         % all Y coordinates
dz=[0,0];         % all Z coordinates

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[1;1.1176];
g=[-9.81; 0; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=0;   Icyy(1)=0;  Iczz(1)=0;
Icxx(2)=0;   Icyy(2)=0;  Iczz(2)=0;

end