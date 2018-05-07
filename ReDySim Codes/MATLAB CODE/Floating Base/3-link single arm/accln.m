clc;
clear all;

%function   [ddq] = accln()
syms x0 y0 m0 m1 m2 m3 lc0 lc1 lc2 lc3 th0 th1 th2 th3 l0 l1 l2 l3 Izz0 Izz1 Izz2 Izz3 t
syms dx0 dy0 dth0 dth1 dth2 dth3
syms fx0 fy0 tau0 tau1 tau2 tau3
q=[x0;y0;th0;th1;th2;th3];
dq=[dx0; dy0; dth0; dth1; dth2; dth3];

c0=cos(th0);
s0=sin(th0);
c1=cos(th1);
s1=sin(th1);
c2=cos(th2);
s2=sin(th2);
c3=cos(th3);
s3=sin(th3);
c01=cos(th0+th1);
s01=sin(th0+th1);
c012=cos(th0+th1+th2);
s012=sin(th0+th1+th2);
c0123=cos(th0+th1+th2+th3);
s0123=sin(th0+th1+th2+th3);

c00=[x0
     y0
     0];

c10=[x0+lc0*c0+lc1*c01
    y0+lc0*s0+lc1*s01
    0];
  
c20=[x0+lc0*c0+l1*c01+lc2*c012
    y0+lc0*s0+l1*s01+lc2*s012
    0];

c30=[x0+lc0*c0+l1*c01+l2*c012+lc3*c0123
    y0+lc0*s0+l1*s01+l2*s012+lc3*s0123
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

w30=[0
    0
    dth0+dth1+dth2+dth3];


v00=[diff(c00,x0) diff(c00,y0) diff(c00,th0) diff(c00,th1) diff(c00,th2)  diff(c00,th3)]*[dx0;dy0;dth0;dth1;dth2;dth3];
v10=[diff(c10,x0) diff(c10,y0) diff(c10,th0) diff(c10,th1) diff(c10,th2)  diff(c10,th3)]*[dx0;dy0;dth0;dth1;dth2;dth3];
v20=[diff(c20,x0) diff(c20,y0) diff(c20,th0) diff(c20,th1) diff(c20,th2)  diff(c20,th3)]*[dx0;dy0;dth0;dth1;dth2;dth3];
v30=[diff(c30,x0) diff(c30,y0) diff(c30,th0) diff(c30,th1) diff(c30,th2)  diff(c30,th3)]*[dx0;dy0;dth0;dth1;dth2;dth3];


K00=((m0*v00.'*v00)+(Izz0*w00.'*w00))/2;
K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;
K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;

K=simplify(K00+K10+K20+K30);

%Diff K with q_dot
K1=[diff(K,dx0); diff(K,dy0); diff(K,dth0); diff(K,dth1); diff(K,dth2); diff(K,dth3)];

%Diff K1 with t
K2=[diff(K1,dx0) diff(K1,dy0) diff(K1,dth0) diff(K1,dth1) diff(K1,dth2) diff(K1,dth3)];

K3=[diff(K1,x0) diff(K1,y0) diff(K1,th0) diff(K1,th1) diff(K1,th2) diff(K1,th3)]*dq;

%Diff K with q

K4=[diff(K,x0); diff(K,y0); diff(K,th0); diff(K,th1); diff(K,th2); diff(K,th3)];

%Equations of motion

M=simplify(K2)

C=simplify(K3-K4)

%EOM

%Minv=inv(M)

F=[fx0; fy0; tau0; tau1; tau2; tau3]

%ddq=simplify(Minv*(F-C))