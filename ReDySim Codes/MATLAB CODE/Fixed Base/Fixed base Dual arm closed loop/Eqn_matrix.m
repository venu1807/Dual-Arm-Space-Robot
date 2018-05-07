clc;
clear all;

syms m0 m1 m2 m3 m4 m5 m6 m7 lc0 lc1 lc2 lc3 lc4 lc5 lc6 lc7 th0 th1 th2 th3 th4 th5 th6 th7 l0 l1 l2 l3 l4 l5 l6 l7 Izz0 Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 Izz7 t
syms dth0 dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms fx fy tau0 tau1 tau2 tau3 tau4 tau5 tau6 tau7

  
M1 =[ Izz1 + Izz2 + Izz3 + l1^2*m2 + l1^2*m3 + l2^2*m3 + lc1^2*m1 + lc2^2*m2 + lc3^2*m3 + 2*l1*lc3*m3*cos(th2 + th3) + 2*l1*l2*m3*cos(th2) + 2*l1*lc2*m2*cos(th2) + 2*l2*lc3*m3*cos(th3), m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3, Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3)
                                             m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + l1*m3*cos(th2)*l2 + m2*lc2^2 + l1*m2*cos(th2)*lc2 + m3*lc3^2 + l1*m3*cos(th2 + th3)*lc3 + Izz2 + Izz3,                                                                     m3*l2^2 + 2*m3*cos(th3)*l2*lc3 + m2*lc2^2 + m3*lc3^2 + Izz2 + Izz3,                            m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3
                                                                                                                    Izz3 + lc3^2*m3 + l1*lc3*m3*cos(th2 + th3) + l2*lc3*m3*cos(th3),                                                                                                   m3*lc3^2 + l2*m3*cos(th3)*lc3 + Izz3,                                                 m3*lc3^2 + Izz3]
 
 
C1 =[(981*l1*m2*cos(th1))/100 + (981*l1*m3*cos(th1))/100 + (981*lc1*m1*cos(th1))/100 + (981*lc3*m3*cos(th1 + th2 + th3))/100 + (981*l2*m3*cos(th1 + th2))/100 + (981*lc2*m2*cos(th1 + th2))/100 - dth2^2*l1*lc3*m3*sin(th2 + th3) - dth3^2*l1*lc3*m3*sin(th2 + th3) - dth2^2*l1*l2*m3*sin(th2) - dth2^2*l1*lc2*m2*sin(th2) - dth3^2*l2*lc3*m3*sin(th3) - 2*dth1*dth2*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth2*dth3*l1*lc3*m3*sin(th2 + th3) - 2*dth1*dth2*l1*l2*m3*sin(th2) - 2*dth1*dth2*l1*lc2*m2*sin(th2) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                           (981*lc3*m3*cos(th1 + th2 + th3))/100 + (981*l2*m3*cos(th1 + th2))/100 + (981*lc2*m2*cos(th1 + th2))/100 + dth1^2*l1*lc3*m3*sin(th2 + th3) + dth1^2*l1*l2*m3*sin(th2) + dth1^2*l1*lc2*m2*sin(th2) - dth3^2*l2*lc3*m3*sin(th3) - 2*dth1*dth3*l2*lc3*m3*sin(th3) - 2*dth2*dth3*l2*lc3*m3*sin(th3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                      (lc3*m3*(981*cos(th1 + th2 + th3) + 100*dth1^2*l1*sin(th2 + th3) + 100*dth1^2*l2*sin(th3) + 100*dth2^2*l2*sin(th3) + 200*dth1*dth2*l2*sin(th3)))/100]
 
 
 M2 =[ Izz4 + Izz5 + Izz6 + Izz7 + l4^2*m5 + l4^2*m6 + l4^2*m7 + l5^2*m6 + l5^2*m7 + l6^2*m7 + lc4^2*m4 + lc5^2*m5 + lc6^2*m6 + lc7^2*m7 + 2*l4*l6*m7*cos(th5 + th6) + 2*l4*lc6*m6*cos(th5 + th6) + 2*l5*lc7*m7*cos(th6 + th7) + 2*l4*l5*m6*cos(th5) + 2*l4*l5*m7*cos(th5) + 2*l5*l6*m7*cos(th6) + 2*l4*lc5*m5*cos(th5) + 2*l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7) + 2*l4*lc7*m7*cos(th5 + th6 + th7), Izz5 + Izz6 + Izz7 + l5^2*m6 + l5^2*m7 + l6^2*m7 + lc5^2*m5 + lc6^2*m6 + lc7^2*m7 + l4*l6*m7*cos(th5 + th6) + l4*lc6*m6*cos(th5 + th6) + 2*l5*lc7*m7*cos(th6 + th7) + l4*l5*m6*cos(th5) + l4*l5*m7*cos(th5) + 2*l5*l6*m7*cos(th6) + l4*lc5*m5*cos(th5) + 2*l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7), Izz6 + Izz7 + l6^2*m7 + lc6^2*m6 + lc7^2*m7 + l4*l6*m7*cos(th5 + th6) + l4*lc6*m6*cos(th5 + th6) + l5*lc7*m7*cos(th6 + th7) + l5*l6*m7*cos(th6) + l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7), Izz7 + lc7^2*m7 + l5*lc7*m7*cos(th6 + th7) + l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7)
                                                             Izz5 + Izz6 + Izz7 + l5^2*m6 + l5^2*m7 + l6^2*m7 + lc5^2*m5 + lc6^2*m6 + lc7^2*m7 + l4*l6*m7*cos(th5 + th6) + l4*lc6*m6*cos(th5 + th6) + 2*l5*lc7*m7*cos(th6 + th7) + l4*l5*m6*cos(th5) + l4*l5*m7*cos(th5) + 2*l5*l6*m7*cos(th6) + l4*lc5*m5*cos(th5) + 2*l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7),                                                                                                                                                    Izz5 + Izz6 + Izz7 + l5^2*m6 + l5^2*m7 + l6^2*m7 + lc5^2*m5 + lc6^2*m6 + lc7^2*m7 + 2*l5*lc7*m7*cos(th6 + th7) + 2*l5*l6*m7*cos(th6) + 2*l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7),                                                                                       m7*l6^2 + 2*m7*cos(th7)*l6*lc7 + l5*m7*cos(th6)*l6 + m6*lc6^2 + l5*m6*cos(th6)*lc6 + m7*lc7^2 + l5*m7*cos(th6 + th7)*lc7 + Izz6 + Izz7,                                  Izz7 + lc7^2*m7 + l5*lc7*m7*cos(th6 + th7) + l6*lc7*m7*cos(th7)
                                                                                                                                                                      Izz6 + Izz7 + l6^2*m7 + lc6^2*m6 + lc7^2*m7 + l4*l6*m7*cos(th5 + th6) + l4*lc6*m6*cos(th5 + th6) + l5*lc7*m7*cos(th6 + th7) + l5*l6*m7*cos(th6) + l5*lc6*m6*cos(th6) + 2*l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7),                                                                                                                                                                                                m7*l6^2 + 2*m7*cos(th7)*l6*lc7 + l5*m7*cos(th6)*l6 + m6*lc6^2 + l5*m6*cos(th6)*lc6 + m7*lc7^2 + l5*m7*cos(th6 + th7)*lc7 + Izz6 + Izz7,                                                                                                                                                           m7*l6^2 + 2*m7*cos(th7)*l6*lc7 + m6*lc6^2 + m7*lc7^2 + Izz6 + Izz7,                                                             m7*lc7^2 + l6*m7*cos(th7)*lc7 + Izz7
                                                                                                                                                                                                                                                                                                  Izz7 + lc7^2*m7 + l5*lc7*m7*cos(th6 + th7) + l6*lc7*m7*cos(th7) + l4*lc7*m7*cos(th5 + th6 + th7),                                                                                                                                                                                                                                                                       Izz7 + lc7^2*m7 + l5*lc7*m7*cos(th6 + th7) + l6*lc7*m7*cos(th7),                                                                                                                                                                                         m7*lc7^2 + l6*m7*cos(th7)*lc7 + Izz7,                                                                                  m7*lc7^2 + Izz7]
 
 
C2 =[ (981*l4*m5*cos(th4))/100 + (981*l4*m6*cos(th4))/100 + (981*l4*m7*cos(th4))/100 + (981*lc4*m4*cos(th4))/100 + (981*l6*m7*cos(th4 + th5 + th6))/100 + (981*lc6*m6*cos(th4 + th5 + th6))/100 + (981*lc7*m7*cos(th4 + th5 + th6 + th7))/100 + (981*l5*m6*cos(th4 + th5))/100 + (981*l5*m7*cos(th4 + th5))/100 + (981*lc5*m5*cos(th4 + th5))/100 - dth5^2*l4*l6*m7*sin(th5 + th6) - dth6^2*l4*l6*m7*sin(th5 + th6) - dth5^2*l4*lc6*m6*sin(th5 + th6) - dth6^2*l4*lc6*m6*sin(th5 + th6) - dth6^2*l5*lc7*m7*sin(th6 + th7) - dth7^2*l5*lc7*m7*sin(th6 + th7) - dth5^2*l4*l5*m6*sin(th5) - dth5^2*l4*l5*m7*sin(th5) - dth6^2*l5*l6*m7*sin(th6) - dth5^2*l4*lc5*m5*sin(th5) - dth6^2*l5*lc6*m6*sin(th6) - dth7^2*l6*lc7*m7*sin(th7) - dth5^2*l4*lc7*m7*sin(th5 + th6 + th7) - dth6^2*l4*lc7*m7*sin(th5 + th6 + th7) - dth7^2*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth4*dth5*l4*l6*m7*sin(th5 + th6) - 2*dth4*dth6*l4*l6*m7*sin(th5 + th6) - 2*dth5*dth6*l4*l6*m7*sin(th5 + th6) - 2*dth4*dth5*l4*lc6*m6*sin(th5 + th6) - 2*dth4*dth6*l4*lc6*m6*sin(th5 + th6) - 2*dth5*dth6*l4*lc6*m6*sin(th5 + th6) - 2*dth4*dth6*l5*lc7*m7*sin(th6 + th7) - 2*dth4*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth5*dth6*l5*lc7*m7*sin(th6 + th7) - 2*dth5*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth6*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth4*dth5*l4*l5*m6*sin(th5) - 2*dth4*dth5*l4*l5*m7*sin(th5) - 2*dth4*dth6*l5*l6*m7*sin(th6) - 2*dth5*dth6*l5*l6*m7*sin(th6) - 2*dth4*dth5*l4*lc5*m5*sin(th5) - 2*dth4*dth6*l5*lc6*m6*sin(th6) - 2*dth5*dth6*l5*lc6*m6*sin(th6) - 2*dth4*dth7*l6*lc7*m7*sin(th7) - 2*dth5*dth7*l6*lc7*m7*sin(th7) - 2*dth6*dth7*l6*lc7*m7*sin(th7) - 2*dth4*dth5*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth4*dth6*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth4*dth7*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth5*dth6*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth5*dth7*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth6*dth7*l4*lc7*m7*sin(th5 + th6 + th7)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       (981*l6*m7*cos(th4 + th5 + th6))/100 + (981*lc6*m6*cos(th4 + th5 + th6))/100 + (981*lc7*m7*cos(th4 + th5 + th6 + th7))/100 + (981*l5*m6*cos(th4 + th5))/100 + (981*l5*m7*cos(th4 + th5))/100 + (981*lc5*m5*cos(th4 + th5))/100 + dth4^2*l4*l6*m7*sin(th5 + th6) + dth4^2*l4*lc6*m6*sin(th5 + th6) - dth6^2*l5*lc7*m7*sin(th6 + th7) - dth7^2*l5*lc7*m7*sin(th6 + th7) + dth4^2*l4*l5*m6*sin(th5) + dth4^2*l4*l5*m7*sin(th5) - dth6^2*l5*l6*m7*sin(th6) + dth4^2*l4*lc5*m5*sin(th5) - dth6^2*l5*lc6*m6*sin(th6) - dth7^2*l6*lc7*m7*sin(th7) + dth4^2*l4*lc7*m7*sin(th5 + th6 + th7) - 2*dth4*dth6*l5*lc7*m7*sin(th6 + th7) - 2*dth4*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth5*dth6*l5*lc7*m7*sin(th6 + th7) - 2*dth5*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth6*dth7*l5*lc7*m7*sin(th6 + th7) - 2*dth4*dth6*l5*l6*m7*sin(th6) - 2*dth5*dth6*l5*l6*m7*sin(th6) - 2*dth4*dth6*l5*lc6*m6*sin(th6) - 2*dth5*dth6*l5*lc6*m6*sin(th6) - 2*dth4*dth7*l6*lc7*m7*sin(th7) - 2*dth5*dth7*l6*lc7*m7*sin(th7) - 2*dth6*dth7*l6*lc7*m7*sin(th7)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   (981*l6*m7*cos(th4 + th5 + th6))/100 + (981*lc6*m6*cos(th4 + th5 + th6))/100 + (981*lc7*m7*cos(th4 + th5 + th6 + th7))/100 + dth4^2*l4*l6*m7*sin(th5 + th6) + dth4^2*l4*lc6*m6*sin(th5 + th6) + dth4^2*l5*lc7*m7*sin(th6 + th7) + dth5^2*l5*lc7*m7*sin(th6 + th7) + dth4^2*l5*l6*m7*sin(th6) + dth5^2*l5*l6*m7*sin(th6) + dth4^2*l5*lc6*m6*sin(th6) + dth5^2*l5*lc6*m6*sin(th6) - dth7^2*l6*lc7*m7*sin(th7) + dth4^2*l4*lc7*m7*sin(th5 + th6 + th7) + 2*dth4*dth5*l5*lc7*m7*sin(th6 + th7) + 2*dth4*dth5*l5*l6*m7*sin(th6) + 2*dth4*dth5*l5*lc6*m6*sin(th6) - 2*dth4*dth7*l6*lc7*m7*sin(th7) - 2*dth5*dth7*l6*lc7*m7*sin(th7) - 2*dth6*dth7*l6*lc7*m7*sin(th7)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                (lc7*m7*(981*cos(th4 + th5 + th6 + th7) + 100*dth4^2*l5*sin(th6 + th7) + 100*dth5^2*l5*sin(th6 + th7) + 100*dth4^2*l6*sin(th7) + 100*dth5^2*l6*sin(th7) + 100*dth6^2*l6*sin(th7) + 100*dth4^2*l4*sin(th5 + th6 + th7) + 200*dth4*dth5*l5*sin(th6 + th7) + 200*dth4*dth5*l6*sin(th7) + 200*dth4*dth6*l6*sin(th7) + 200*dth5*dth6*l6*sin(th7)))/100]
 

J1 =[ - l2*sin(th1 + th2) - l1*sin(th1) - l3*sin(th1 + th2 + th3), - l2*sin(th1 + th2) - l3*sin(th1 + th2 + th3), -l3*sin(th1 + th2 + th3)
   l2*cos(th1 + th2) + l1*cos(th1) + l3*cos(th1 + th2 + th3),   l2*cos(th1 + th2) + l3*cos(th1 + th2 + th3),  l3*cos(th1 + th2 + th3)]



J2 =[ - l7*sin(th4 + th5 + th6 + th7) - l5*sin(th4 + th5) - l4*sin(th4) - l6*sin(th4 + th5 + th6), - l7*sin(th4 + th5 + th6 + th7) - l5*sin(th4 + th5) - l6*sin(th4 + th5 + th6), - l7*sin(th4 + th5 + th6 + th7) - l6*sin(th4 + th5 + th6), -l7*sin(th4 + th5 + th6 + th7)
   l7*cos(th4 + th5 + th6 + th7) + l5*cos(th4 + th5) + l4*cos(th4) + l6*cos(th4 + th5 + th6),   l7*cos(th4 + th5 + th6 + th7) + l5*cos(th4 + th5) + l6*cos(th4 + th5 + th6),   l7*cos(th4 + th5 + th6 + th7) + l6*cos(th4 + th5 + th6),  l7*cos(th4 + th5 + th6 + th7)]

J(1:2,1:3)=-J1;
J(1:2,4:7)=J2
Jdt=diff(J,th1)*dth1+diff(J,th2)*dth2+diff(J,th3)*dth3+diff(J,th4)*dth4+diff(J,th5)*dth5+diff(J,th6)*dth6+diff(J,th7)*dth7
Jdtdq=simplify(Jdt*[dth1;dth2; dth3; dth4;dth5;dth6;dth7])
I(1:3,1:3)=M1
I(4:7,4:7)=M2
%M(4:5,1:2)=J
%M(1:2,4:5)=J.'
C=[C1;C2]