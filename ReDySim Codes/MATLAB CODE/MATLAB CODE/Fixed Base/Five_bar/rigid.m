%clc;
%clear all;

function dy = rigid(t,y)

th1=y(1); th2=y(2); th3=y(3);th4=y(4); lmdx=y(5); lmdy=y(6) ;
dth1=y(7); dth2=y(8); dth3=y(9); dth4=y(10);

%INPUT DATA
Ti=0;Tf=5;

%[ddq]= accln()

% Link lengths
l1=1%0.05; %crank
l2=1%0.13; %output link 
l3=1%0.1; %connecting link
l0=1%0.15;%fixed base
l4=1%.2;

m0=500;m1=.1;m2=.1;m3=.1;m4=.1;         %l0=1;l1=1;l2=1;l3=1; m0=500;m1=1.5;m2=5;m3=3;m4=1;     
lc0=.5*l0;lc1=.5*l1;lc2=.5*l2; lc3=.5*l3; lc4=.5*l4; 
Izz0=83.61;
Izz1=(1/12)*m1*l1*l1; %1.05; 
Izz2=(1/12)*m2*l2*l2; %1.05;   
Izz3=(1/12)*m3*l3*l3; %1.05;
Izz4=(1/12)*m4*l4*l4; %1.05;


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

F=[tau1; tau2; tau3; tau4];

I =[ m2*l1^2 + 2*m2*cos(th2)*l1*lc2 + m1*lc1^2 + m2*lc2^2 + Izz1 + Izz2, m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2,                                                                  0,                                    0
                               m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2,                      m2*lc2^2 + Izz2,                                                                  0,                                    0
                                                                  0,                                    0, m4*l3^2 + 2*m4*cos(th4)*l3*lc4 + m3*lc3^2 + m4*lc4^2 + Izz3 + Izz4, m4*lc4^2 + l3*m4*cos(th4)*lc4 + Izz4
                                                                  0,                                    0,                               m4*lc4^2 + l3*m4*cos(th4)*lc4 + Izz4,                      m4*lc4^2 + Izz4]
 
 
C =[m2*((981*lc2*cos(th1 + th2))/100 + (981*l1*cos(th1))/100) - dth2*(2*dth1*l1*lc2*m2*sin(th2) + dth2*l1*lc2*m2*sin(th2)) + (981*lc1*m1*cos(th1))/100
                                                                                         (lc2*m2*(100*l1*sin(th2)*dth1^2 + 981*cos(th1 + th2)))/100
 m4*((981*lc4*cos(th3 + th4))/100 + (981*l3*cos(th3))/100) - dth4*(2*dth3*l3*lc4*m4*sin(th4) + dth4*l3*lc4*m4*sin(th4)) + (981*lc3*m3*cos(th3))/100
                                                                                         (lc4*m4*(100*l3*sin(th4)*dth3^2 + 981*cos(th3 + th4)))/100]
 
J =[ - l2*sin(th1 + th2) - l1*sin(th1), -l2*sin(th1 + th2),   l4*sin(th3 + th4) + l3*sin(th3),  l4*sin(th3 + th4)
   l2*cos(th1 + th2) + l1*cos(th1),  l2*cos(th1 + th2), - l4*cos(th3 + th4) - l3*cos(th3), -l4*cos(th3 + th4)]
                                                                             


Jdtdq =[ dth3^2*l4*cos(th3 + th4) - dth2^2*l2*cos(th1 + th2) - dth1^2*l2*cos(th1 + th2) + dth4^2*l4*cos(th3 + th4) - dth1^2*l1*cos(th1) + dth3^2*l3*cos(th3) - 2*dth1*dth2*l2*cos(th1 + th2) + 2*dth3*dth4*l4*cos(th3 + th4)
 dth3^2*l4*sin(th3 + th4) - dth2^2*l2*sin(th1 + th2) - dth1^2*l2*sin(th1 + th2) + dth4^2*l4*sin(th3 + th4) - dth1^2*l1*sin(th1) + dth3^2*l3*sin(th3) - 2*dth1*dth2*l2*sin(th1 + th2) + 2*dth3*dth4*l4*sin(th3 + th4)]
 
 
 M(1:4,1:4)=I;
 M(1:4,5:6)=J.';
 M(5:6,1:4)=J;
 
 Minv=inv(M);
 
 F1=[F;0;0]-[C;0;0];
 F2=(J.'*[lmdx;lmdy]);
 F3=[0;0;0;0;-Jdtdq];
 Ff=F1+[F2;0;0]+F3;
 
 ddq=Minv*Ff;

%ddq=[ddp;lmdx;lmdy]

ddth1=ddq(1);
ddth2=ddq(2);
ddth3=ddq(3);
ddth4=ddq(4);
lmdx=-ddq(5); 
lmdy=-ddq(6);
 
dy = zeros(10,1);
dy(1)=dth1; 
dy(2)=dth2; 
dy(3)=dth3; 
dy(4)=dth4;
%dy(5)=dlmdx; 
%dy(6)=dlmdy;
dy(7)=ddth1; 
dy(8)=ddth2; 
dy(9)=ddth3;
dy(10)=ddth4;
%dy(11)=ddlmdx; 
%dy(12)=ddlmdy;
