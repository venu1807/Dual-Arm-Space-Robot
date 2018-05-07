% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [a0 a1 d1x d2x m0 m1 m2 I0z I1z I2z I0y I1y I2y I0x I1x I2x]=inputs()

% 3 Link Manipulator
%NO. OF LINKS
n=3;

nq=0;%1 for spatial and 0 for planar
%ENTER DH PARAMETER HERE   
%  dh=[al b alp th];
alp=[0; 0; 0; 0];
a0=1;
a1=1;

b=[0; 0; 0; 0];
%Parent array bt and corrosponding vectors
bt=[0 1 2 3];

%Link Length
al=[1; 1; 1; 1];
% %Distance from origin to link tip in term of link length
alt=[0.5; 1; 1; 1];

%ENTER VECTOR dm
d1x=al(2)/2;
d2x=al(3)/2;
dx=[d1x d2x];
dy=[  0       0       0       0  ];
dz=[  0       0       0       0  ];


%MASS
m0=500;
m1=10;
m2=10;

% [m0; m1; m2]=[500; 10; 10];
m=[m0; m1; m2];
% g=[0 ; -9.81; 0];
g=[0 ; 0; 0];

%MOMENT OF INERTIA
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
% Icxx(1)=(1/12)*0.01*0.01;   Icyy(1)=(1/12)*m(1)*(al(1)*al(1)+0.1*0.1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1);
% Icxx(2)=(1/12)*0.01*0.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
% Icxx(3)=(1/12)*0.01*0.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
% Icxx(4)=(1/12)*0.01*0.01;   Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);

Icxx(1)=83.61;  Icyy(1)=83.61; Iczz(1)=83.61;
Icxx(2)=0.01;   Icyy(2)=1.05;  Iczz(2)=1.05;
Icxx(3)=0.01;   Icyy(3)=1.05;  Iczz(3)=1.05;

I0z=83.61;I0y=83.61;I0x=83.61;
I1z=1.05;I1y=1.05;I1x=0.01;
I2z=1.05;I2y=1.05;I2x=0.01;


% Icxx=[I0x; I1x; I2x];
% Icyy=[I0y; I1y; I2y];
% [I0z; I1z; I2z]=[Iczz(1);Iczz(2);Iczz(3)];
% [I0y; I1y; I2y]=[Iczz(1);Iczz(2);Iczz(3)];
% [I0x; I1x; I2x]=[Iczz(1);Iczz(2);Iczz(3)];



