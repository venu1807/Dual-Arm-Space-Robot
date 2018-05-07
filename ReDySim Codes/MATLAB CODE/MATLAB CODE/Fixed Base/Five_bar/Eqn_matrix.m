clc;
clear all;

syms m0 m1 m2 m3 m4 lc0 lc1 lc2 lc3 lc4 th1 th2 th3 th4 l0 l1 l2 l3 l4 Izz0 Izz1 Izz2 Izz3 Izz4 t
syms dth1 dth2 dth3 dth4
syms tau1 tau2 tau3 tau4

M1 =[ m2*l1^2 + 2*m2*cos(th2)*l1*lc2 + m1*lc1^2 + m2*lc2^2 + Izz1 + Izz2, m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2
                               m2*lc2^2 + l1*m2*cos(th2)*lc2 + Izz2,                      m2*lc2^2 + Izz2]
 
 
C1 =[ m2*((981*lc2*cos(th1 + th2))/100 + (981*l1*cos(th1))/100) - dth2*(2*dth1*l1*lc2*m2*sin(th2) + dth2*l1*lc2*m2*sin(th2)) + (981*lc1*m1*cos(th1))/100
                                                                                         (lc2*m2*(100*l1*sin(th2)*dth1^2 + 981*cos(th1 + th2)))/100]
 
M2 =[ m4*l3^2 + 2*m4*cos(th4)*l3*lc4 + m3*lc3^2 + m4*lc4^2 + Izz3 + Izz4, m4*lc4^2 + l3*m4*cos(th4)*lc4 + Izz4
                               m4*lc4^2 + l3*m4*cos(th4)*lc4 + Izz4,                      m4*lc4^2 + Izz4]
 
 
C2 =[ m4*((981*lc4*cos(th3 + th4))/100 + (981*l3*cos(th3))/100) - dth4*(2*dth3*l3*lc4*m4*sin(th4) + dth4*l3*lc4*m4*sin(th4)) + (981*lc3*m3*cos(th3))/100
                                                                                         (lc4*m4*(100*l3*sin(th4)*dth3^2 + 981*cos(th3 + th4)))/100]
 
J1=[ - l2*sin(th1 + th2) - l1*sin(th1), -l2*sin(th1 + th2)
   l2*cos(th1 + th2) + l1*cos(th1),  l2*cos(th1 + th2)]

J2=[ - l4*sin(th3 + th4) - l3*sin(th3), -l4*sin(th3 + th4)
   l4*cos(th3 + th4) + l3*cos(th3),  l4*cos(th3 + th4)]

J(:,1:2)=J1;
J(:,3:4)=-J2;

Jdt=diff(J,th1)*dth1+diff(J,th2)*dth2+diff(J,th3)*dth3+diff(J,th4)*dth4
Jdtdq=simplify(Jdt*[dth1;dth2; dth3;dth4])
I(1:2,1:2)=M1
I(3:4,3:4)=M2
%M(4:5,1:2)=J
%M(1:2,4:5)=J.'
C=[C1;C2]