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
%System: KUKA KR5 (with all numerical values except joint variables)
%Number of links
n=6;
%Enter DH parameters, i.e., (alp a b th), below
alp=[0; 90; 0;90; -90; 0];% Enter in degree 

a=[0; a2; a3;0; 0; 0];
bb=[0; 0; 0;b4; 0; 0];
thh=[th1; th2; th3;th4; th5; th6];
%Parent of each link
bt=[0 1 2 3 4 5];
%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1 1 1 1 1 1];
%Mass of each link
m=[16.038;  7.988;  12.973  ; 2.051  ;  0.811  ; 0.008 ];
% g, Gravitational acceleration in inertial frame
gr=[0 ; 0; -9.81];
% di,a vector form the origin Ok to Center of mass (COM), Ck, for k=i,..,n
dx=[ .104, .267,   .087,     0,      0,    0 ];
dy=[ .005,    0,  -.034,  .007,   .032,    0 ];
dz=[ .059,    0,   .007, -.109,  -.009, .111 ];
%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
Icxx(1)=.176  ;  Icyy(1)=.266 ;  Iczz(1)=.262 ;
Icxx(2)=.271 ;  Icyy(2)=.276 ;  Iczz(2)=.21  ;
Icxx(3)=.388 ;  Icyy(3)=.376 ;  Iczz(3)=.104  ;
Icxx(4)=.004   ;  Icyy(4)=0.010   ;  Iczz(4)=.012   ;
Icxx(5)=.0007    ;  Icyy(5)=0.0017   ;  Iczz(5)=.0018   ;
Icxx(6)=3*1e-6      ;  Icyy(6)=1*1e-6      ;  Iczz(6)=1*1e-6      ;

%Variables DH parameters: Joint angles or joint offset
q=[th1 th2 th3 th4 th5 th6];
dq=[dth1 dth2 dth3 dth4 dth5 dth6];
ddq=[ddth1 ddth2 ddth3 ddth4 ddth5 ddth6];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %System: KUKA KR5 (with all symbolic variables)
% %Number of links
% n=6;
% %Enter DH parameters, i.e., (alp a b th), below
% alp=[0; 90; 0;90; -90; 0];% Enter in degree 
% a=[0; a2; a3;0; 0; 0];
% bb=[0; 0; 0;b4; 0; 0];
% thh=[th1; th2; th3;th4; th5; th6];
% %Parent of each link
% bt=[0 1 2 3 4 5];
% %Enter joint type , r=1 if revolute and r=0 if prismatic
% r=[1 1 1 1 1 1];
% %Mass of each link
% m=[m1 m2 m3 m4 m5 m6];
% % g, Gravitational acceleration in inertial frame
% gr=[0 ; 0; g];
% % di,a vector form the origin Ok to Center of mass (COM), Ck, for k=i,..,n
% dx=[d1x; d2x; d3x;d4x; d5x; d6x];
% dy=[d1y; d2y; d3y;d4y; d5y; d6y];
% dz=[d1z; d2z; d3z;d4z; d5z; d6z];
% %Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
% %which is rigid attach to the link
% Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
% Icxx=[I1x; I2x; I3x;I4x; I5x; I6x];
% Icyy=[I1x; I2y; I3y;I4x; I5y; I6y];
% Iczz=[I1z; I2z; I3z;I4z; I5z; I6z];
% %Variables DH parameters: Joint angles or joint offset
% q=[th1 th2 th3 th4 th5 th6];
% dq=[dth1 dth2 dth3 dth4 dth5 dth6];
% ddq=[ddth1 ddth2 ddth3 ddth4 ddth5 ddth6];