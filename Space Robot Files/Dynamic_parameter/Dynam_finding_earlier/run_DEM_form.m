function [q dq ddq dth ddth n nq alp a b t bt dx dy dz m x g  Icxx Icyy Iczz Icxy Icyz Iczx M]=run_me()

% syms x0 y0 z0 ph0 th0 si0
% syms dx0 dy0 dz0 dph0 dth0 dsi0 
% syms ddx0 ddy0 ddz0 ddph0 ddth0 ddsi0 
% syms th1 th2 th3 th4 th5 th6 th7
% syms dth1 dth2 dth3 dth4 dth5 dth6 dth7
% syms ddth1 ddth2 ddth3 ddth4 ddth5 ddth6 ddth7 
% % Vector connecting origin and centre-of-mass of the link
% syms d0x d1x d2x d3x d4x d5x d6x d7x
% syms d0y d1y d2y d3y d4y d5y d6y d7y
% syms d0z d1z d2z d3z d4z d5z d6z d7z
% % Gravitational Acceleratoin
% syms g
% % Mass
% syms m0 m1 m2 
% % Inertia tensors
% syms I0x I1x I2x 
% syms I0y I1y I2y 
% syms I0z I1z I2z 
% syms a0 a1 a2 
% 
% %Equations of motion.
% syms M11 M12 M13 M14 M15 M21 M22 M23 M24 M25 M31 M32 M33 M34 M35 M41 M42 M43 M44 M45 M51 M52 M53 M54 M55
% syms C11 C12 C13 C14 C15 C21 C22 C23 C24 C25 C31 C32 C33 C34 C35 C41 C42 C43 C44 C45 C51 C52 C53 C54 C55
% syms F1 F2 F3 Tau1 Tau2
% syms Ma Va Fa

% Ma=[M11 M12 M13 M14 M15;M21 M22 M23 M24 M25;M31 M32 M33 M34 M35;M41 M42 M43 M44 M45;M51 M52 M53 M54 M55];
% Va=[C11 C12 C13 C14 C15;C21 C22 C23 C24 C25;C31 C32 C33 C34 C35;C41 C42 C43 C44 C45;C51 C52 C53 C54 C55];
% Fa=[Fx;Fx;Tau0;Tau1;Tau2];



ti=0;
tf=30;
[M]=traj4();
[f,g]=size(M(:,1))
q1=[M(:,1),M(:,2)]; 
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
disp('-----Joint angle 1&2 and their rates for simulation time period-----')
B=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'})
q=[0; 0; 0]; 
dq=[0; 0; 0];
ddq=[0; 0; 0];

index=0;
time=zeros(21,1);
for t=0:0.1:tf
     index=index+1;
     time(index)=t;
end
Time=time

% 3 Link Manipulator
% NO. OF LINKS
n=3;
nq=0;%1 for spatial and 0 for planar
% ENTER DH PARAMETER HERE   
% dh=[alt b alp th];
alp=[0; 0; 0];
a=[0; 0.5; 1];
b=[0; 0; 0];
% Parent array bt and corrosponding vectors
bt=[0 1 2 ];

% Link Length
al=[1; 1; 1];
%Distance from origin to link tip in term of link length
alt=[0.5; 1; 1];

% ENTER VECTOR dm
dx=[  0    al(2)/2  al(3)/2  ];
dy=[  0       0       0      ];
dz=[  0       0       0      ];


%MASS
m=[500; 10; 10];
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
Icxx(4)=0.01;   Icyy(4)=1.05;  Iczz(4)=1.05;

% F1 = ddq(1)*m(1) + ddq(1)*m(2) + ddq(1)*m(3) - d2x*dph0^2*m2*cos(ph0 + th1 + th2) - d2x*dth1^2*m2*cos(ph0 + th1 + th2) - d2x*dth2^2*m2*cos(ph0 + th1 + th2) - a1*ddph0*m2*sin(ph0 + th1) - a1*ddth1*m2*sin(ph0 + th1) - d1x*ddph0*m1*sin(ph0 + th1) - d1x*ddth1*m1*sin(ph0 + th1) - (a0*ddph0*m1*sin(ph0))/2 - (a0*ddph0*m2*sin(ph0))/2 - a1*dph0^2*m2*cos(ph0 + th1) - a1*dth1^2*m2*cos(ph0 + th1) - d1x*dph0^2*m1*cos(ph0 + th1) - d1x*dth1^2*m1*cos(ph0 + th1) - d2x*ddph0*m2*sin(ph0 + th1 + th2) - d2x*ddth1*m2*sin(ph0 + th1 + th2) - d2x*ddth2*m2*sin(ph0 + th1 + th2) - (a0*dph0^2*m1*cos(ph0))/2 - (a0*dph0^2*m2*cos(ph0))/2 - 2*d2x*dph0*dth1*m2*cos(ph0 + th1 + th2) - 2*d2x*dph0*dth2*m2*cos(ph0 + th1 + th2) - 2*d2x*dth1*dth2*m2*cos(ph0 + th1 + th2) - 2*a1*dph0*dth1*m2*cos(ph0 + th1) - 2*d1x*dph0*dth1*m1*cos(ph0 + th1)
% 
% F2 = ddy0*m0 + ddy0*m1 + ddy0*m2 - d2x*dph0^2*m2*sin(ph0 + th1 + th2) - d2x*dth1^2*m2*sin(ph0 + th1 + th2) - d2x*dth2^2*m2*sin(ph0 + th1 + th2) + a1*ddph0*m2*cos(ph0 + th1) + a1*ddth1*m2*cos(ph0 + th1) + d1x*ddph0*m1*cos(ph0 + th1) + d1x*ddth1*m1*cos(ph0 + th1) + (a0*ddph0*m1*cos(ph0))/2 + (a0*ddph0*m2*cos(ph0))/2 - a1*dph0^2*m2*sin(ph0 + th1) - a1*dth1^2*m2*sin(ph0 + th1) - d1x*dph0^2*m1*sin(ph0 + th1) - d1x*dth1^2*m1*sin(ph0 + th1) + d2x*ddph0*m2*cos(ph0 + th1 + th2) + d2x*ddth1*m2*cos(ph0 + th1 + th2) + d2x*ddth2*m2*cos(ph0 + th1 + th2) - (a0*dph0^2*m1*sin(ph0))/2 - (a0*dph0^2*m2*sin(ph0))/2 - 2*d2x*dph0*dth1*m2*sin(ph0 + th1 + th2) - 2*d2x*dph0*dth2*m2*sin(ph0 + th1 + th2) - 2*d2x*dth1*dth2*m2*sin(ph0 + th1 + th2) - 2*a1*dph0*dth1*m2*sin(ph0 + th1) - 2*d1x*dph0*dth1*m1*sin(ph0 + th1)
% 
% F3 = I0z*ddph0 + I1z*ddph0 + I2z*ddph0 + I1z*ddth1 + I2z*ddth1 + I2z*ddth2 + (a0^2*ddph0*m1)/4 + (a0^2*ddph0*m2)/4 + a1^2*ddph0*m2 + a1^2*ddth1*m2 + d1x^2*ddph0*m1 + d2x^2*ddph0*m2 + d1x^2*ddth1*m1 + d2x^2*ddth1*m2 + d2x^2*ddth2*m2 + a1*ddy0*m2*cos(ph0 + th1) + d1x*ddy0*m1*cos(ph0 + th1) - a1*ddx0*m2*sin(ph0 + th1) - d1x*ddx0*m1*sin(ph0 + th1) + (a0*ddy0*m1*cos(ph0))/2 + (a0*ddy0*m2*cos(ph0))/2 - (a0*ddx0*m1*sin(ph0))/2 - (a0*ddx0*m2*sin(ph0))/2 + d2x*ddy0*m2*cos(ph0 + th1 + th2) - d2x*ddx0*m2*sin(ph0 + th1 + th2) - (a0*d2x*dth1^2*m2*sin(th1 + th2))/2 - (a0*d2x*dth2^2*m2*sin(th1 + th2))/2 - (a0*a1*dth1^2*m2*sin(th1))/2 - (a0*d1x*dth1^2*m1*sin(th1))/2 - a1*d2x*dth2^2*m2*sin(th2) + a0*d2x*ddph0*m2*cos(th1 + th2) + (a0*d2x*ddth1*m2*cos(th1 + th2))/2 + (a0*d2x*ddth2*m2*cos(th1 + th2))/2 + a0*a1*ddph0*m2*cos(th1) + (a0*a1*ddth1*m2*cos(th1))/2 + a0*d1x*ddph0*m1*cos(th1) + 2*a1*d2x*ddph0*m2*cos(th2) + (a0*d1x*ddth1*m1*cos(th1))/2 + 2*a1*d2x*ddth1*m2*cos(th2) + a1*d2x*ddth2*m2*cos(th2) - a0*d2x*dph0*dth1*m2*sin(th1 + th2) - a0*d2x*dph0*dth2*m2*sin(th1 + th2) - a0*d2x*dth1*dth2*m2*sin(th1 + th2) - a0*a1*dph0*dth1*m2*sin(th1) - a0*d1x*dph0*dth1*m1*sin(th1) - 2*a1*d2x*dph0*dth2*m2*sin(th2) - 2*a1*d2x*dth1*dth2*m2*sin(th2)
% 
% Tau1 = I1z*ddph0 + I2z*ddph0 + I1z*ddth1 + I2z*ddth1 + I2z*ddth2 + a1^2*ddph0*m2 + a1^2*ddth1*m2 + d1x^2*ddph0*m1 + d2x^2*ddph0*m2 + d1x^2*ddth1*m1 + d2x^2*ddth1*m2 + d2x^2*ddth2*m2 + a1*ddy0*m2*cos(ph0 + th1) + d1x*ddy0*m1*cos(ph0 + th1) - a1*ddx0*m2*sin(ph0 + th1) - d1x*ddx0*m1*sin(ph0 + th1) + d2x*ddy0*m2*cos(ph0 + th1 + th2) - d2x*ddx0*m2*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + (a0*a1*dph0^2*m2*sin(th1))/2 + (a0*d1x*dph0^2*m1*sin(th1))/2 - a1*d2x*dth2^2*m2*sin(th2) + (a0*d2x*ddph0*m2*cos(th1 + th2))/2 + (a0*a1*ddph0*m2*cos(th1))/2 + (a0*d1x*ddph0*m1*cos(th1))/2 + 2*a1*d2x*ddph0*m2*cos(th2) + 2*a1*d2x*ddth1*m2*cos(th2) + a1*d2x*ddth2*m2*cos(th2) - 2*a1*d2x*dph0*dth2*m2*sin(th2) - 2*a1*d2x*dth1*dth2*m2*sin(th2)
% 
% Tau2 = I2z*ddph0 + I2z*ddth1 + I2z*ddth2 + d2x^2*ddph0*m2 + d2x^2*ddth1*m2 + d2x^2*ddth2*m2 + d2x*ddy0*m2*cos(ph0 + th1 + th2) - d2x*ddx0*m2*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + a1*d2x*dph0^2*m2*sin(th2) + a1*d2x*dth1^2*m2*sin(th2) + (a0*d2x*ddph0*m2*cos(th1 + th2))/2 + a1*d2x*ddph0*m2*cos(th2) + a1*d2x*ddth1*m2*cos(th2) + 2*a1*d2x*dph0*dth1*m2*sin(th2)

index=0;
t=30;
Z1=zeros(f,1);
Z2=zeros(f,1);
Z3=zeros(f,1);
Z4=zeros(f,1);
Z5=zeros(f,1);
H=zeros(f,5);
index=0;
for t=1:f
          index=index+1;

        F1(t) = ddq(1)*m(1) + ddq(1)*m(2) + ddq(1)*m(3) - dx(3)*dq(3)^2*m(3)*cos(q(3)+q1(t,1) + q1(t,2)) - dx(3)*dq1(t,1)^2*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) - dx(3)*dq1(t,2)^2*m(3)*cos(q(3)+q1(t,1) + q1(t,2) ) - a(3)*ddq(3)*m(3)*sin(q(3)+ q1(t,1)) - a(3)*ddq1(t,1)*m(3)*sin(q(3)+q1(t,1)) - dx(2)*ddq(3)*m(2)*sin(q(3)+q1(t,1)) - dx(2)*ddq1(t,1)*m(2)*sin(q(3)+ q1(t,1)) - (a(2)*ddq(3)*m(2)*sin(q(3))) - (a(2)*ddq(3)*m(3)*sin(q(3))) - a(3)*dq(3)^2*m(3)*cos(q(3)+ q1(t,1)) - a(3)*dq1(t,1)^2*m(3)*cos(q(3)+ q1(t,1)) - dx(2)*dq(3)^2*m(2)*cos(q(3)+ q1(t,1)) - dx(2)*dq1(t,1)^2*m(2)*cos(q(3)+q1(t,1)) - dx(3)*ddq(3)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - dx(3)*ddq1(t,1)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - dx(3)*ddq1(t,2)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - (a(2)*dq(3)^2*m(2)*cos(q(3))) - (a(2)*dq(3)^2*m(3)*cos(q(3))) - 2*dx(3)*dq(3)*dq1(t,1)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) - 2*dx(3)*dq(3)*dq1(t,2)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) - 2*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) - 2*a(3)*dq(3)*dq1(t,1)*m(3)*cos(q(3)+q1(t,1)) - 2*dx(2)*dq(3)*dq1(t,1)*m(2)*cos(q(3)+q1(t,1));
        Z1(t)=F1(t);
      

        F2(t) = ddq(2)*m(1) + ddq(2)*m(2) + ddq(2)*m(3) - dx(3)*dq(3)^2*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - dx(3)*dq1(t,1)^2*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - dx(3)*dq1(t,2)^2*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) + a(3)*ddq(3)*m(3)*cos(q(3)+ q1(t,1)) + a(3)*ddq1(t,1)*m(3)*cos(q(3)+ q1(t,1)) + dx(2)*ddq(3)*m(2)*cos(q(3)+ q1(t,1)) + dx(2)*ddq1(t,1)*m(2)*cos(q(3)+ q1(t,1)) + (a(2)*ddq(3)*m(2)*cos(q(3))) + (a(2)*ddq(3)*m(3)*cos(q(3))) - a(3)*dq(3)^2*m(3)*sin(q(3)+ q1(t,1)) - a(3)*dq1(t,1)^2*m(3)*sin(q(3)+ q1(t,1)) - dx(2)*dq(3)^2*m(2)*sin(q(3)+ q1(t,1)) - dx(2)*dq1(t,1)^2*m(2)*sin(q(3)+ q1(t,1)) + dx(3)*ddq(3)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) + dx(3)*ddq1(t,1)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) + dx(3)*ddq1(t,2)*m(3)*cos(q(3)+ q1(t,1) + q1(t,2)) - (a(2)*dq(3)^2*m(2)*sin(q(3))) - (a(2)*dq(3)^2*m(3)*sin(q(3))) - 2*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - 2*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - 2*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q(3)+ q1(t,1) + q1(t,2)) - 2*a(3)*dq(3)*dq1(t,1)*m(3)*sin(q(3)+ q1(t,1)) - 2*dx(2)*dq(3)*dq1(t,1)*m(2)*sin(q(3)+ q1(t,1));      
        Z2(t)=F2(t);
      
        Tau0(t) = Iczz(1)*ddq(3) + Iczz(2)*ddq(3) + Iczz(3)*ddq(3) + Iczz(2)*ddq1(t,1) + Iczz(3)*ddq1(t,1) + Iczz(3)*ddq1(t,2) + (a(2)^2*ddq(3)*m(2)) + (a(2)^2*ddq(3)*m(3)) + a(3)^2*ddq(3)*m(3) + a(3)^2*ddq1(t,1)*m(3) + dx(2)^2*ddq(3)*m(2) + dx(3)^2*ddq(3)*m(3) + dx(2)^2*ddq1(t,1)*m(2) + dx(3)^2*ddq1(t,1)*m(3) + dx(3)^2*ddq1(t,2)*m(3) + a(3)*ddq(2)*m(3)*cos(q(3)+q1(t,1)) + dx(2)*ddq(2)*m(2)*cos(q(3)+q1(t,1)) - a(3)*ddq(1)*m(3)*sin(q(3)+q1(t,1)) - dx(2)*ddq(1)*m(2)*sin(q(3)+q1(t,1)) + (a(2)*ddq(2)*m(2)*cos(q(3))) + (a(2)*ddq(2)*m(3)*cos(q(3))) - (a(2)*ddq(1)*m(2)*sin(q(3))) - (a(2)*ddq(1)*m(3)*sin(q(3))) + dx(3)*ddq(2)*m(3)*cos(q(3)+q1(t,1)+q1(t,2)) - dx(3)*ddq(1)*m(3)*sin(q(3)+q1(t,1)+q1(t,2)) - (a(2)*dx(3)*dq1(t,1)^2*m(3)*sin(q1(t,1)+q1(t,2))) - (a(2)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,1)+q1(t,2))) - (a(2)*a(3)*dq1(t,1)^2*m(3)*sin(q1(t,1))) - (a(2)*dx(2)*dq1(t,1)^2*m(2)*sin(q1(t,1))) - a(3)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,2)) + 2*a(2)*dx(3)*ddq(3)*m(3)*cos(q1(t,1)+q1(t,2)) + (a(2)*dx(3)*ddq1(t,1)*m(3)*cos(q1(t,1)+q1(t,2))) + (a(2)*dx(3)*ddq1(t,2)*m(3)*cos(q1(t,1)+q1(t,2))) + 2*a(2)*a(3)*ddq(3)*m(3)*cos(q1(t,1)) + (a(2)*a(3)*ddq1(t,1)*m(3)*cos(q1(t,1))) + 2*a(2)*dx(2)*ddq(3)*m(2)*cos(q1(t,1)) + 2*a(3)*dx(3)*ddq(3)*m(3)*cos(q1(t,2)) + (a(2)*dx(2)*ddq1(t,1)*m(2)*cos(q1(t,1))) + 2*a(3)*dx(3)*ddq1(t,1)*m(3)*cos(q1(t,2)) + a(3)*dx(3)*ddq1(t,2)*m(3)*cos(q1(t,2)) - 2*a(2)*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,1)+q1(t,2)) - 2*a(2)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,1)+q1(t,2)) - 2*a(2)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,1)+q1(t,2)) - 2*a(2)*a(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,1)) - 2*a(2)*dx(2)*dq(3)*dq1(t,1)*m(2)*sin(q1(t,1)) - 2*a(3)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,2)) - 2*a(3)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,2));
        Z3(t)=Tau0(t);
      
        Tau1(t) = Iczz(2)*ddq(3) + Iczz(3)*ddq(3) + Iczz(2)*ddq1(t,1) + Iczz(3)*ddq1(t,1) + Iczz(3)*ddq1(t,2) + a(3)^2*ddq(3)*m(3) + a(3)^2*ddq1(t,1)*m(3) + dx(2)^2*ddq(3)*m(2) + dx(3)^2*ddq(3)*m(3) + dx(2)^2*ddq1(t,1)*m(2) + dx(3)^2*ddq1(t,1)*m(3) + dx(3)^2*ddq1(t,2)*m(3) + a(3)*ddq(2)*m(3)*cos(q(3)+q1(t,1)) + dx(2)*ddq(2)*m(2)*cos(q(3)+q1(t,1)) - a(3)*ddq(1)*m(3)*sin(q(3)+q1(t,1)) - dx(2)*ddq(1)*m(2)*sin(q(3)+q1(t,1)) + dx(3)*ddq(2)*m(3)*cos(q(3)+q1(t,1)+q1(t,2)) - dx(3)*ddq(1)*m(3)*sin(q(3)+q1(t,1)+q1(t,2)) + (a(2)*dx(3)*dq(3)^2*m(3)*sin(q1(t,1)+q1(t,2))) + (a(2)*a(3)*dq(3)^2*m(3)*sin(q1(t,1))) + (a(2)*dx(2)*dq(3)^2*m(2)*sin(q1(t,1))) - a(3)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,2)) + (a(2)*dx(3)*ddq(3)*m(3)*cos(q1(t,1)+q1(t,2))) + (a(2)*a(3)*ddq(3)*m(3)*cos(q1(t,1))) + (a(2)*dx(2)*ddq(3)*m(2)*cos(q1(t,1))) + 2*a(3)*dx(3)*ddq(3)*m(3)*cos(q1(t,1)) + 2*a(3)*dx(3)*ddq1(t,1)*m(3)*cos(q1(t,1)) + a(3)*dx(3)*ddq1(t,2)*m(3)*cos(q1(t,2)) - 2*a(3)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,2)) - 2*a(3)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,2));
        Z4(t)=Tau1(t);
       
        Tau2(t) = Iczz(3)*ddq(3) + Iczz(3)*ddq1(t,1) + Iczz(3)*ddq1(t,2) + dx(3)^2*ddq(3)*m(3) + dx(3)^2*ddq1(t,1)*m(3) + dx(3)^2*ddq1(t,2)*m(3) + dx(3)*ddq(2)*m(3)*cos(q(3)+q1(t,1)+q1(t,2)) - dx(3)*ddq(1)*m(3)*sin(q(3)+q1(t,1)+q1(t,2)) + (a(2)*dx(3)*dq(3)^2*m(3)*sin(q1(t,1)+q1(t,2))) + a(3)*dx(3)*dq(3)^2*m(3)*sin(q1(t,2)) + a(3)*dx(3)*dq1(t,1)^2*m(3)*sin(q1(t,2)) + (a(2)*dx(3)*ddq(3)*m(3)*cos(q1(t,1)+q1(t,2))) + a(3)*dx(3)*ddq(3)*m(3)*cos(q1(t,2)) + a(3)*dx(3)*ddq1(t,1)*m(3)*cos(q1(t,2)) + 2*a(3)*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,2));
        Z5(t)=Tau2(t);

        H(index,:)=[Z1(t) Z2(t) Z3(t) Z4(t) Z5(t)];
end
H;
Z1;
Z2;
Z3;
Z4;
Z5;
disp('$$$$$$$$$$$$$$$$$$---Final Base Forces(Fx,Fy,Tau0) and Joint Torque Values(Tau1,Tau2)--@@@@@@@@@@@@@@@')
P=table(Z1,Z2,Z3,Z4,Z5,'VariableNames',{'Fx' 'Fy' 'Tau0' 'Tau1' 'Tau2'})

figure

hold on
title('(Base force:Fx)(Newton) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Base Force:Fx)-(Newton)')
plot(Time,Z1,'b--o')

figure

hold on
title('(Base force:Fy)(Newton) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Base Force:Fy)-(Newton)')
plot(Time,Z2,'g-*')

figure
hold on
title('(Base Torque:Tau0)(N-m) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Base Torque:Tau0)(N-m)')
plot(Time,Z3,'r--*')

figure
hold on
title('(LINK-1 Torque:Tau1)(N-m) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(LINK-1 Torque:Tau1)(N-m)')
plot(Time,Z4,'m--o')

% figure
hold on
title('(LINK-2 Torque:Tau2)(N-m) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(LINK-2 Torque:Tau2)(N-m)')
plot(Time,Z5,'c*')


figure
hold on
title('(JOINT ANGLE-1(th1))(rad) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(JOINT ANGLE-1(th1))(rad)')
plot(Time,M(:,1),'g-o')

figure
hold on
title('(JOINT ANGLE-2(th2))(rad) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(JOINT ANGLE-2(th2))(rad)')
plot(Time,M(:,2),'r*')

figure
hold on
title('(Rate of JOINT ANGLE-1(dth1))(rad/s) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Rate of JOINT ANGLE-1(dth1))(rad/s)')
plot(Time,M(:,3),'b-o')


figure
hold on
title('(Rate of JOINT ANGLE-2(dth2))(rad/s) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Rate of JOINT ANGLE-2(dth2))(rad/s)')
plot(Time,M(:,4),'c-o')



end
