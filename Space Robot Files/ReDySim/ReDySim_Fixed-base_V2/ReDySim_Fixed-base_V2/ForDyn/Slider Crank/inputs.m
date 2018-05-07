% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System Fourbar Mechanism
%Number of links 
n=3;

%Degree of fredom of the system
dof=1;

%system type
type=1; %1 for Closed-loop and 0 for open-loop

% Link lengths
a1=1; %crank
a2=1; %connecting link
a3=0.5; %output link 
al=[a1, a2, a3];

%DH PARAMETERs
alp=[0 0 pi/2];
a=[0 a1 0];
b=[0 0 2];
th=[-pi/2;    2*pi;    0];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 0];

%PARENT ARRAY
bt=[ 0 1 0];

%Actuated joints of open tree
aj=[1 0 0]; %enter 1 for actuated joints and 0 otherwise


% d - VECTOR FORM ORIGIN TO CG in body fixed frame
dx=[a1/2   a2/2     0];    
dy=[    0     0     0];
dz=[    0     0     0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[1; 1; 0.5];
g=[-9.81; 0; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*m(1)*.01*.01;   Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1); 
Icxx(2)=(1/12)*m(2)*.01*.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=(1/12)*m(3)*.01*.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
end