%clc;
%clear all;

function dy = rigid(t,y)

th1=y(1); th2=y(2); th3=y(3); lmdx=y(4); lmdy=y(5) ;
dth1=y(6); dth2=y(7); dth3=y(8); %dlmdx=y(9); dlmdy=y(10);

%INPUT DATA
Ti=0;Tf=1.5;
%[ddq]= accln()

% Link lengths
l1=0.05; %crank
l2=0.13; %output link 
l3=0.1; %connecting link
l0=0.15;%fixed base

m0=500;m1=1.5;m2=5;m3=3;         %l0=1;l1=1;l2=1;l3=1; 
lc0=.5*l0;lc1=.5*l1;lc2=.5*l2; lc3=.5*l3; 
Izz0=83.61;
Izz1=(1/12)*m1*l1*l1; %1.05; 
Izz2=(1/12)*m2*l2*l2; %1.05;   
Izz3=(1/12)*m3*l3*l3; %1.05;



%fx0=0; fy0=0; tau0=0; %tau1=10; tau2=10;

thin=[0; 145.54*pi/180; (130.54)*pi/180];%60
thf=[-pi/2; 145.54*pi/180; (130.54)*pi/180];


%omega=45;
%dth1_d=omega*2*pi/60;
%ddth1_d=0;
%th1_d=dth1_d*t;
kp=49;kd=14;
 th1_d=thin(1)+((thf(1)-thin(1))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth1_d=((thf(1)-thin(1))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth1_d=(2*pi*(thf(1)-thin(1))/(Tf*Tf))*sin((2*pi/Tf)*t);

%    th2_d=thin(2)+((thf(2)-thin(2))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
 %   dth2_d=((thf(2)-thin(2))/Tf)*(1-cos((2*pi/Tf)*t));
  %  ddth2_d=(2*pi*(thf(2)-thin(2))/(Tf*Tf))*sin((2*pi/Tf)*t);
    
%th3_d=thin(3)+((thf(3)-thin(3))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
 %   dth3_d=((thf(3)-thin(3))/Tf)*(1-cos((2*pi/Tf)*t));
  %  ddth3_d=(2*pi*(thf(3)-thin(3))/(Tf*Tf))*sin((2*pi/Tf)*t);
    
%kp=49; kd=14;
%kp=5000; kd=1000;
tau1=-kp*(th1-th1_d)-kd*(dth1-dth1_d);  
tau2=0; %=-kp*(th2-th2_d)-kd*(dth2-dth2_d);
tau3=0 %-kp*(th3-th3_d)-kd*(dth3-dth3_d);

F=[tau1; tau2; tau3];

I =[ m1*lc1^2 + Izz1,                                                                  0,                                    0
               0, m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3, m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3
               0,                               m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                      m3*lc3^2 + Izz3]
 
 
C =[                                                                                                                          (981*lc1*m1*cos(th1))/100
 m3*((981*lc3*cos(th2 + th3))/100 + (981*l2*cos(th2))/100) - dth3*(2*dth2*l2*lc3*m3*sin(th3) + dth3*l2*lc3*m3*sin(th3)) + (981*lc2*m2*cos(th2))/100
                                                                                         (lc3*m3*(100*l2*sin(th3)*dth2^2 + 981*cos(th2 + th3)))/100]
 
J =[l1*sin(th1), - l3*sin(th2 + th3) - l2*sin(th2),              -l3*sin(th2 + th3)
-l1*cos(th1),   l3*cos(th2 + th3) + l2*cos(th2), l3*cos(th2 + th3) ]
                                                                                
Iinv=inv(I)


Jdtdq =[ dth1^2*l1*cos(th1) - dth3^2*l3*cos(th2 + th3) - dth2^2*l3*cos(th2 + th3) - dth2^2*l2*cos(th2) - 2*dth2*dth3*l3*cos(th2 + th3)
 dth1^2*l1*sin(th1) - dth3^2*l3*sin(th2 + th3) - dth2^2*l3*sin(th2 + th3) - dth2^2*l2*sin(th2) - 2*dth2*dth3*l3*sin(th2 + th3)]
 
 M(1:3,1:3)=I
 M(1:3,4:5)=J.'
 M(4:5,1:3)=J
 
 Minv=inv(M)
 
 F1=[F;0;0]-[C;0;0]
 F2=(J.'*[lmdx;lmdy])
 F3=[0;0;0;-Jdtdq]
 Ff=F1+[F2;0;0]+F3
 ddq=Minv*Ff
%L1=-(inv(J*Iinv*J.'))
%L2=(J*Iinv*(F-C))+Jdtdq
%lmd=L1*L2
%lmdx=lmd(1);
%lmdy=lmd(2);
%ddp=Iinv*(J.'*[lmdx;lmdy]+F-C)

%ddq=[ddp;lmdx;lmdy]
ddth1=ddq(1);
ddth2=ddq(2);
ddth3=ddq(3);
lmdx=-ddq(4); 
lmdy=-ddq(5);
 
dy = zeros(10,1);
dy(1)=dth1; 
dy(2)=dth2; 
dy(3)=dth3; 
%dy(4)=dlmdx; 
%dy(5)=dlmdy;
dy(6)=ddth1; 
dy(7)=ddth2; 
dy(8)=ddth3; 
%dy(9)=ddlmdx; 
%dy(10)=ddlmdy;
