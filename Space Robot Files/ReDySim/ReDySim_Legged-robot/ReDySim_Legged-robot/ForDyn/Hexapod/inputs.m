% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs()

%13 Link hexapod
%NO. OF LINK
n=13;
nq=1;%1 for spatial and 0 for planar
%ENTER DH PARAMETER HERE   
%  dh=[al b alp th];
alp=[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
a=[0; -0.6; 0.3; -0.6; 0.3; 0; 0.3; 0; 0.3; 0.6; 0.3; 0.6; 0.3];
b=[0; .25; 0; -.25; 0; 0.25; 0; -.25; 0; .25; 0; -.25; 0];

%Parent array bt and corrosponding vectors
bt=[0 1 2 1 4 1 6 1 8 1 10 1 12];

%Link Length
al=[1;.3; .3; .3; .3; .3; .3; .3; .3; .3; .3; .3; .3];
% %Distance from origin to link tip in term of link length
alt=[0.5;.3; .3; .3; .3; .3; .3; .3; .3; .3; .3; .3; .3];

%ENTER VECTOR rm
dx=[al(1)/2  al(2)/2 al(3)/2  al(4)/2 al(5)/2   al(6)/2 al(7)/2  al(8)/2 al(9)/2 al(10)/2 al(11)/2  al(12)/2 al(13)/2 ];
dy=[ 0         0       0       0       0         0       0       0       0        0           0       0       0     ];
dz=[ 0         0       0       0       0         0       0       0       0        0           0       0       0    ];

%MASS
m=[2;1;1;1;1;1;1;1;1;1;1;1;1];
g=[0 ; -9.81; 0];

%MOMENT OF INERTIA
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
Icxx(1)=(1/12)*m(1)*0.5*0.5;   Icyy(1)=(1/12)*m(1)*(al(1)*al(1)+0.5*0.5); Iczz(1)=(1/12)*m(1)*al(1)*al(1);
Icxx(2)=0;   Icyy(2)=(1/12)*m(2)*al(2)*al(2); Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=0;   Icyy(3)=(1/12)*m(3)*al(3)*al(3); Iczz(3)=(1/12)*m(3)*al(3)*al(3);
Icxx(4)=0;   Icyy(4)=(1/12)*m(4)*al(4)*al(4); Iczz(4)=(1/12)*m(4)*al(4)*al(4);
Icxx(5)=0;   Icyy(5)=(1/12)*m(5)*al(5)*al(5); Iczz(5)=(1/12)*m(5)*al(5)*al(5);
Icxx(6)=0;   Icyy(6)=(1/12)*m(6)*al(6)*al(6); Iczz(6)=(1/12)*m(6)*al(6)*al(6);
Icxx(7)=0;   Icyy(7)=(1/12)*m(7)*al(7)*al(7); Iczz(7)=(1/12)*m(7)*al(7)*al(7);
Icxx(8)=0;   Icyy(8)=(1/12)*m(8)*al(8)*al(8); Iczz(8)=(1/12)*m(8)*al(8)*al(8);
Icxx(9)=0;   Icyy(9)=(1/12)*m(9)*al(9)*al(9); Iczz(9)=(1/12)*m(9)*al(9)*al(9);
Icxx(10)=0;   Icyy(10)=(1/12)*m(10)*al(10)*al(10); Iczz(10)=(1/12)*m(10)*al(10)*al(10);
Icxx(11)=0;   Icyy(11)=(1/12)*m(11)*al(11)*al(11); Iczz(11)=(1/12)*m(11)*al(11)*al(11);
Icxx(12)=0;   Icyy(12)=(1/12)*m(12)*al(12)*al(12); Iczz(12)=(1/12)*m(12)*al(12)*al(12);
Icxx(13)=0;   Icyy(13)=(1/12)*m(13)*al(13)*al(13); Iczz(13)=(1/12)*m(13)*al(13)*al(13);

%Ground paprameters
%Parameters for vertical reaction
K=3000; odf=10;                    
Cv=odf*2*sqrt(K*sum(m));
vzdmax=4.5; 
%Parameters for horizontal reactioin
mu=.7;Ch=2000;
gr=[2 1 3];
g_prop=[K Cv vzdmax mu Ch gr];