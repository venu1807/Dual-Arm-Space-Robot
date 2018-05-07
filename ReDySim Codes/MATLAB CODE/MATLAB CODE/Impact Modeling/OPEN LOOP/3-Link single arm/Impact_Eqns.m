%clear all;
%clc;

function [thdotf ttf tbf]=Impact_eqns()

%syms x0 y0 th0 th1 th2 th3

%syms dx0 dy0 dth0 dth1 dth2 dth3

syms fx0 fy0 tau0 tau1 tau2 tau3

m0=500;m1=10;m2=10;m3=10; l0=1;l1=1;l2=1;l3=1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3;  
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05;

syms mt rx ry rz px py pz Itxx Ityy Itzz

mt=10; Itxx=1;Ityy=1; Itzz=1;

rx=0;ry=.5;

%PRE-IMPACT

Ti=0; Tf=20;
TiTf1=Ti:0.05:Tf
%%%%%%yy0=[0;0;0; 0.3803; -0.6198; 1.2867; pi-0.3803; 0.6198; -1.2867;0;0;0;0;0;0;0;0;0]; 

yy0=[0;0;0; 0.698;-1.571; 1.047;0;0;0;0;0;0];

[T,Y] = ode45(@rigid_1,TiTf1,yy0);

n=length(T)

x0=Y(n,1); y0=Y(n,2); th0=Y(n,3); th1=Y(n,4); th2=Y(n,5); th3=Y(n,6);
dx0=Y(n,7); dy0=Y(n,8); dth0=Y(n,9); dth1=Y(n,10); dth2=Y(n,11); dth3=Y(n,12);


thdoti=[dth1; dth2; dth3]

tti=[0.2;0;0]

%TARGET

%[Mt Jt]

Jt =[   1, 0, 0
  -ry, 1, 0
 rx, 0, 1];

Mt =[ Itzz,  0,  0
    0, mt,  0
    0,  0, mt];
 
%MANIPULATOR

%[JT I F c]

 %J=vpa(zeros(1:6,1:6));


M =[                                                                                                                                                                                              m0 + m1 + m2 + m3,                                                                                                                                                                                                            0,                                                                                                                                                    - (m2*(2*l1*sin(th0 + th1) + 2*lc0*sin(th0) + 2*lc2*sin(th0 + th1 + th2)))/2 - (m1*(2*lc1*sin(th0 + th1) + 2*lc0*sin(th0)))/2 - (m3*(2*lc3*sin(th0 + th1 + th2 + th3) + 2*l1*sin(th0 + th1) + 2*lc0*sin(th0) + 2*l2*sin(th0 + th1 + th2)))/2,                                                                                                                                                           - (m3*(2*lc3*sin(th0 + th1 + th2 + th3) + 2*l1*sin(th0 + th1) + 2*l2*sin(th0 + th1 + th2)))/2 - (m2*(2*l1*sin(th0 + th1) + 2*lc2*sin(th0 + th1 + th2)))/2 - lc1*m1*sin(th0 + th1),                                                                                                                           - (m3*(2*lc3*sin(th0 + th1 + th2 + th3) + 2*l2*sin(th0 + th1 + th2)))/2 - lc2*m2*sin(th0 + th1 + th2),                                                                -lc3*m3*sin(th0 + th1 + th2 + th3)
                                                                                                                                                                                                              0,                                                                                                                                                                                            m0 + m1 + m2 + m3,                                                                                                                                                      (m2*(2*l1*cos(th0 + th1) + 2*lc0*cos(th0) + 2*lc2*cos(th0 + th1 + th2)))/2 + (m1*(2*lc1*cos(th0 + th1) + 2*lc0*cos(th0)))/2 + (m3*(2*lc3*cos(th0 + th1 + th2 + th3) + 2*l1*cos(th0 + th1) + 2*lc0*cos(th0) + 2*l2*cos(th0 + th1 + th2)))/2,                                                                                                                                                             (m2*(2*l1*cos(th0 + th1) + 2*lc2*cos(th0 + th1 + th2)))/2 + (m3*(2*lc3*cos(th0 + th1 + th2 + th3) + 2*l1*cos(th0 + th1) + 2*l2*cos(th0 + th1 + th2)))/2 + lc1*m1*cos(th0 + th1),                                                                                                                             (m3*(2*lc3*cos(th0 + th1 + th2 + th3) + 2*l2*cos(th0 + th1 + th2)))/2 + lc2*m2*cos(th0 + th1 + th2),                                                                 lc3*m3*cos(th0 + th1 + th2 + th3)
 - m2*(l1*sin(th0 + th1) + lc0*sin(th0) + lc2*sin(th0 + th1 + th2)) - m1*(lc1*sin(th0 + th1) + lc0*sin(th0)) - m3*(lc3*sin(th0 + th1 + th2 + th3) + l1*sin(th0 + th1) + lc0*sin(th0) + l2*sin(th0 + th1 + th2)), m2*(l1*cos(th0 + th1) + lc0*cos(th0) + lc2*cos(th0 + th1 + th2)) + m1*(lc1*cos(th0 + th1) + lc0*cos(th0)) + m3*(lc3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l2*cos(th0 + th1 + th2)), Izz0 + Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc0^2*m1 + lc1^2*m1 + lc0^2*m2 + lc2^2*m2 + lc0^2*m3 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + 2*l2*lc0*m3*cos(th1 + th2) + 2*lc0*lc2*m2*cos(th1 + th2) + 2*l1*l2*m3*cos(th2) + 2*l1*lc0*m2*cos(th1) + 2*l1*lc2*m2*cos(th2) + 2*l1*lc0*m3*cos(th1) + 2*l2*lc3*m3*cos(th3) + 2*lc0*lc1*m1*cos(th1) + 2*lc0*lc3*m3*cos(th1 + th2 + th3), Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc1^2*m1 + lc2^2*m2 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + l2*lc0*m3*cos(th1 + th2) + lc0*lc2*m2*cos(th1 + th2) + 2*l1*l2*m3*cos(th2) + l1*lc0*m2*cos(th1) + 2*l1*lc2*m2*cos(th2) + l1*lc0*m3*cos(th1) + 2*l2*lc3*m3*cos(th3) + lc0*lc1*m1*cos(th1) + lc0*lc3*m3*cos(th1 + th2 + th3), Izz2 + Izz3 + l2^2*m3 + lc2^2*m2 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc0*m3*cos(th1 + th2) + lc0*lc2*m2*cos(th1 + th2) + l1*l2*m3*cos(th2) + l1*lc2*m2*cos(th2) + 2*l2*lc3*m3*cos(th3) + lc0*lc3*m3*cos(th1 + th2 + th3), Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3) + lc0*lc3*m3*cos(th1 + th2 + th3)
                                                - m3*(lc3*sin(th0 + th1 + th2 + th3) + l1*sin(th0 + th1) + l2*sin(th0 + th1 + th2)) - m2*(l1*sin(th0 + th1) + lc2*sin(th0 + th1 + th2)) - lc1*m1*sin(th0 + th1),                                                m2*(l1*cos(th0 + th1) + lc2*cos(th0 + th1 + th2)) + m3*(lc3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l2*cos(th0 + th1 + th2)) + lc1*m1*cos(th0 + th1),                                                     Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc1^2*m1 + lc2^2*m2 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + l2*lc0*m3*cos(th1 + th2) + lc0*lc2*m2*cos(th1 + th2) + 2*l1*l2*m3*cos(th2) + l1*lc0*m2*cos(th1) + 2*l1*lc2*m2*cos(th2) + l1*lc0*m3*cos(th1) + 2*l2*lc3*m3*cos(th3) + lc0*lc1*m1*cos(th1) + lc0*lc3*m3*cos(th1 + th2 + th3),                                                                                                                                                          Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc1^2*m1 + lc2^2*m2 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + 2*l1*l2*m3*cos(th2) + 2*l1*lc2*m2*cos(th2) + 2*l2*lc3*m3*cos(th3),                                                                                          m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3,                                   Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3)
                                                                                                                  - m3*(lc3*sin(th0 + th1 + th2 + th3) + l2*sin(th0 + th1 + th2)) - lc2*m2*sin(th0 + th1 + th2),                                                                                                                  m3*(lc3*cos(th0 + th1 + th2 + th3) + l2*cos(th0 + th1 + th2)) + lc2*m2*cos(th0 + th1 + th2),                                                                                                                                                                 Izz2 + Izz3 + l2^2*m3 + lc2^2*m2 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc0*m3*cos(th1 + th2) + lc0*lc2*m2*cos(th1 + th2) + l1*l2*m3*cos(th2) + l1*lc2*m2*cos(th2) + 2*l2*lc3*m3*cos(th3) + lc0*lc3*m3*cos(th1 + th2 + th3),                                                                                                                                                                                                      m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3,                                                                                                                                                              m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3,                                                              m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3
                                                                                                                                                                             -lc3*m3*sin(th0 + th1 + th2 + th3),                                                                                                                                                                            lc3*m3*cos(th0 + th1 + th2 + th3),                                                                                                                                                                                                                                                                                               Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3) + lc0*lc3*m3*cos(th1 + th2 + th3),                                                                                                                                                                                                                                                                             Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3),                                                                                                                                                                                            m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                                                                                   m3*lc3^2 + Izz3];


C =[                                                                                                                                                                                                                                                    - dth0^2*l2*m3*cos(th0 + th1 + th2) - dth1^2*l2*m3*cos(th0 + th1 + th2) - dth2^2*l2*m3*cos(th0 + th1 + th2) - dth0^2*lc2*m2*cos(th0 + th1 + th2) - dth1^2*lc2*m2*cos(th0 + th1 + th2) - dth2^2*lc2*m2*cos(th0 + th1 + th2) - dth0^2*lc3*m3*cos(th0 + th1 + th2 + th3) - dth1^2*lc3*m3*cos(th0 + th1 + th2 + th3) - dth2^2*lc3*m3*cos(th0 + th1 + th2 + th3) - dth3^2*lc3*m3*cos(th0 + th1 + th2 + th3) - dth0^2*l1*m2*cos(th0 + th1) - dth1^2*l1*m2*cos(th0 + th1) - dth0^2*l1*m3*cos(th0 + th1) - dth1^2*l1*m3*cos(th0 + th1) - dth0^2*lc1*m1*cos(th0 + th1) - dth1^2*lc1*m1*cos(th0 + th1) - dth0^2*lc0*m1*cos(th0) - dth0^2*lc0*m2*cos(th0) - dth0^2*lc0*m3*cos(th0) - 2*dth0*dth1*l2*m3*cos(th0 + th1 + th2) - 2*dth0*dth2*l2*m3*cos(th0 + th1 + th2) - 2*dth1*dth2*l2*m3*cos(th0 + th1 + th2) - 2*dth0*dth1*lc2*m2*cos(th0 + th1 + th2) - 2*dth0*dth2*lc2*m2*cos(th0 + th1 + th2) - 2*dth1*dth2*lc2*m2*cos(th0 + th1 + th2) - 2*dth0*dth1*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth0*dth2*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth0*dth3*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth1*dth2*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth1*dth3*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth2*dth3*lc3*m3*cos(th0 + th1 + th2 + th3) - 2*dth0*dth1*l1*m2*cos(th0 + th1) - 2*dth0*dth1*l1*m3*cos(th0 + th1) - 2*dth0*dth1*lc1*m1*cos(th0 + th1)
                                                                                                                                                                                                                                                    - dth0^2*l2*m3*sin(th0 + th1 + th2) - dth1^2*l2*m3*sin(th0 + th1 + th2) - dth2^2*l2*m3*sin(th0 + th1 + th2) - dth0^2*lc2*m2*sin(th0 + th1 + th2) - dth1^2*lc2*m2*sin(th0 + th1 + th2) - dth2^2*lc2*m2*sin(th0 + th1 + th2) - dth0^2*lc3*m3*sin(th0 + th1 + th2 + th3) - dth1^2*lc3*m3*sin(th0 + th1 + th2 + th3) - dth2^2*lc3*m3*sin(th0 + th1 + th2 + th3) - dth3^2*lc3*m3*sin(th0 + th1 + th2 + th3) - dth0^2*l1*m2*sin(th0 + th1) - dth1^2*l1*m2*sin(th0 + th1) - dth0^2*l1*m3*sin(th0 + th1) - dth1^2*l1*m3*sin(th0 + th1) - dth0^2*lc1*m1*sin(th0 + th1) - dth1^2*lc1*m1*sin(th0 + th1) - dth0^2*lc0*m1*sin(th0) - dth0^2*lc0*m2*sin(th0) - dth0^2*lc0*m3*sin(th0) - 2*dth0*dth1*l2*m3*sin(th0 + th1 + th2) - 2*dth0*dth2*l2*m3*sin(th0 + th1 + th2) - 2*dth1*dth2*l2*m3*sin(th0 + th1 + th2) - 2*dth0*dth1*lc2*m2*sin(th0 + th1 + th2) - 2*dth0*dth2*lc2*m2*sin(th0 + th1 + th2) - 2*dth1*dth2*lc2*m2*sin(th0 + th1 + th2) - 2*dth0*dth1*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth0*dth2*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth0*dth3*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth1*dth2*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth1*dth3*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth2*dth3*lc3*m3*sin(th0 + th1 + th2 + th3) - 2*dth0*dth1*l1*m2*sin(th0 + th1) - 2*dth0*dth1*l1*m3*sin(th0 + th1) - 2*dth0*dth1*lc1*m1*sin(th0 + th1)
 - dth2^2*l1*lc3*m3*sin(th2 + th3) - dth3^2*l1*lc3*m3*sin(th2 + th3) - dth1^2*l2*lc0*m3*sin(th1 + th2) - dth2^2*l2*lc0*m3*sin(th1 + th2) - dth1^2*lc0*lc2*m2*sin(th1 + th2) - dth2^2*lc0*lc2*m2*sin(th1 + th2) - dth2^2*l1*l2*m3*sin(th2) - dth1^2*l1*lc0*m2*sin(th1) - dth2^2*l1*lc2*m2*sin(th2) - dth1^2*l1*lc0*m3*sin(th1) - dth3^2*l2*lc3*m3*sin(th3) - dth1^2*lc0*lc1*m1*sin(th1) - dth1^2*lc0*lc3*m3*sin(th1 + th2 + th3) - dth2^2*lc0*lc3*m3*sin(th1 + th2 + th3) - dth3^2*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth0*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth0*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth2*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth0*dth1*l2*lc0*m3*sin(th1 + th2) - 2*dth0*dth2*l2*lc0*m3*sin(th1 + th2) - 2*dth1*dth2*l2*lc0*m3*sin(th1 + th2) - 2*dth0*dth1*lc0*lc2*m2*sin(th1 + th2) - 2*dth0*dth2*lc0*lc2*m2*sin(th1 + th2) - 2*dth1*dth2*lc0*lc2*m2*sin(th1 + th2) - 2*dth0*dth2*l1*l2*m3*sin(th2) - 2*dth1*dth2*l1*l2*m3*sin(th2) - 2*dth0*dth1*l1*lc0*m2*sin(th1) - 2*dth0*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2) - 2*dth0*dth1*l1*lc0*m3*sin(th1) - 2*dth0*dth3*l2*lc3*m3*sin(th3) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3) - 2*dth0*dth1*lc0*lc1*m1*sin(th1) - 2*dth0*dth1*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth0*dth2*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth0*dth3*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth1*dth2*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth1*dth3*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth2*dth3*lc0*lc3*m3*sin(th1 + th2 + th3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               dth0^2*l2*lc0*m3*sin(th1 + th2) - dth3^2*l1*lc3*m3*sin(th2 + th3) - dth2^2*l1*lc3*m3*sin(th2 + th3) + dth0^2*lc0*lc2*m2*sin(th1 + th2) - dth2^2*l1*l2*m3*sin(th2) + dth0^2*l1*lc0*m2*sin(th1) - dth2^2*l1*lc2*m2*sin(th2) + dth0^2*l1*lc0*m3*sin(th1) - dth3^2*l2*lc3*m3*sin(th3) + dth0^2*lc0*lc1*m1*sin(th1) + dth0^2*lc0*lc3*m3*sin(th1 + th2 + th3) - 2*dth0*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth0*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth2*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth0*dth2*l1*l2*m3*sin(th2) - 2*dth1*dth2*l1*l2*m3*sin(th2) - 2*dth0*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2) - 2*dth0*dth3*l2*lc3*m3*sin(th3) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          dth0^2*l1*lc3*m3*sin(th2 + th3) + dth1^2*l1*lc3*m3*sin(th2 + th3) + dth0^2*l2*lc0*m3*sin(th1 + th2) + dth0^2*lc0*lc2*m2*sin(th1 + th2) + dth0^2*l1*l2*m3*sin(th2) + dth1^2*l1*l2*m3*sin(th2) + dth0^2*l1*lc2*m2*sin(th2) + dth1^2*l1*lc2*m2*sin(th2) - dth3^2*l2*lc3*m3*sin(th3) + dth0^2*lc0*lc3*m3*sin(th1 + th2 + th3) + 2*dth0*dth1*l1*lc3*m3*sin(th2 + th3) + 2*dth0*dth1*l1*l2*m3*sin(th2) + 2*dth0*dth1*l1*lc2*m2*sin(th2) - 2*dth0*dth3*l2*lc3*m3*sin(th3) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   lc3*m3*(dth0^2*l1*sin(th2 + th3) + dth1^2*l1*sin(th2 + th3) + dth0^2*l2*sin(th3) + dth1^2*l2*sin(th3) + dth2^2*l2*sin(th3) + dth0^2*lc0*sin(th1 + th2 + th3) + 2*dth0*dth1*l1*sin(th2 + th3) + 2*dth0*dth1*l2*sin(th3) + 2*dth0*dth2*l2*sin(th3) + 2*dth1*dth2*l2*sin(th3))];

%M=simplify(M);
Ib=M(1:3,1:3);
Ibm=M(1:3,4:6);
Im=M(4:6,4:6);

%C=simplify(C);
Cb=C(1:3,1);
Cm=C(4:6,1);


J1=zeros(3,2);
  
J2 =[ - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l2*sin(th0 + th1 + th2), - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l2*sin(th0 + th1 + th2), - l3*sin(th0 + th1 + th2 + th3) - l2*sin(th0 + th1 + th2), -l3*sin(th0 + th1 + th2 + th3)
   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l2*cos(th0 + th1 + th2),   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l2*cos(th0 + th1 + th2),   l3*cos(th0 + th1 + th2 + th3) + l2*cos(th0 + th1 + th2),  l3*cos(th0 + th1 + th2 + th3)];

J(1:3,1:2)=J1;
J(2:3,3:6)=J2;
J(1,3:6)=ones(1,4);

%J=simplify(J);
Jbe=J(:,1:3);
Jme=J(:,4:6);

F=[fx0; fy0; tau0; tau1; tau2; tau3];

Fb=F(1:3);
Fm=F(4:6);

%M(4:5,1:2)=J
%M(1:2,4:5)=J.'


%GENERALISED MATRICES

%Ib=simplify(Ib);
%Im=simplify(Im);
%Ibm=simplify(Ibm);

Ibinv=inv(Ib);
%Ibinv=simplify(Ibinv);
I=Im-(Ibm.'*Ibinv*Ibm);
%I=simplify(I);                        %GIM
%c=Cm-(Ibm.'*Ibinv*Cb);               %GCFM
%c=simplify(c);
%F=Fm-(Ibm.'*Ibinv*Fb);
%F=simplify(F);                     %GTM
JT=Jme.'-(Ibm.'*Ibinv*(Jbe.'));
%JT=simplify(JT);                  %GJM

G=I+JT*(pinv(Jt.'))*Mt*(pinv(Jt))*(JT.')

H=JT*(pinv(Jt.'))*Mt*tti+(I*thdoti)

thdotf=(inv(G))*H

ttf=pinv(Jt)*(JT.')*thdotf


Ibm =[                                                  - 15*sin(th0 + th1 + th2) - 5*sin(th0 + th1 + th2 + th3) - 25*sin(th0 + th1),                                                   - 15*sin(th0 + th1 + th2) - 5*sin(th0 + th1 + th2 + th3),                                      -5*sin(th0 + th1 + th2 + th3)
                                                    15*cos(th0 + th1 + th2) + 5*cos(th0 + th1 + th2 + th3) + 25*cos(th0 + th1),                                                     15*cos(th0 + th1 + th2) + 5*cos(th0 + th1 + th2 + th3),                                       5*cos(th0 + th1 + th2 + th3)
 (5*cos(th1 + th2 + th3))/2 + (15*cos(th1 + th2))/2 + 10*cos(th2 + th3) + (25*cos(th1))/2 + 30*cos(th2) + 10*cos(th3) + 813/20, (5*cos(th1 + th2 + th3))/2 + (15*cos(th1 + th2))/2 + 5*cos(th2 + th3) + 15*cos(th2) + 10*cos(th3) + 171/10, (5*cos(th1 + th2 + th3))/2 + 5*cos(th2 + th3) + 5*cos(th3) + 71/20];


 
Ibinv =[ -(3750*cos(2*th0 + th1) + 125*cos(2*th0 + 2*th1 + 2*th2 + 2*th3) - 25750*cos(th1 + th2 + th3) + 1125*cos(2*th0) + 1125*cos(2*th0 + 2*th1 + 2*th2) + 1250*cos(2*th0 + 2*th1 + th2 + th3) + 3125*cos(2*th0 + 2*th1) + 2250*cos(2*th0 + th1 + th2) - 77250*cos(th1 + th2) - 51750*cos(th2 + th3) + 750*cos(2*th0 + 2*th1 + 2*th2 + th3) - 128750*cos(th1) - 155250*cos(th2) - 52250*cos(th3) + 3750*cos(2*th0 + 2*th1 + th2) + 750*cos(2*th0 + th1 + th2 + th3) - 692828)/(13250000*cos(th1 + th2 + th3) + 39750000*cos(th1 + th2) + 26765000*cos(th2 + th3) + 66250000*cos(th1) + 80295000*cos(th2) + 27295000*cos(th3) + 364283840),                                                                                                                                                      -(150*sin(2*th0 + th1 + th2 + th3) + 750*sin(2*th0 + th1) + 25*sin(2*th0 + 2*th1 + 2*th2 + 2*th3) + 225*sin(2*th0) + 225*sin(2*th0 + 2*th1 + 2*th2) + 250*sin(2*th0 + 2*th1 + th2 + th3) + 625*sin(2*th0 + 2*th1) + 450*sin(2*th0 + th1 + th2) + 150*sin(2*th0 + 2*th1 + 2*th2 + th3) + 750*sin(2*th0 + 2*th1 + th2))/(2650000*cos(th1 + th2 + th3) + 7950000*cos(th1 + th2) + 5353000*cos(th2 + th3) + 13250000*cos(th1) + 16059000*cos(th2) + 5459000*cos(th3) + 72856768),  (75*sin(th0 + th1 + th2) + 25*sin(th0 + th1 + th2 + th3) + 125*sin(th0 + th1) + 75*sin(th0))/(12500*cos(th1 + th2 + th3) + 37500*cos(th1 + th2) + 25250*cos(th2 + th3) + 62500*cos(th1) + 75750*cos(th2) + 25750*cos(th3) + 343664)
                                                                                                                                                       -(150*sin(2*th0 + th1 + th2 + th3) + 750*sin(2*th0 + th1) + 25*sin(2*th0 + 2*th1 + 2*th2 + 2*th3) + 225*sin(2*th0) + 225*sin(2*th0 + 2*th1 + 2*th2) + 250*sin(2*th0 + 2*th1 + th2 + th3) + 625*sin(2*th0 + 2*th1) + 450*sin(2*th0 + th1 + th2) + 150*sin(2*th0 + 2*th1 + 2*th2 + th3) + 750*sin(2*th0 + 2*th1 + th2))/(2650000*cos(th1 + th2 + th3) + 7950000*cos(th1 + th2) + 5353000*cos(th2 + th3) + 13250000*cos(th1) + 16059000*cos(th2) + 5459000*cos(th3) + 72856768), (3750*cos(2*th0 + th1) + 125*cos(2*th0 + 2*th1 + 2*th2 + 2*th3) + 25750*cos(th1 + th2 + th3) + 1125*cos(2*th0) + 1125*cos(2*th0 + 2*th1 + 2*th2) + 1250*cos(2*th0 + 2*th1 + th2 + th3) + 3125*cos(2*th0 + 2*th1) + 2250*cos(2*th0 + th1 + th2) + 77250*cos(th1 + th2) + 51750*cos(th2 + th3) + 750*cos(2*th0 + 2*th1 + 2*th2 + th3) + 128750*cos(th1) + 155250*cos(th2) + 52250*cos(th3) + 3750*cos(2*th0 + 2*th1 + th2) + 750*cos(2*th0 + th1 + th2 + th3) + 692828)/(13250000*cos(th1 + th2 + th3) + 39750000*cos(th1 + th2) + 26765000*cos(th2 + th3) + 66250000*cos(th1) + 80295000*cos(th2) + 27295000*cos(th3) + 364283840), -(75*cos(th0 + th1 + th2) + 25*cos(th0 + th1 + th2 + th3) + 125*cos(th0 + th1) + 75*cos(th0))/(12500*cos(th1 + th2 + th3) + 37500*cos(th1 + th2) + 25250*cos(th2 + th3) + 62500*cos(th1) + 75750*cos(th2) + 25750*cos(th3) + 343664)
                                                                                                                                                                                                                                                                                                                                                                                                (75*sin(th0 + th1 + th2) + 25*sin(th0 + th1 + th2 + th3) + 125*sin(th0 + th1) + 75*sin(th0))/(12500*cos(th1 + th2 + th3) + 37500*cos(th1 + th2) + 25250*cos(th2 + th3) + 62500*cos(th1) + 75750*cos(th2) + 25750*cos(th3) + 343664),                                                                                                                                                                                                                                                                                                                                                                                              -(75*cos(th0 + th1 + th2) + 25*cos(th0 + th1 + th2 + th3) + 125*cos(th0 + th1) + 75*cos(th0))/(12500*cos(th1 + th2 + th3) + 37500*cos(th1 + th2) + 25250*cos(th2 + th3) + 62500*cos(th1) + 75750*cos(th2) + 25750*cos(th3) + 343664),                                                                                           1325/(6250*cos(th1 + th2 + th3) + 18750*cos(th1 + th2) + 12625*cos(th2 + th3) + 31250*cos(th1) + 37875*cos(th2) + 12875*cos(th3) + 171832)];
 tbf=-Ibinv*Ibm*thdotf; 