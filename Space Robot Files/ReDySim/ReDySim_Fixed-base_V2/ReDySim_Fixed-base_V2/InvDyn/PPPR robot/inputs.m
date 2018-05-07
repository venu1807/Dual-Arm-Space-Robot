% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps ]=inputs() 

%System: Robotic Gripper
% INPUTS
%Number of links 
n=4;

%Degree of fredom of the system
dof=4;

% Type of mechanism
type=0; % 1 for closed-loop and 0 for open-loop

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[0; 0; 0; 1];

%Actuated joints of open tree
aj=[1 1 1 1]; %enter 1 for actuated joints and 0 otherwise


%Time steps and span 
Tp=1; steps=0.01;

% Link lengths
al=[0.1; 0.1; 0.1; 0.1];

%DH PARAMETERs
alp=[0;-pi/2; pi/2; pi/2];
b=[0.05; 0.05; 0.05; 0];
a=[0; 0; 0; 0];
th=[0; 0; pi/2; 0];

%PARENT ARRAY
bt=[0 1 2 3];

% d - VECTOR FORM ORIGIN TO CG 
dx=[0;       0;       0;       0];
dy=[0;       0;       0;       al(4)/2];
dz=[-al(1)/2; -al(2)/2; -al(3)/2; 0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[0.5; 0.5; 0.5; 0.5];
g=[-9.81; 0;0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1);
Icxx(1)=(1/12)*m(1)*al(1)*al(1);  Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=0;
Icxx(2)=(1/12)*m(2)*al(2)*al(2);  Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=0;
Icxx(3)=(1/12)*m(3)*al(3)*al(3);  Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=0;
Icxx(4)=0;  Icyy(4)=(1/12)*m(4)*al(4)*al(4); Iczz(4)=(1/12)*m(4)*al(4)*al(4);
