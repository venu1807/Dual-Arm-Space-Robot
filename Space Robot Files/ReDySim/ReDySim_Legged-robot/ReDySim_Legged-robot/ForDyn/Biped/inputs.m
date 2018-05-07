% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs()

% 5 Link Biped
%NO. OF LINK
n=7;
nq=1;%1 for spatial and 0 for planar
%ENTER DH PARAMETER HERE   
%  dh=[al b alp th];
alp=[0; 0; 0; 0; 0; 0; 0];
a=[0; 0.25; 0.5; 0.5; 0.25; 0.5; 0.5];
b=[0; 0; 0; 0; 0; 0; 0];
%Parent array bt and corrosponding vectors
bt=[0 1 2 3 1 5 6];


%Link Length
al=[0.5; 0.5; 0.5; 0.15; 0.5; 0.5; 0.15];
% %Distance from origin to link tip in term of link length
alt=[0.25; 0.5; 0.5; 0.075; 0.5; 0.5; 0.075];

%ENTER VECTOR rm
dx=[     0     al(2)/2 al(3)/2     0  al(5)/2  al(6)/2      0  ];
dy=[     0         0       0       0       0        0       0      ];
dz=[     0         0       0       0       0        0       0     ];


%MASS
m=[5; 1; 1; 0.2; 1; 1; 0.2];
g=[0 ; -9.81; 0];

%MOMENT OF INERTIA
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*0.1*0.1;   Icyy(1)=(1/12)*m(1)*(al(1)*al(1)+0.1*0.1);  Iczz(12)=(1/12)*m(1)*al(1)*al(1);
Icxx(2)=0;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=0;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
Icxx(4)=0;   Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);
Icxx(5)=0;   Icyy(5)=(1/12)*m(5)*al(5)*al(5);  Iczz(5)=(1/12)*m(5)*al(5)*al(5);
Icxx(6)=0;   Icyy(6)=(1/12)*m(6)*al(6)*al(6);  Iczz(6)=(1/12)*m(6)*al(6)*al(6);
Icxx(7)=0;   Icyy(7)=(1/12)*m(7)*al(7)*al(7); Iczz(7)=(1/12)*m(7)*al(7)*al(7);

%Ground paprameters
%Parameters for vertical reaction
K=2000; odf=10;                    
Cv=odf*2*sqrt(K*sum(m));
vzdmax=4.5; 
%Parameters for horizontal reactioin
mu=.7;Ch=1000;
gr=[2 1 3];
g_prop=[K Cv vzdmax mu Ch gr];