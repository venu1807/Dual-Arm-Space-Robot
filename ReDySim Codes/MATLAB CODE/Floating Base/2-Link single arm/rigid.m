%clc;
%clear all;

function dy = rigid(t,y)

x0=y(1); y0=y(2); th0=y(3); th1=y(4); th2=y(5) ;
dx0=y(6); dy0=y(7); dth0=y(8); dth1=y(9); dth2=y(10);

%INPUT DATA
Ti=0;Tf=30;
%[ddq]= accln()

m0=500;m1=10;m2=10; l0=1;l1=1;l2=1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;  
Izz0=83.61; Izz1=1.05; Izz2=1.05;   


fx0=0; fy0=0; tau0=0; %tau1=10; tau2=10;

thin=[0;   0];%60
thf=[-pi/2; -pi/2];


 th1_d=thin(1)+((thf(1)-thin(1))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth1_d=((thf(1)-thin(1))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth1_d=(2*pi*(thf(1)-thin(1))/(Tf*Tf))*sin((2*pi/Tf)*t);

    th2_d=thin(2)+((thf(2)-thin(2))/Tf)*(t-(Tf/(2*pi))*sin((2*pi/Tf)*t));
    dth2_d=((thf(2)-thin(2))/Tf)*(1-cos((2*pi/Tf)*t));
    ddth2_d=(2*pi*(thf(2)-thin(2))/(Tf*Tf))*sin((2*pi/Tf)*t);

kp=49; kd=14;
%kp=5000; kd=1000;
tau1=-kp*(th1-th1_d)-kd*(dth1-dth1_d);  
tau2=-kp*(th2-th2_d)-kd*(dth2-dth2_d);

F=[fx0; fy0; tau0; tau1; tau2];


M =[                                                                                                m0 + m1 + m2,                                                                                                         0,                                                - (m2*(2*l1*sin(th0 + th1) + 2*lc0*sin(th0) + 2*lc2*sin(th0 + th1 + th2)))/2 - (m1*(2*lc1*sin(th0 + th1) + 2*lc0*sin(th0)))/2,                                                       - (m2*(2*l1*sin(th0 + th1) + 2*lc2*sin(th0 + th1 + th2)))/2 - lc1*m1*sin(th0 + th1),                                     -lc2*m2*sin(th0 + th1 + th2)
                                                                                                           0,                                                                                              m0 + m1 + m2,                                                  (m2*(2*l1*cos(th0 + th1) + 2*lc0*cos(th0) + 2*lc2*cos(th0 + th1 + th2)))/2 + (m1*(2*lc1*cos(th0 + th1) + 2*lc0*cos(th0)))/2,                                                         (m2*(2*l1*cos(th0 + th1) + 2*lc2*cos(th0 + th1 + th2)))/2 + lc1*m1*cos(th0 + th1),                                      lc2*m2*cos(th0 + th1 + th2)
 - m2*(l1*sin(th0 + th1) + lc0*sin(th0) + lc2*sin(th0 + th1 + th2)) - m1*(lc1*sin(th0 + th1) + lc0*sin(th0)), m2*(l1*cos(th0 + th1) + lc0*cos(th0) + lc2*cos(th0 + th1 + th2)) + m1*(lc1*cos(th0 + th1) + lc0*cos(th0)), Izz0 + Izz1 + Izz2 + l1^2*m2 + lc0^2*m1 + lc1^2*m1 + lc0^2*m2 + lc2^2*m2 + 2*lc0*lc2*m2*cos(th1 + th2) + 2*l1*lc0*m2*cos(th1) + 2*l1*lc2*m2*cos(th2) + 2*lc0*lc1*m1*cos(th1), m2*l1^2 + 2*m2*cos(th2)*l1*lc2 + lc0*m2*cos(th1)*l1 + m1*lc1^2 + lc0*m1*cos(th1)*lc1 + m2*lc2^2 + lc0*m2*cos(th1 + th2)*lc2 + Izz1 + Izz2, Izz2 + lc2^2*m2 + lc0*lc2*m2*cos(th1 + th2) + l1*lc2*m2*cos(th2)
                                 - m2*(l1*sin(th0 + th1) + lc2*sin(th0 + th1 + th2)) - lc1*m1*sin(th0 + th1),                                 m2*(l1*cos(th0 + th1) + lc2*cos(th0 + th1 + th2)) + lc1*m1*cos(th0 + th1),                                    m2*l1^2 + 2*m2*cos(th2)*l1*lc2 + lc0*m2*cos(th1)*l1 + m1*lc1^2 + lc0*m1*cos(th1)*lc1 + m2*lc2^2 + lc0*m2*cos(th1 + th2)*lc2 + Izz1 + Izz2,                                                                        m2*l1^2 + 2*m2*cos(th2)*l1*lc2 + m1*lc1^2 + m2*lc2^2 + Izz1 + Izz2,                             m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2
                                                                                -lc2*m2*sin(th0 + th1 + th2),                                                                               lc2*m2*cos(th0 + th1 + th2),                                                                                                             Izz2 + lc2^2*m2 + lc0*lc2*m2*cos(th1 + th2) + l1*lc2*m2*cos(th2),                                                                                                      m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2,                                                  m2*lc2^2 + Izz2]
 

C =[ - dth0^2*lc2*m2*cos(th0 + th1 + th2) - dth1^2*lc2*m2*cos(th0 + th1 + th2) - dth2^2*lc2*m2*cos(th0 + th1 + th2) - dth0^2*l1*m2*cos(th0 + th1) - dth1^2*l1*m2*cos(th0 + th1) - dth0^2*lc1*m1*cos(th0 + th1) - dth1^2*lc1*m1*cos(th0 + th1) - dth0^2*lc0*m1*cos(th0) - dth0^2*lc0*m2*cos(th0) - 2*dth0*dth1*lc2*m2*cos(th0 + th1 + th2) - 2*dth0*dth2*lc2*m2*cos(th0 + th1 + th2) - 2*dth1*dth2*lc2*m2*cos(th0 + th1 + th2) - 2*dth0*dth1*l1*m2*cos(th0 + th1) - 2*dth0*dth1*lc1*m1*cos(th0 + th1)
 - dth0^2*lc2*m2*sin(th0 + th1 + th2) - dth1^2*lc2*m2*sin(th0 + th1 + th2) - dth2^2*lc2*m2*sin(th0 + th1 + th2) - dth0^2*l1*m2*sin(th0 + th1) - dth1^2*l1*m2*sin(th0 + th1) - dth0^2*lc1*m1*sin(th0 + th1) - dth1^2*lc1*m1*sin(th0 + th1) - dth0^2*lc0*m1*sin(th0) - dth0^2*lc0*m2*sin(th0) - 2*dth0*dth1*lc2*m2*sin(th0 + th1 + th2) - 2*dth0*dth2*lc2*m2*sin(th0 + th1 + th2) - 2*dth1*dth2*lc2*m2*sin(th0 + th1 + th2) - 2*dth0*dth1*l1*m2*sin(th0 + th1) - 2*dth0*dth1*lc1*m1*sin(th0 + th1)
                                                                         - dth1^2*lc0*lc2*m2*sin(th1 + th2) - dth2^2*lc0*lc2*m2*sin(th1 + th2) - dth1^2*l1*lc0*m2*sin(th1) - dth2^2*l1*lc2*m2*sin(th2) - dth1^2*lc0*lc1*m1*sin(th1) - 2*dth0*dth1*lc0*lc2*m2*sin(th1 + th2) - 2*dth0*dth2*lc0*lc2*m2*sin(th1 + th2) - 2*dth1*dth2*lc0*lc2*m2*sin(th1 + th2) - 2*dth0*dth1*l1*lc0*m2*sin(th1) - 2*dth0*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2) - 2*dth0*dth1*lc0*lc1*m1*sin(th1)
                                                                                                                                                                                                                                                                                                         dth0^2*lc0*lc2*m2*sin(th1 + th2) + dth0^2*l1*lc0*m2*sin(th1) - dth2^2*l1*lc2*m2*sin(th2) + dth0^2*lc0*lc1*m1*sin(th1) - 2*dth0*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2)
                                                                                                                                                                                                                                                                                                                                                                                          lc2*m2*(dth0^2*lc0*sin(th1 + th2) + dth0^2*l1*sin(th2) + dth1^2*l1*sin(th2) + 2*dth0*dth1*l1*sin(th2))]
 

Minv=inv(M)
                                                                                                                                             
ddq=Minv*(F-C)

ddx0=ddq(1);
ddy0=ddq(2);
ddth0=ddq(3);
ddth1=ddq(4); 
ddth2=ddq(5);
 
dy = zeros(10,1);
dy(1)=dx0; 
dy(2)=dy0; 
dy(3)=dth0; 
dy(4)=dth1; 
dy(5)=dth2;
dy(6)=ddx0; 
dy(7)=ddy0; 
dy(8)=ddth0; 
dy(9)=ddth1; 
dy(10)=ddth2;
