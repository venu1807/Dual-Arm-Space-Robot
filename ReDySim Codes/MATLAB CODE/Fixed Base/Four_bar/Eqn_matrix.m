clc;
clear all;

syms m0 m1 m2 m3 lc0 lc1 lc2 lc3 th1 th2 th3 l0 l1 l2 l3 Izz0 Izz1 Izz2 Izz3 t
syms dth1 dth2 dth3
syms tau1 tau2 tau3

M1 = m1*lc1^2 + Izz1
 
 
C1 =(981*lc1*m1*cos(th1))/100
 

M2 =[ m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3, m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3
                               m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                      m3*lc3^2 + Izz3]
 
 
C2 =[ m3*((981*lc3*cos(th2 + th3))/100 + (981*l2*cos(th2))/100) - dth3*(2*dth2*l2*lc3*m3*sin(th3) + dth3*l2*lc3*m3*sin(th3)) + (981*lc2*m2*cos(th2))/100
                                                                                         (lc3*m3*(100*l2*sin(th3)*dth2^2 + 981*cos(th2 + th3)))/100]
 
                                                                                         

  J =[l1*sin(th1), - l3*sin(th2 + th3) - l2*sin(th2),              -l3*sin(th2 + th3)
-l1*cos(th1),   l3*cos(th2 + th3) + l2*cos(th2), l3*cos(th2 + th3)]

Jdt=diff(J,th1)*dth1+diff(J,th2)*dth2+diff(J,th3)*dth3
Jdtdq=simplify(Jdt*[dth1;dth2; dth3])
I(1,1)=M1
I(2:3,2:3)=M2
%M(4:5,1:2)=J
%M(1:2,4:5)=J.'
C=[C1;C2]