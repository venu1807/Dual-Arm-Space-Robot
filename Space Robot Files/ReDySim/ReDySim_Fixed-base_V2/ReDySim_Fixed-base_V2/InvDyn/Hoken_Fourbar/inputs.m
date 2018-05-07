% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps ]=inputs() 

%System: Fourbar Mechanism
% INPUTS
%Number of links 
n=3;

%Degree of fredom of the system
dof=1;

% Type of mechanism
type=1; % 1 for closed-loop and 0 for open-loop

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1];

%Actuated joints of open tree
aj=[1 0 0]; %enter 1 for actuated joints and 0 otherwise


%Time steps and span 
Tp=4/3; steps=0.01;

% Link lengths
a1=0.038; %crank
a2=0.1152;%output link 
a3=0.1152;%connecting link
a4=0.0895;%fixed base
al=[a1, a2, a3, a4];

%DH PARAMETERs
alp=[0 0 0];
a=[0 -a4 a2];
b=[0 0 0];
th=[0    0.9844    4.3144];
%PARENT ARRAY
bt=[ 0 0 2];

% d - VECTOR FORM ORIGIN TO CG 
dx=[a1/2   a2/2      a3/2];    
dy=[    0     0     0];
dz=[    0     0     0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[1.5; 3; 5];
g=[0; -9.81; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*m(1)*.01*.01;   Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1); 
Icxx(2)=(1/12)*m(2)*.01*.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=(1/12)*m(3)*.01*.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
