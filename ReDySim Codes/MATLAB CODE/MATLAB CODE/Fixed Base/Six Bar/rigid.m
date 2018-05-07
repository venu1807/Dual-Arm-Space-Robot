%clc;
%clear all;

function dy = rigid(t,y)

th1=y(1); th2=y(2); th3=y(3);th4=y(4);th5=y(5); lmdx=y(6); lmdy=y(7) ;
dth1=y(8); dth2=y(9); dth3=y(10); dth4=y(11);dth5=y(12);

%INPUT DATA
Ti=0;Tf=2;

%[ddq]= accln()

% Link lengths
l1=1%0.05; %crank
l2=1%0.13; %output link 
l3=1%0.1; %connecting link
l0=1%0.15;%fixed base
l4=1%.2;
l5=1

m0=500;m1=.1;m2=.1;m3=.1;m4=.1;m5=.1;         %l0=1;l1=1;l2=1;l3=1; m0=500;m1=1.5;m2=5;m3=3;m4=1;     
lc0=.5*l0;lc1=.5*l1;lc2=.5*l2; lc3=.5*l3; lc4=.5*l4;lc5=.5*l5 
Izz0=83.61;
Izz1=(1/12)*m1*l1*l1; %1.05; 
Izz2=(1/12)*m2*l2*l2; %1.05;   
Izz3=(1/12)*m3*l3*l3; %1.05;
Izz4=(1/12)*m4*l4*l4; %1.05;
Izz5=(1/12)*m5*l5*l5; %1.05;


%fx0=0; fy0=0; tau0=0; %tau1=10; tau2=10;

thin=[90*pi/180; 90*pi/180; 88.865*pi/180; (109.135)*pi/180];%60
thf=[180*pi/180; 90*pi/180; 71.688*pi/180; (119.052)*pi/180];


%omega=45;
%dth1_d=omega*2*pi/60;
%ddth1_d=0;
%th1_d=dth1_d*t;

th1_d=thin(1)+((thf(1)-thin(1))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth1_d=((thf(1)-thin(1))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth1_d=(2*pi*(thf(1)-thin(1))/(Tf*Tf))*sin((2*pi/Tf)*t);

    th2_d=thin(2)+((thf(2)-thin(2))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth2_d=((thf(2)-thin(2))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth2_d=(2*pi*(thf(2)-thin(2))/(Tf*Tf))*sin((2*pi/Tf)*t);
    
th3_d=thin(3)+((thf(3)-thin(3))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth3_d=((thf(3)-thin(3))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth3_d=(2*pi*(thf(3)-thin(3))/(Tf*Tf))*sin((2*pi/Tf)*t);
    
kp=49; kd=14;

%kp=5000; kd=1000;

tau1=0%-kp*(th1-th1_d)-kd*(dth1-dth1_d);  
tau2=0%-kp*(th2-th2_d)-kd*(dth2-dth2_d);
tau3=0%-kp*(th3-th3_d)-kd*(dth3-dth3_d);
tau4=0;
tau5=0;

F=[tau1; tau2; tau3; tau4; tau5];

I =[ Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc1^2*m1 + lc2^2*m2 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + 2*l1*l2*m3*cos(th2) + 2*l1*lc2*m2*cos(th2) + 2*l2*lc3*m3*cos(th3), m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3, Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3),                                                                  0,                                    0
                                             m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3,                                                                     m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3,                            m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                                                                  0,                                    0
                                                                                                                    Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3),                                                                                                   m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                                                 m3*lc3^2 + Izz3,                                                                  0,                                    0
                                                                                                                                                                                  0,                                                                                                                                      0,                                                               0, m5*l4^2 + 2*m5*cos(th5)*l4*lc5 + m4*lc4^2 + m5*lc5^2 + Izz4 + Izz5, m5*lc5^2 + l4*m5*cos(th5)*lc5 + Izz5
                                                                                                                                                                                  0,                                                                                                                                      0,                                                               0,                               m5*lc5^2 + l4*m5*cos(th5)*lc5 + Izz5,                      m5*lc5^2 + Izz5]
 
 
C =[ (981*l1*m2*cos(th1))/100 + (981*l1*m3*cos(th1))/100 + (981*lc1*m1*cos(th1))/100 + (981*lc3*m3*cos(th1 + th2 + th3))/100 + (981*l2*m3*cos(th1 + th2))/100 + (981*lc2*m2*cos(th1 + th2))/100 - dth2^2*l1*lc3*m3*sin(th2 + th3) - dth3^2*l1*lc3*m3*sin(th2 + th3) - dth2^2*l1*l2*m3*sin(th2) - dth2^2*l1*lc2*m2*sin(th2) - dth3^2*l2*lc3*m3*sin(th3) - 2*dth1*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth2*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth2*l1*l2*m3*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                           (981*lc3*m3*cos(th1 + th2 + th3))/100 + (981*l2*m3*cos(th1 + th2))/100 + (981*lc2*m2*cos(th1 + th2))/100 + dth1^2*l1*lc3*m3*sin(th2 + th3) + dth1^2*l1*l2*m3*sin(th2) + dth1^2*l1*lc2*m2*sin(th2) - dth3^2*l2*lc3*m3*sin(th3) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                      (lc3*m3*(981*cos(th1 + th2 + th3) + 100*dth1^2*l1*sin(th2 + th3) + 100*dth1^2*l2*sin(th3) + 100*dth2^2*l2*sin(th3) + 200*dth1*dth2*l2*sin(th3)))/100
                                                                                                                                                                                                                                                                                                                                                                                                                                                        m5*((981*lc5*cos(th4 + th5))/100 + (981*l4*cos(th4))/100) - dth5*(2*dth4*l4*lc5*m5*sin(th5) + dth5*l4*lc5*m5*sin(th5)) + (981*lc4*m4*cos(th4))/100
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                (lc5*m5*(100*l4*sin(th5)*dth4^2 + 981*cos(th4 + th5)))/100]
 
J =[ - l2*sin(th1 + th2) - l1*sin(th1) - l3*sin(th1 + th2 + th3), - l2*sin(th1 + th2) - l3*sin(th1 + th2 + th3), -l3*sin(th1 + th2 + th3),   l5*sin(th4 + th5) + l4*sin(th4),  l5*sin(th4 + th5)
   l2*cos(th1 + th2) + l1*cos(th1) + l3*cos(th1 + th2 + th3),   l2*cos(th1 + th2) + l3*cos(th1 + th2 + th3),  l3*cos(th1 + th2 + th3), - l5*cos(th4 + th5) - l4*cos(th4), -l5*cos(th4 + th5)]
                                                                             


Jdtdq =[ dth4^2*l5*cos(th4 + th5) - dth2^2*l2*cos(th1 + th2) - dth1^2*l2*cos(th1 + th2) + dth5^2*l5*cos(th4 + th5) - dth1^2*l1*cos(th1) + dth4^2*l4*cos(th4) - dth1^2*l3*cos(th1 + th2 + th3) - dth2^2*l3*cos(th1 + th2 + th3) - dth3^2*l3*cos(th1 + th2 + th3) - 2*dth1*dth2*l2*cos(th1 + th2) + 2*dth4*dth5*l5*cos(th4 + th5) - 2*dth1*dth2*l3*cos(th1 + th2 + th3) - 2*dth1*dth3*l3*cos(th1 + th2 + th3) - 2*dth2*dth3*l3*cos(th1 + th2 + th3)
 dth4^2*l5*sin(th4 + th5) - dth2^2*l2*sin(th1 + th2) - dth1^2*l2*sin(th1 + th2) + dth5^2*l5*sin(th4 + th5) - dth1^2*l1*sin(th1) + dth4^2*l4*sin(th4) - dth1^2*l3*sin(th1 + th2 + th3) - dth2^2*l3*sin(th1 + th2 + th3) - dth3^2*l3*sin(th1 + th2 + th3) - 2*dth1*dth2*l2*sin(th1 + th2) + 2*dth4*dth5*l5*sin(th4 + th5) - 2*dth1*dth2*l3*sin(th1 + th2 + th3) - 2*dth1*dth3*l3*sin(th1 + th2 + th3) - 2*dth2*dth3*l3*sin(th1 + th2 + th3)]
 
 
 M(1:5,1:5)=I;
 M(1:5,6:7)=J.';
 M(6:7,1:5)=J;
 
 Minv=inv(M);
 
 F1=[F;0;0]-[C;0;0];
 F2=(J.'*[lmdx;lmdy]);
 F3=[0;0;0;0;0;-Jdtdq];
 Ff=F1+[F2;0;0]+F3;
 
 ddq=Minv*Ff;

%ddq=[ddp;lmdx;lmdy]

ddth1=ddq(1);
ddth2=ddq(2);
ddth3=ddq(3);
ddth4=ddq(4);
ddth5=ddq(5)
lmdx=-ddq(6); 
lmdy=-ddq(7);
 
dy = zeros(12,1);
dy(1)=dth1; 
dy(2)=dth2; 
dy(3)=dth3; 
dy(4)=dth4;
dy(5)=dth5;
%dy(6)=dlmdx; 
%dy(7)=dlmdy;
dy(8)=ddth1; 
dy(9)=ddth2; 
dy(10)=ddth3;
dy(11)=ddth4;
dy(12)=ddth5; 
%dy(12)=ddlmdy;
