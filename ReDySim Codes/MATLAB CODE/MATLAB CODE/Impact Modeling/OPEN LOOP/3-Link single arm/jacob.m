function [J]=jacob()

syms m0 m1 m2 m3 m4 m5 m6 m7 lc0 lc1 lc2 lc3 lc4 lc5 lc6 lc7 x0 y0 th0 th1 th2 th3 th4 th5 th6 th7 l0 l1 l2 l3 l4 l5 l6 l7 Izz0 Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 Izz7 t
syms dx0 dy0 dth0 dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms fx fy tau0 tau1 tau2 tau3 tau4 tau5 tau6 tau7


J=vpa(zeros(1:3,1:6))
 J1=zeros(3,2);
  
J2 =[ - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l2*sin(th0 + th1 + th2), - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l2*sin(th0 + th1 + th2), - l3*sin(th0 + th1 + th2 + th3) - l2*sin(th0 + th1 + th2), -l3*sin(th0 + th1 + th2 + th3)
   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l2*cos(th0 + th1 + th2),   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l2*cos(th0 + th1 + th2),   l3*cos(th0 + th1 + th2 + th3) + l2*cos(th0 + th1 + th2),  l3*cos(th0 + th1 + th2 + th3)];

J(1:3,1:2)=J1;
J(2:3,3:6)=J2;
J(1,3:6)=ones(1,4);
