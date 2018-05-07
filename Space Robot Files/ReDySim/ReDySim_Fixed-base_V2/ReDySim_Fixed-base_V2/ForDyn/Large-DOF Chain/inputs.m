% ReDySim input module.The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System Large-DOF Serial chain
%Number of links 
n=20;

%Degree of fredom of the system
dof=n;

%system type
type=0; %1 for Closed-loop and 0 for open-loop

for i=1:n
% Link lengths
al(i)=0.03; 

%DH PARAMETERs
alp(i)=0;
a(i)=0.03;
b(i)=0;
%PARENT ARRAY
bt(i)=i-1;
th(i)=0;

%Enter joint type , r=1 if revolute and r=0 if prismatic
r(i)=1;


%Actuated joints of open tree
aj(i)=1; %enter 1 for actuated joints and 0 otherwise

% d - VECTOR FORM ORIGIN TO CG 
dx(i)=al(i)/2;   % all X coordinates
dy(i)=0;         % all Y coordinates
dz(i)=0;         % all Z coordinates

% MASS AND MOMENT OF INERTIA
m(i)=0.05;

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxy(i)=0;Icyz(i)=0;Iczx(i)=0; 
Icxx(i)=(1/12)*m(i)*.01*.01;   
Icyy(i)=(1/12)*m(i)*al(i)*al(i);  
Iczz(i)=(1/12)*m(i)*al(i)*al(i); 
end

al(1)=0; % Due to modified DH parameters 
% GRAVITY
g=[0; -9.81; 0];
% g=[0; 0; 0];