% ReDySim inputs module. The model parameters are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%System: KUKA KR5 robot
% INPUTS
%Number of links 
n=6;

%Degree of fredom of the system
dof=6;

% Type of mechanism
type=0; % 1 for closed-loop and 0 for open-loop

%Actuated joints of open tree
aj=[1 1 1 1 1 1]; %enter 1 for actuated joints and 0 otherwise

% Link lengths
al=[.180; .600; .120; 0; 0;0];

%DH PARAMETERs
alp=[0; pi/2; 0; pi/2; -pi/2; pi/2];
a=[0; .180; .600; .120; 0; 0];
b=[.400; 0; 0; .620; 0; 0];
th=[0; 0; 0; 0; 0; 0];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1; 1; 1];

%PARENT ARRAY
bt=[0; 1; 2; 3; 4; 5 ];

% di,a vector form the origin Ok to Center of mass (COM), Ck, for k=1,..,n
dx=[ .104667, .267012,   .087677, -.000033,         0,       0 ];
dy=[ .005077,       0,  -.034263,  .007634,   .032618,       0 ];
dz=[ .059035,       0,   .007779, -.109372,  -.009789, .111885 ];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[16.038;  7.988;  12.973  ; 2.051  ;  0.811  ; 0.008 ];
g=[0 ; 0; -9.81];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization
Icxx(1)=176938.765*1e-6  ;  Icyy(1)=266532.371*1e-6 ;  Iczz(1)=262222.375*1e-6 ;
Icxx(2)=271640.468*1e-6 ;  Icyy(2)=276878.849*1e-6 ;  Iczz(2)=21894.253*1e-6  ;
Icxx(3)=388988.085*1e-6 ;  Icyy(3)=376583.684*1e-6 ;  Iczz(3)=104146.290*1e-6  ;
Icxx(4)=4767.354*1e-6   ;  Icyy(4)=10122.217*1e-6   ;  Iczz(4)=12108.860 *1e-6   ;
Icxx(5)=760.688*1e-6    ;  Icyy(5)=1783.961*1e-6   ;  Iczz(5)=1801.078*1e-6   ;
Icxx(6)=3.113*1e-6      ;  Icyy(6)=1.512*1e-6      ;  Iczz(6)=1.652*1e-6      ;
end