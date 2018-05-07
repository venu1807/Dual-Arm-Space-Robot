% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: Spatial Biped
%Number of links 
n=12;

%Degree of fredom of the system
dof=n;

%system type
type=0; %1 for Closed-loop and 0 for open-loop

% Link lengths
al=[0; 0.5; 0.5; 0; 0; 0.1; 0; 0; 0.5; 0.5; 0; 0.15];

%DH PARAMETERs
alp=[0; pi/2; -pi/2; 0; pi/2; pi/2; pi; pi/2; pi/2; 0; -pi/2; pi/2];
a=[0; 0; 0.5; 0.5; 0; 0;-0.1; 0; 0; 0.5; 0.5; 0];
b=[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
th=[-0.2089; 0; 0.7410; -0.5321; -1.5708; 3.1416; 0; -1.5708; -0.2089; 0.7410; 0; -0.5321];
%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];

%PARENT ARRAY
bt=[0 1 2 3 4 5 6 7 8 9 10 11];

%Actuated joints of open tree
aj=[1 1 1 1 1 1 1 1 1 1 1 1]; %enter 1 for actuated joints and 0 otherwise


% d - VECTOR FORM ORIGIN TO CG 
dx=[al(1)/2 al(2)/2 al(3)/2 al(4)/2 al(5)/2 -al(6)/2 al(7)/2 al(8)/2 al(9)/2 al(10)/2 al(11)/2 0];    
dy=[0       0       0       0       0        0       0       0        0       0        0        0];
dz=[0       0       0       0       0        -0.1/2   0       0        0       0        0        0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[0 1 1 0 0 5 0 0 1 1 0 0.2];
g=[-9.81; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(2)=0;   Icyy(2)=(1/12)*m(2)*al(2)*al(2); Iczz(2)=Icyy(2);
Icxx(3)=0;   Icyy(3)=(1/12)*m(3)*al(3)*al(3); Iczz(3)=Icyy(3);
Icxx(6)=(1/12)*m(6)*0.1*0.1;   Icyy(6)=(1/12)*m(6)*(0.1*0.1+al(6)*al(6)); Iczz(6)=(1/12)*m(6)*al(6)*al(6);
Icxx(9)=0;   Icyy(9)=(1/12)*m(9)*al(9)*al(9); Iczz(9)=Icyy(9);
Icxx(10)=0;   Icyy(10)=(1/12)*m(10)*al(10)*al(10); Iczz(10)=Icyy(10);
Icxx(12)=(1/12)*m(12)*al(12)*al(12);   Icyy(12)=(1/12)*m(12)*0.01*0.01; Iczz(12)=(1/12)*m(12)*al(12)*al(12);
end