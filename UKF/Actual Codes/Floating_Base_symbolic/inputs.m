% ReDySim inputs module. 
% Model parameters for the floting-base robotic systems are entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [q th n alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx]=inputs()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declaration of the symbolic variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variable base motoin and joint angles, and their derivatives
syms x0 y0 z0 ph0 th0 si0
syms dx0 dy0 dz0 dph0 dth0 dsi0 
syms ddx0 ddy0 ddz0 ddph0 ddth0 ddsi0 
syms th1 th2 th3 th4 th5 th6 th7
syms dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms ddth1 ddth2 ddth3 ddth4 ddth5 ddth6 ddth7 
% Vector connecting origin and centre-of-mass of the link
syms d0x d1x d2x d3x d4x d5x d6x d7x
syms d0y d1y d2y d3y d4y d5y d6y d7y
syms d0z d1z d2z d3z d4z d5z d6z d7z
% Gravitational Acceleratoin
syms g
% Mass
syms m0 m1 m2 m3 m4 m5 m6
% Inertia tensors
syms I0x I1x I2x I3x I4x I5x I6x
syms I0y I1y I2y I3y I4y I5y I6y
syms I0z I1z I2z I3z I4z I5z I6z
syms a0 a1 a2 a3 a4 a5 a6 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Enter DH parameters and Inertia propoerties below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3 Link Manipulator
%NO. OF LINKS
n=3;
nq=0;%1 for spatial and 0 for planar
%ENTER DH PARAMETER HERE   
%  dh=[al b alp th];
alp=[0; 0; 0]; % Enter in degree 
a=[0; a0/2; a1];
b=[0; 0; 0];
%Parent array bt and corrosponding vectors
bt=[0 1 2];

%ENTER VECTOR dm
dx=[ 0   d1x  d2x];
dy=[ 0    0     0];
dz=[ 0    0     0];

%MASS
m=[m0; m1; m2];
g=[0 ; 0; 0];

%MOMENT OF INERTIA
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
Icxx=[I0x; I1x; I2x];
Icyy=[I0y; I1y; I2y];
Iczz=[I0z; I1z; I2z];

%Variables base motoins and joint angeles 
q=[x0; y0; 0; ph0; 0; 0]; 
dq=[dx0; dy0; 0; dph0; 0; 0];
ddq=[ddx0; ddy0; 0; ddph0; 0; 0];
th=[0; th1; th2]';
dth=[0; dth1; dth2];
ddth=[0; ddth1; ddth2];
