function []=run_Dynam_parameter()

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
% syms F1 F2 Tau0 Tau1 Tau2
% syms Ma Va Fa
% M=[M11 M12 M13 M14 M15;M21 M22 M23 M24 M25;M31 M32 M33 M34 M35;M41 M42 M43 M44 M45;M51 M52 M53 M54 M55];
% V=[C11 C12 C13 C14 C15;C21 C22 C23 C24 C25;C31 C32 C33 C34 C35;C41 C42 C43 C44 C45;C51 C52 C53 C54 C55];
% % Fa=[Fx;Fx;Tau0;Tau1;Tau2];



ti=0;
tf=30;
[M]=traj4();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)]; 
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
% disp('-----Joint angle 1&2 and their rates for simulation time period-----')
B=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'});
q=[0; 0; 0]; 
dq=[0; 0; 0];
ddq=[0; 0; 0];

index=0;
time=zeros(21,1);
for t=0:0.1:tf
     index=index+1;
     time(index)=t;
end

Time=time;

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

% load Torque.dat;
% 
% Tor=Torque'

% % B=cell(f,1);
% % for t=1:f
% %     B{t}=Tor(t,:)';
% % end
% % 
% % for t=1:f
% %     B{t}
% % end


index=0;
t=30;
Z1=zeros(f,6);
Z2=zeros(f,1);
Z3=zeros(f,1);
Z4=zeros(f,1);
Z5=zeros(f,1);
H=zeros(f,5);
index=0;
D=zeros(f,6);


fomode='w';
fip4=fopen('Trac.dat',fomode);

% A=cell(f,1);
for t=1:f
        index=index+1;
        
%         m0=m(1);m1=m(2);m2=m(3);
        x0=q(1);y0=q(2);ph0=q(3);
        th1=q1(t,1);th2=q1(t,2);
        a1=a(3); a0=2*a(2);
        
        d1x=dx(2);d2x=dx(3);
%       I0z=Iczz(1);I1z=Iczz(2);I2z=Iczz(3);

        dx0=dq(1);dy0=dq(2);dph0=dq(3);
        ddx0=ddq(1);ddy0=ddq(2);ddph0=ddq(3);

        dth1=dq1(t,1);dth2=dq1(t,2);
        ddth1=ddq1(t,1);ddth2=ddq1(t,2);
       
        Z=[Z1(t);Z2(t);Z3(t);Z4(t);Z5(t)];
        
        
        T11=ddx0;

        T12=ddx0 - d1x*ddph0*sin(ph0 + th1) - d1x*ddth1*sin(ph0 + th1) - (a0*ddph0*sin(ph0))/2 - d1x*dph0^2*cos(ph0 + th1)- d1x*dth1^2*cos(ph0 + th1)-(a0*dph0^2*cos(ph0))/2 - 2*d1x*dph0*dth1*cos(ph0 + th1);

        T13=ddx0 - d2x*dph0^2*cos(ph0 + th1 + th2) - d2x*dth1^2*cos(ph0 + th1 + th2) - d2x*dth2^2*cos(ph0 + th1 + th2) - a1*ddph0*sin(ph0 + th1) - a1*ddth1*sin(ph0 + th1) - (a0*ddph0*sin(ph0))/2 - a1*dph0^2*cos(ph0 + th1) - a1*dth1^2*cos(ph0 + th1)  - d2x*ddph0*sin(ph0 + th1 + th2) - d2x*ddth1*sin(ph0 + th1 + th2) - d2x*ddth2*sin(ph0 + th1 + th2) - (a0*dph0^2*cos(ph0))/2 - 2*d2x*dph0*dth1*cos(ph0 + th1 + th2) - 2*d2x*dph0*dth2*cos(ph0 + th1 + th2) - 2*d2x*dth1*dth2*cos(ph0 + th1 + th2) - 2*a1*dph0*dth1*cos(ph0 + th1);


        T21=ddy0;

        T22=ddy0 + d1x*ddph0*cos(ph0 + th1) + d1x*ddth1*cos(ph0 + th1) + (a0*ddph0*cos(ph0))/2 - d1x*dph0^2*sin(ph0 + th1) - d1x*dth1^2*sin(ph0 + th1) - (a0*dph0^2*sin(ph0))/2- 2*d1x*dph0*dth1*sin(ph0 + th1);

        T23=ddy0 - d2x*dph0^2*sin(ph0 + th1 + th2) - d2x*dth1^2*sin(ph0 + th1 + th2) - d2x*dth2^2*sin(ph0 + th1 + th2) + a1*ddph0*cos(ph0 + th1) + a1*ddth1*cos(ph0 + th1) + (a0*ddph0*cos(ph0))/2 - a1*dph0^2*sin(ph0 + th1) - a1*dth1^2*sin(ph0 + th1) + d2x*ddph0*cos(ph0 + th1 + th2) + d2x*ddth1*cos(ph0 + th1 + th2) + d2x*ddth2*cos(ph0 + th1 + th2) - (a0*dph0^2*sin(ph0))/2 - 2*d2x*dph0*dth1*sin(ph0 + th1 + th2) - 2*d2x*dph0*dth2*sin(ph0 + th1 + th2) - 2*d2x*dth1*dth2*sin(ph0 + th1 + th2) - 2*a1*dph0*dth1*sin(ph0 + th1);

        T32=(a0^2*ddph0)/4 + d1x^2*ddph0 +  d1x^2*ddth1 + d1x*ddy0*cos(ph0 + th1)- d1x*ddx0*sin(ph0 + th1) + (a0*ddy0*cos(ph0))/2 - (a0*ddx0*sin(ph0))/2 - (a0*d1x*dth1^2*sin(th1))/2 + a0*d1x*ddph0*cos(th1) + (a0*d1x*ddth1*cos(th1))/2 - a0*d1x*dph0*dth1*sin(th1);

        T33=(a0^2*ddph0)/4 + a1^2*ddph0 + a1^2*ddth1 + d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + a1*ddy0*cos(ph0 + th1) - a1*ddx0*sin(ph0 + th1) + (a0*ddy0*cos(ph0))/2 - (a0*ddx0*sin(ph0))/2 + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) - (a0*d2x*dth1^2*sin(th1 + th2))/2 - (a0*d2x*dth2^2*sin(th1 + th2))/2 - (a0*a1*dth1^2*sin(th1))/2  - a1*d2x*dth2^2*sin(th2) + a0*d2x*ddph0*cos(th1 + th2) + (a0*d2x*ddth1*cos(th1 + th2))/2 + (a0*d2x*ddth2*cos(th1 + th2))/2 + a0*a1*ddph0*cos(th1) + (a0*a1*ddth1*cos(th1))/2 + 2*a1*d2x*ddph0*cos(th2) + 2*a1*d2x*ddth1*cos(th2) + a1*d2x*ddth2*cos(th2) - a0*d2x*dph0*dth1*sin(th1 + th2) - a0*d2x*dph0*dth2*sin(th1 + th2) - a0*d2x*dth1*dth2*sin(th1 + th2) - a0*a1*dph0*dth1*sin(th1)- 2*a1*d2x*dph0*dth2*sin(th2) - 2*a1*d2x*dth1*dth2*sin(th2);

        T34=ddph0;

        T35=ddph0 + ddth1;

        T36=ddph0 + ddth1 + ddth2;

        T42=d1x^2*ddph0+ d1x^2*ddth1 + d1x*ddy0*cos(ph0 + th1)- d1x*ddx0*sin(ph0 + th1)+ (a0*d1x*dph0^2*sin(th1))/2 + (a0*d1x*ddph0*cos(th1))/2;

        T43=a1^2*ddph0 + a1^2*ddth1 + d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + a1*ddy0*cos(ph0 + th1) - a1*ddx0*sin(ph0 + th1) + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*sin(th1 + th2))/2 + (a0*a1*dph0^2*sin(th1))/2 - a1*d2x*dth2^2*sin(th2) + (a0*d2x*ddph0*cos(th1 + th2))/2 + (a0*a1*ddph0*cos(th1))/2 + 2*a1*d2x*ddph0*cos(th2) + 2*a1*d2x*ddth1*cos(th2) + a1*d2x*ddth2*cos(th2) - 2*a1*d2x*dph0*dth2*sin(th2) - 2*a1*d2x*dth1*dth2*sin(th2);

        T45=ddph0 +ddth1;

        T46=ddph0+ddth1+ddth2;

        T53=d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*sin(th1 + th2))/2 + a1*d2x*dph0^2*sin(th2) + a1*d2x*dth1^2*sin(th2) + (a0*d2x*ddph0*cos(th1 + th2))/2 + a1*d2x*ddph0*cos(th2) + a1*d2x*ddth1*cos(th2) + 2*a1*d2x*dph0*dth1*sin(th2);

        T56=ddph0 + ddth1 +ddth2 ;


        Trac=[T11,T12,T13,0,0,0;T21,T22,T23,0,0,0;0,T32,T33,T34,T35,T36;0,T42,T43,0,T45,T46;0,0,T53,0,0,T56];
        
        fprintf(fip4,'%e ',Trac);
        fprintf(fip4,'\n');
%         D=pinv(Trac)*Tor(:,t);
        
%        Z1(index,:)=D;
%        A{t}=Trac;
%        
       
%         A(5*index,:)=Trac;
        
%         Trac=[ddx0,  ddx0 - d1x*ddph0*sin(ph0 + th1) - d1x*ddth1*sin(ph0 + th1) - (a0*ddph0*sin(ph0))/2 - d1x*dph0^2*cos(ph0 + th1)- d1x*dth1^2*cos(ph0 + th1)-(a0*dph0^2*m1*cos(ph0))/2 - 2*d1x*dph0*dth1*cos(ph0 + th1) , ddx0 - d2x*dph0^2*cos(ph0 + th1 + th2) - d2x*dth1^2*cos(ph0 + th1 + th2) - d2x*dth2^2*cos(ph0 + th1 + th2) - a1*ddph0*sin(ph0 + th1) - a1*ddth1*sin(ph0 + th1) - (a0*ddph0*sin(ph0))/2 - a1*dph0^2*cos(ph0 + th1) - a1*dth1^2*cos(ph0 + th1)  - d2x*ddph0*sin(ph0 + th1 + th2) - d2x*ddth1*sin(ph0 + th1 + th2) - d2x*ddth2*sin(ph0 + th1 + th2) - (a0*dph0^2*cos(ph0))/2 - 2*d2x*dph0*dth1*cos(ph0 + th1 + th2) - 2*d2x*dph0*dth2*cos(ph0 + th1 + th2) - 2*d2x*dth1*dth2*cos(ph0 + th1 + th2) - 2*a1*dph0*dth1*cos(ph0 + th1), 0, 0, 0;
% 
% 
%               ddy0, ddy0 + d1x*ddph0*cos(ph0 + th1) + d1x*ddth1*cos(ph0 + th1) + (a0*ddph0*cos(ph0))/2 - d1x*dph0^2*sin(ph0 + th1) - d1x*dth1^2*sin(ph0 + th1) - (a0*dph0^2*sin(ph0))/2- 2*d1x*dph0*dth1*sin(ph0 + th1), ddy0 - d2x*dph0^2*sin(ph0 + th1 + th2) - d2x*dth1^2*sin(ph0 + th1 + th2) - d2x*dth2^2*sin(ph0 + th1 + th2) + a1*ddph0*cos(ph0 + th1) + a1*ddth1*cos(ph0 + th1) + (a0*ddph0*cos(ph0))/2 - a1*dph0^2*sin(ph0 + th1) - a1*dth1^2*sin(ph0 + th1) + d2x*ddph0*cos(ph0 + th1 + th2) + d2x*ddth1*cos(ph0 + th1 + th2) + d2x*ddth2*cos(ph0 + th1 + th2) - (a0*dph0^2*sin(ph0))/2 - 2*d2x*dph0*dth1*sin(ph0 + th1 + th2) - 2*d2x*dph0*dth2*sin(ph0 + th1 + th2) - 2*d2x*dth1*dth2*sin(ph0 + th1 + th2) - 2*a1*dph0*dth1*sin(ph0 + th1), 0, 0, 0;
% 
% 
%               0, (a0^2*ddph0)/4 + d1x^2*ddph0 +  d1x^2*ddth1 + d1x*ddy0*cos(ph0 + th1)- d1x*ddx0*sin(ph0 + th1) + (a0*ddy0*cos(ph0))/2 - (a0*ddx0*sin(ph0))/2 - (a0*d1x*dth1^2*sin(th1))/2 + a0*d1x*ddph0*cos(th1) + (a0*d1x*ddth1*cos(th1))/2 - a0*d1x*dph0*dth1*sin(th1) , (a0^2*ddph0)/4 + a1^2*ddph0 + a1^2*ddth1 + d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + a1*ddy0*cos(ph0 + th1) - a1*ddx0*sin(ph0 + th1) + (a0*ddy0*cos(ph0))/2 - (a0*ddx0*sin(ph0))/2 + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) - (a0*d2x*dth1^2*sin(th1 + th2))/2 - (a0*d2x*dth2^2*sin(th1 + th2))/2 - (a0*a1*dth1^2*sin(th1))/2  - a1*d2x*dth2^2*sin(th2) + a0*d2x*ddph0*cos(th1 + th2) + (a0*d2x*ddth1*cos(th1 + th2))/2 + (a0*d2x*ddth2*cos(th1 + th2))/2 + a0*a1*ddph0*cos(th1) + (a0*a1*ddth1*cos(th1))/2 + 2*a1*d2x*ddph0*cos(th2) + 2*a1*d2x*ddth1*cos(th2) + a1*d2x*ddth2*cos(th2) - a0*d2x*dph0*dth1*sin(th1 + th2) - a0*d2x*dph0*dth2*sin(th1 + th2) - a0*d2x*dth1*dth2*sin(th1 + th2) - a0*a1*dph0*dth1*sin(th1)- 2*a1*d2x*dph0*dth2*sin(th2) - 2*a1*d2x*dth1*dth2*sin(th2),  ddph0, ddph0 + ddth1, ddph0+ ddth1 + ddth2 ;
% 
% 
%               0, d1x^2*ddph0+ d1x^2*ddth1 + d1x*ddy0*cos(ph0 + th1)- d1x*ddx0*sin(ph0 + th1)+ (a0*d1x*dph0^2*sin(th1))/2 + (a0*d1x*ddph0*cos(th1))/2 , a1^2*ddph0 + a1^2*ddth1 + d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + a1*ddy0*cos(ph0 + th1) - a1*ddx0*sin(ph0 + th1) + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*sin(th1 + th2))/2 + (a0*a1*dph0^2*sin(th1))/2 - a1*d2x*dth2^2*sin(th2) + (a0*d2x*ddph0*cos(th1 + th2))/2 + (a0*a1*ddph0*cos(th1))/2 + 2*a1*d2x*ddph0*cos(th2) + 2*a1*d2x*ddth1*cos(th2) + a1*d2x*ddth2*cos(th2) - 2*a1*d2x*dph0*dth2*sin(th2) - 2*a1*d2x*dth1*dth2*sin(th2) , 0, ddph0 +ddth1, ddph0+ddth1+ddth2 ;
% 
% 
%               0, 0, d2x^2*ddph0 + d2x^2*ddth1 + d2x^2*ddth2 + d2x*ddy0*cos(ph0 + th1 + th2) - d2x*ddx0*sin(ph0 + th1 + th2) + (a0*d2x*dph0^2*sin(th1 + th2))/2 + a1*d2x*dph0^2*sin(th2) + a1*d2x*dth1^2*sin(th2) + (a0*d2x*ddph0*cos(th1 + th2))/2 + a1*d2x*ddph0*cos(th2) + a1*d2x*ddth1*cos(th2) + 2*a1*d2x*dph0*dth1*sin(th2), 0, 0, ddph0 + ddth1 +ddth2 ];
%         
%           D=[m0;m1;m2;I0z;I1z;I2z];
        
%         Tau=[F1;F2;Tau0;Tau1;Tau2];
        
%          Tau=Trac*D;
        
%           D(index,:)=pinv(Trac)*Tor(t,1:5)';
        
        
       
%         M11=(m(1)+m(2)+m(3));
% 
%         M12=0;
% 
%         M13= - a(3)*m(3)*sin(q(3) + q1(t,1)) - dx(2)*m(2)*sin(q(3) + q1(t,1)) - (a(2)*m(2)*sin(q(3)))- (a(2)*m(3)*sin(q(3)))- dx(3)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         M14= - a(3)*m(3)*sin(q(3) + q1(t,1))- dx(2)*m(2)*sin(q(3) + q1(t,1))- dx(3)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         M15= - dx(3)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         C11=0;
% 
%         C12=0;
% 
%         C13= - dx(3)*dq(3)^2*m(3)*cos(q(3) + q1(t,1) + q1(t,2)) - a(3)*dq(3)^2*m(3)*cos(q(3)+q1(t,1)) - dx(2)*dq(3)^2*m(2)*cos(q(3)+q1(t,1))- (a(2)*dq(3)^2*m(2)*cos(q(3))) - (a(2)*dq(3)^2*m(3)*cos(q(3)))- 2*dx(3)*dq(3)*dq1(t,2)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         C14=- dx(3)*dq1(t,1)^2*m(3)*cos(q(3) + q1(t,1) + q1(t,2))- a(3)*dq1(t,1)^2*m(3)*cos(q(3)+q1(t,1))- dx(2)*dq1(t,1)^2*m(2)*cos(q(3)+q1(t,1)) - 2*dx(3)*dq(3)*dq1(t,1)*m(3)*cos(q(3) + q1(t,1) + q1(t,2))- 2*a(3)*dq(3)*dq1(t,1)*m(3)*cos(q(3)+q1(t,1)) - 2*dx(2)*dq(3)*dq1(t,1)*m(2)*cos(q(3) + q1(t,1));
% 
%         C15=- dx(3)*dq1(t,2)^2*m(3)*cos(q(3) + q1(t,1) + q1(t,2))- 2*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         M21=0;
% 
%         M22=(m(1)+m(2)+m(3));
% 
%         M23= a(3)*m(3)*cos(q(3) + q1(t,1))+ dx(2)*m(2)*cos(q(3)+ q1(t,1))+ (a(2)*m(2)*cos(q(3))) +(a(2)*m(3)*cos(q(3)))+ dx(3)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         M24= a(3)*m(3)*cos(q(3) + q1(t,1))+ dx(2)*m(2)*cos(q(3) + q1(t,1))+ dx(3)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         M25= dx(3)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         C21=0;
% 
%         C22=0;
% 
%         C23=- dx(3)*dq(3)^2*m(3)*sin(q(3) + q1(t,1) + q1(t,2))- a(3)*dq(3)^2*m(3)*sin(q(3) + q1(t,1))- dx(2)*dq(3)^2*m(2)*sin(q(3) + q1(t,1))- (a(2)*dq(3)^2*m(2)*sin(q(3))) - (a(2)*dq(3)^2*m(3)*sin(q(3))) - 2*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         C24=- dx(3)*dq1(t,1)^2*m(3)*sin(q(3) + q1(t,1) + q1(t,2))- a(3)*dq1(t,1)^2*m(3)*sin(q(3) + q1(t,1)) - dx(2)*dq1(t,1)^2*m(2)*sin(q(3) + q1(t,1))- 2*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q(3) + q1(t,1) + q1(t,2))- 2*a(3)*dq(3)*dq1(t,1)*m(3)*sin(q(3)+q1(t,1)) - 2*dx(2)*dq(3)*dq1(t,1)*m(2)*sin(q(3) + q1(t,1));
% 
%         C25=- dx(3)*dq1(t,2)^2*m(3)*sin(q(3) + q1(t,1) + q1(t,2))- 2*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         M31=- a(3)*m(3)*sin(q(3) + q1(t,1)) - dx(2)*m(2)*sin(q(3) + q1(t,1)) - (a(2)*m(2)*sin(q(3))) - (a(2)*m(3)*sin(q(3)))- dx(3)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         M32=  a(3)*m(3)*cos(q(3) + q1(t,1)) + dx(2)*m(2)*cos(q(3) + q1(t,1)) + (a(2)*m(2)*cos(q(3))) + (a(2)*m(3)*cos(q(3)))+ dx(3)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         M33=(Iczz(1)+Iczz(2)+Iczz(3))+ (a(2)^2*m(2))  + (a(2)^2*m(3))+ a(3)^2*m(3)+ dx(2)^2*m(2) + dx(3)^2*m(3) + 2*a(2)*dx(3)*m(3)*cos(q1(t,1) + q1(t,2))+ 2*a(2)*a(3)*m(3)*cos(q1(t,1))+ 2*a(2)*dx(2)*m(2)*cos(q1(t,1))+ 2*a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         M34=(Iczz(2)+Iczz(3))+ a(3)^2*m(3)+ dx(2)^2*m(2) + dx(3)^2*m(3) + (a(2)*dx(3)*m(3)*cos(q1(t,1)+q1(t,2)))+ (a(2)*a(3)*m(3)*cos(q1(t,1))) + (a(2)*dx(2)*m(2)*cos(q1(t,1)))+ 2*a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         M35=(Iczz(3))++ dx(3)^2*m(3)+ (a(2)*dx(3)*m(3)*cos(q1(t,1) + q1(t,2)))+ a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         C31=0;
% 
%         C32=0;
% 
%         C33=- 2*a(2)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,1) + q1(t,2))- 2*a(3)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,2));
% 
%         C34= -(a(2)*dx(3)*dq1(t,1)^2*m(3)*sin(q1(t,1) + q1(t,2)))- (a(2)*a(3)*dq1(t,1)^2*m(3)*sin(q1(t,1))) - (a(2)*dx(2)*dq1(t,1)^2*m(2)*sin(q1(t,1))) - 2*a(2)*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,1) + q1(t,2)) - 2*a(2)*a(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,1)) - 2*a(2)*dx(2)*dq(3)*dq1(t,1)*m(2)*sin(q1(t,1));
% 
%         C35=- (a(2)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,1) + q1(t,2)))-a(3)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,2))- 2*a(2)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,1) + q1(t,2))-2*a(3)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,2));
%         
% 
%         M42= a(3)*m(3)*cos(q(3)+q1(t,1)) + dx(2)*m(2)*cos(q(3)+q1(t,1))+ dx(3)*m(3)*cos(q(3)+q1(t,1)+q1(t,2));
% 
%         M41= - a(3)*m(3)*sin(q(3)+q1(t,1)) - dx(2)*m(2)*sin(q(3)+q1(t,1))- dx(3)*m(3)*sin(q(3)+q1(t,1)+q1(t,2));
% 
%         M43=Iczz(2) + Iczz(3)+ a(3)^2*m(3) + dx(2)^2*m(2) + dx(3)^2*m(3) + (a(2)*dx(3)*m(3)*cos(q1(t,1)+q1(t,2))) + (a(2)*a(3)*m(3)*cos(q1(t,1))) + (a(2)*dx(2)*m(2)*cos(q1(t,1))) + 2*a(3)*dx(3)*m(3)*cos(q1(t,1));
% 
%         M44=Iczz(2)+ Iczz(3)+ a(3)^2*m(3) + 2*a(3)*dx(3)*m(3)*cos(q1(t,1))+ dx(2)^2*m(2) + dx(3)^2*m(3);
% 
%         M45=Iczz(3) + dx(3)^2*m(3) + a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         C41=0;
%         
%         C42=0;
%         
%         C43=(a(2)*dx(3)*dq(3)^2*m(3)*sin(q1(t,1)+q1(t,2))) + (a(2)*a(3)*dq(3)^2*m(3)*sin(q1(t,1))) + (a(2)*dx(2)*dq(3)^2*m(2)*sin(q1(t,1)));
%        
%         C44=- 2*a(3)*dx(3)*dq1(t,1)*dq1(t,2)*m(3)*sin(q1(t,2));
%        
%         C45=- a(3)*dx(3)*dq1(t,2)^2*m(3)*sin(q1(t,2))- 2*a(3)*dx(3)*dq(3)*dq1(t,2)*m(3)*sin(q1(t,2)) ;
%         
% 
% 
%         M51=-dx(3)*m(3)*sin(q(3) + q1(t,1) + q1(t,2));
% 
%         M52=dx(3)*m(3)*cos(q(3) + q1(t,1) + q1(t,2));
% 
%         M53=Iczz(3) + dx(3)^2*m(3) +(a(2)*dx(3)*m(3)*cos(q1(t,1) + q1(t,2))) + a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         M54=Iczz(3) + dx(3)^2*m(3)+ a(3)*dx(3)*m(3)*cos(q1(t,2));
% 
%         M55=Iczz(3) + dx(3)^2*m(3);
% 
%         C51=0;
% 
%         C52=0;
% 
%         C53=(a(2)*dx(3)*dq(3)^2*m(3)*sin(q1(t,1) + q1(t,2))) + a(3)*dx(3)*dq(3)^2*m(3)*sin(q1(t,2))+ 2*a(3)*dx(3)*dq(3)*dq1(t,1)*m(3)*sin(q1(t,2));
% 
%         C54= a(3)*dx(3)*dq1(t,1)^2*m(3)*sin(q1(t,2));
% 
%         C55=0;
%         ddXb=[ddq(1);ddq(2); ddq(3); ddq1(t,1);ddq1(t,2)];
% %         ddPHI=[ddq1(t,1) ;ddq1(t,2)];
% 
%         Ma=[M11 M12 M13 M14 M15;M21 M22 M23 M24 M25;M31 M32 M33 M34 M35;M41 M42 M43 M44 M45;M51 M52 M53 M54 M55];
%         C=[C11+C12+C13+C14+C15;C21+C22+C23+C24+C25;C31+C32+C33+C34+C35;C41+C42+C43+C44+C45;C51+C52+C53+C54+C55];
%         % Fo=[F1;F2;Tau0;Tau1;Tau2];
% %       J=[F1(t);F2(t);Tau0(t);Tau1(t);Tau2(t)];
%         J(index,:)=(Ma*ddXb)+C;
end
% Z1;
% J;
%  for t=1:f
%    V=pinv(A{t})*B{t}
%    mean(V)
%  end
% Z(1);
% Z(2);
% Z(3);
% Z(4);
% Z(5);
% disp('$$$$$$$$$$$$$$$$$$--Dynamic Parameters::{ m0, m1, m2, I0z, I1z, I2z}--@@@@@@@@@@@@@@@')
% U=table(D(:,1),D(:,2),D(:,3),D(:,4),D(:,5),D(:,6),'VariableNames',{'m0' 'm1' 'm2' 'I0z' 'I1z' 'I2z'})
% % U1=table(J(:,4),J(:,5),'VariableNames',{'Tau1' 'Tau2'})
% 

% mean(D)
% 
% fomode='w';
% fip3=fopen('Dynam.dat',fomode);
% for j=1:f
%     %WRITING SOLUTION FOR EACH INSTANT IN FILES
%    
%     fprintf(fip3,'%e ',D(j,1),D(j,2),D(j,3),D(j,4),D(j,5),D(j,6));
%     fprintf(fip3,'\n');
%     
% end


% fomode='w';
% fip4=fopen('Trac.dat',fomode);
% for j=1:f
%     %WRITING SOLUTION FOR EACH INSTANT IN FILES
%     for l=1:5
%     fprintf(fip4,'%e ',Trac(l,:));
%     fprintf(fip4,'\n');
%     end
% end
% 
% load Trac.dat
% TRAC=Trac;
% 
% disp('@@@@@@@@@@@@@@@   Dynamic Parameters ::m0 , m1, m2, I0z, I1z, I2z   @@@@@@@@@@@@@@@@@@@@@')
%  Dynam=(pinv(TRAC)*Tor)';
% % Dynam=(lsqr(TRAC,Tor)');
% fprintf('m0::%d , m1::%d, m2:: %d, I0z:: %d, I1z:: %d, I2z:: %d \n',Dynam(1,1),Dynam(1,2),Dynam(1,3),Dynam(1,4),Dynam(1,5),Dynam(1,6) );















% figure
% 
% hold on
% title('(Base force:Fx)(Newton) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Base Force:Fx)-(Newton)')
% plot(Time,Tau(:,1),'b--o')
% 
% figure
% 
% hold on
% title('(Base force:Fy)(Newton) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Base Force:Fy)-(Newton)')
% plot(Time,Tau(:,2),'g*')
% 
% figure
% hold on
% title('(Base Torque:Tau0)(N-m) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Base Torque:Tau0)(N-m)')
% plot(Time,Tau(:,3),'r--*')
% 
% figure
% hold on
% % title('(LINK-1 Torque:Tau1)(N-m) vs Time(sec) Graph')
% % xlabel('Time(sec)')
% % ylabel('(LINK-1 Torque:Tau1)(N-m)')
% plot(Time,Tau(:,4),'m--o','DisplayName','Tau1')
% 
% % figure
% hold on
% % title('(LINK-2 Torque:Tau2)(N-m) vs Time(sec) Graph')
% % xlabel('Time(sec)')
% % ylabel('(LINK-2 Torque:Tau2)(N-m)')
% plot(Time,Tau(:,5),'c--*','DisplayName','Tau2')
% legend('show')
% title('JOINT Torques (N-m) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('JOINT Torques(Tau1&Tau2) (N-m)')
% 
% 
% figure
% hold on
% title('(JOINT ANGLE-1(th1))(rad) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(JOINT ANGLE-1(th1))(rad)')
% plot(Time,M(:,1),'g-o')
% 
% figure
% hold on
% title('(JOINT ANGLE-2(th2))(rad) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(JOINT ANGLE-2(th2))(rad)')
% plot(Time,M(:,2),'r*')
% 
% figure
% hold on
% title('(Rate of JOINT ANGLE-1(dth1))(rad/s) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Rate of JOINT ANGLE-1(dth1))(rad/s)')
% plot(Time,M(:,3),'b-o')
% 
% 
% figure
% hold on
% title('(Rate of JOINT ANGLE-2(dth2))(rad/s) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Rate of JOINT ANGLE-2(dth2))(rad/s)')
% plot(Time,M(:,4),'c-o')
% 
% end
% 