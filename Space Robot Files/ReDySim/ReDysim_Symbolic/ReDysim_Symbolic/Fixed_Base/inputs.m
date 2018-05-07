% ReDySim inputs module. 
% Model parameters for fixed-base system are entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [q,dq,ddq,n,alp,a,bb,thh,bt,r,dx,dy,dz,m,gr,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx]=inputs()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declaration of the symbolic variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variable joint angles and their derivatives (When joint is revolute)
syms th1 th2 th3 th4 th5 th6 th7
syms dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms ddth1 ddth2 ddth3 ddth4 ddth5 ddth6 ddth7 
% Variable joint offsets and their derivatives (When joint is prismatic)
syms b1 b2 b3 b4 b5 b6b7
syms db1 db2 db3 db4 db5 db6 db7
syms ddb1 ddb2 ddb3 ddb4 ddb5 ddb6
% vector connecting origin and centre-of-mass of the link
syms d1x d2x d3x d4x d5x d6x d7x
syms d1y d2y d3y d4y d5y d6y d7y
syms d1z d2z d3z d4z d5z d6z d7z
% Gravitational Acceleratoin
syms g
% Mass
syms m1 m2 m3 m4 m5 m6
% Inertia tensors
syms I1x I2x I3x I4x I5x I6x
syms I1y I2y I3y I4y I5y I6y
syms I1z I2z I3z I4z I5z I6z
syms a1 a2 a3 a4 a5 a6 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Enter DH parameters and Inertia propoerties below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%System: 2-link manipulator (Craig pg 180)
%Number of links
n=2;
%Enter DH parameters, i.e., (alp a b th), below
alp=[0; 0];% Enter in degree 
a=[0; a1];
bb=[0; 0];
thh=[th1; th2];
%Parent of each link
bt=[0 1];
%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1 1];
%Mass of each link
m=[m1 m2];
% gr, Gravitational acceleration in inertial frame
gr=[0 ; g; 0];
% di,a vector form the origin Ok to Center of mass (COM), Ck, for k=i,..,n
dx=[d1x d2x];
dy=[0   0];
dz=[0   0];
%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
Icxx=[I1x; I2x];
Icyy=[I1y; I2y];
Iczz=[I1z; I2z];
%Variables DH parameters: Joint angles or joint offset
q=[th1 th2];
dq=[dth1 dth2];
ddq=[ddth1 ddth2];

