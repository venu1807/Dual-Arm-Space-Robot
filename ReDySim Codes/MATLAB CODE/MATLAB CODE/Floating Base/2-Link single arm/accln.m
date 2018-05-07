clc;
clear all;

%function   [ddq] = accln()
syms x0 y0 m0 m1 m2 lc0 lc1 lc2 th0 th1 th2 l0 l1 l2 Izz0 Izz1 Izz2 t
syms dx0 dy0 dth0 dth1 dth2
syms fx0 fy0 tau0 tau1 tau2
q=[x0;y0;th0;th1;th2];
dq=[dx0; dy0; dth0; dth1; dth2];

c0=cos(th0);
s0=sin(th0);
c1=cos(th1);
s1=sin(th1);
c2=cos(th2);
s2=sin(th2);
c01=cos(th0+th1);
s01=sin(th0+th1);
c012=cos(th0+th1+th2);
s012=sin(th0+th1+th2);

c00=[x0
     y0
     0];

c10=[x0+lc0*c0+lc1*c01
    y0+lc0*s0+lc1*s01
    0];
  
c20=[x0+lc0*c0+l1*c01+lc2*c012
    y0+lc0*s0+l1*s01+lc2*s012
    0];

w00=[0
    0
    dth0];

w10=[0
    0
    dth0+dth1];

w20=[0
    0
    dth0+dth1+dth2];

v00=[diff(c00,x0) diff(c00,y0) diff(c00,th0) diff(c00,th1) diff(c00,th2)]*[dx0;dy0;dth0;dth1;dth2];
v10=[diff(c10,x0) diff(c10,y0) diff(c10,th0) diff(c10,th1) diff(c10,th2)]*[dx0;dy0;dth0;dth1;dth2];
v20=[diff(c20,x0) diff(c20,y0) diff(c20,th0) diff(c20,th1) diff(c20,th2)]*[dx0;dy0;dth0;dth1;dth2];

K00=((m0*v00.'*v00)+(Izz0*w00.'*w00))/2;
K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;

K=simplify(K00+K10+K20);

%Diff K with q_dot
K1=[diff(K,dx0); diff(K,dy0); diff(K,dth0); diff(K,dth1); diff(K,dth2)];

%Diff K1 with t
K2=[diff(K1,dx0) diff(K1,dy0) diff(K1,dth0) diff(K1,dth1) diff(K1,dth2)];

K3=[diff(K1,x0) diff(K1,y0) diff(K1,th0) diff(K1,th1) diff(K1,th2)]*dq;

%Diff K with q

K4=[diff(K,x0); diff(K,y0); diff(K,th0); diff(K,th1); diff(K,th2)];

%Equations of motion


M=simplify(K2)

C=simplify(K3-K4)


%EOM Manually

w=m0+m1+m2;
Hbb=[w, 0
    0, w];
Hbm=[-((m1*lc0*sin(th0))+(m1*lc1*sin(th0+th1))+(m2*lc0*sin(th0))+(m2*l1*sin(th0+th1))+(m2*lc2*sin(th0+th1+th2))), -((m1*lc1*sin(th0+th1))+(m2*l1*sin(th0+th1))+(m2*lc2*sin(th0+th1+th2))), -(m2*lc2*sin(th0+th1+th2))
    ((m1*lc0*cos(th0))+(m1*lc1*cos(th0+th1))+(m2*lc0*cos(th0))+(m2*l1*cos(th0+th1))+(m2*lc2*cos(th0+th1+th2))),   ((m1*lc1*cos(th0+th1))+(m2*l1*cos(th0+th1))+(m2*lc2*cos(th0+th1+th2))),   m2*lc2*cos(th0+th1+th2)  ];
Hmm=[(((m1+m2)*(lc0^2))+(m1*(lc1^2))+(2*m1*lc0*lc1*cos(th1))+(m2*(l1^2))+(m2*(lc2^2))+(2*m2*l1*lc2*cos(th2))+(2*m2*lc0*l1*cos(th1))+(2*m2*lc0*lc2*cos(th1+th2))+Izz0+Izz1+Izz2),  ((m1*lc0*lc1*cos(th1))+(m1*(lc1^2))+(m2*(l1^2))+(m2*(lc2^2))+(2*m2*l1*lc2*cos(th2))+(m2*lc0*l1*cos(th1))+(m2*lc0*lc2*cos(th1+th2))+Izz1+Izz2),  ((m2*(lc2^2))+(m2*l1*lc2*cos(th2))+(m2*lc0*lc2*cos(th1+th2))+Izz2)
    ((m1*lc0*lc1*cos(th1))+(m1*(lc1^2))+(m2*(l1^2))+(m2*(lc2^2))+(2*m2*l1*lc2*cos(th2))+(m2*lc0*l1*cos(th1))+(m2*lc0*lc2*cos(th1+th2))+(Izz1+Izz2)),    ((m1*(lc1^2))+(m2*(l1^2))+(m2*(lc2^2))+(2*m2*l1*lc2*cos(th2))+(Izz1+Izz2)),         ((m2*(lc2^2))+(m2*l1*lc2*cos(th2))+(Izz2))
    ((m2*(lc2^2))+(m2*l1*lc2*cos(th2))+(m2*lc0*lc2*cos(th1+th2))+(Izz2)),    ((m2*(lc2^2))+(m2*l1*lc2*cos(th2))+(Izz2)),    ((m2*(lc2^2))+(Izz2))];
H=[Hbb, Hbm
    Hbm.' Hmm]

%EOM

Minv=inv(M)

F=[fx0; fy0; tau0; tau1; tau2]

ddq=simplify(Minv*(F-C))