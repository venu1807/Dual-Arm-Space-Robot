clc;
clear all;

%function   [ddq] = accln()

syms x0 y0 m0 m1 m2 m3 m4 m5 m6 lc0 lc1 lc2 lc3 lc4 lc5 lc6 th0 th1 th2 th3 th4 th5 th6 l0 l1 l2 l3 l4 l5 l6 Izz0 Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 t
syms dx0 dy0 dth0 dth1 dth2 dth3 dth4 dth5 dth6
syms fx0 fy0 tau0 tau1 tau2 tau3 tau4 tau5 tau6

q=[x0;y0;th0;th1;th2;th3;th4;th5;th6];
dq=[dx0; dy0; dth0; dth1; dth2; dth3; dth4; dth5; dth6];

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


c4=cos(th4);
s4=sin(th4);
c5=cos(th5);
s5=sin(th5);
c6=cos(th6);
s6=sin(th6);
c04=cos(th0+th4);
s04=sin(th0+th4);
c045=cos(th0+th4+th5);
s045=sin(th0+th4+th5);
c0456=cos(th0+th4+th5+th6);
s0456=sin(th0+th4+th5+th6);

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


c40=[x0-lc0*c0+lc4*c04
    y0-lc0*s0+lc4*s04
    0];
  
c50=[x0-lc0*c0+l4*c04+lc5*c045
    y0-lc0*s0+l4*s04+lc5*s045
    0];

c60=[x0-lc0*c0+l4*c04+l5*c045+lc6*c0456
    y0-lc0*s0+l4*s04+l5*s045+lc6*s0456
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

w40=[0
    0
    dth0+dth4];

w50=[0
    0
    dth0+dth4+dth5];

w60=[0
    0
    dth0+dth4+dth5+dth6];


v00=[diff(c00,x0) diff(c00,y0) diff(c00,th0) diff(c00,th1) diff(c00,th2)  diff(c00,th3)  diff(c00,th4) diff(c00,th5)  diff(c00,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v10=[diff(c10,x0) diff(c10,y0) diff(c10,th0) diff(c10,th1) diff(c10,th2)  diff(c10,th3)  diff(c10,th4) diff(c10,th5)  diff(c10,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v20=[diff(c20,x0) diff(c20,y0) diff(c20,th0) diff(c20,th1) diff(c20,th2)  diff(c20,th3)  diff(c20,th4) diff(c20,th5)  diff(c20,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v30=[diff(c30,x0) diff(c30,y0) diff(c30,th0) diff(c30,th1) diff(c30,th2)  diff(c30,th3)  diff(c30,th4) diff(c30,th5)  diff(c30,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v40=[diff(c40,x0) diff(c40,y0) diff(c40,th0) diff(c40,th1) diff(c40,th2)  diff(c40,th3)  diff(c40,th4) diff(c40,th5)  diff(c40,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v50=[diff(c50,x0) diff(c50,y0) diff(c50,th0) diff(c50,th1) diff(c50,th2)  diff(c50,th3)  diff(c50,th4) diff(c50,th5)  diff(c50,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];
v60=[diff(c60,x0) diff(c60,y0) diff(c60,th0) diff(c60,th1) diff(c60,th2)  diff(c60,th3)  diff(c60,th4) diff(c60,th5)  diff(c60,th6)]*[dx0;dy0;dth0;dth1;dth2;dth3;dth4;dth5;dth6];


K00=((m0*v00.'*v00)+(Izz0*w00.'*w00))/2;
K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;
K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;
K40=((m4*v40.'*v40)+(Izz4*w40.'*w40))/2;
K50=((m5*v50.'*v50)+(Izz5*w50.'*w50))/2;
K60=((m6*v60.'*v60)+(Izz6*w60.'*w60))/2;

K=simplify(K00+K10+K20+K30+K40+K50+K60);

%Diff K with q_dot
K1=[diff(K,dx0); diff(K,dy0); diff(K,dth0); diff(K,dth1); diff(K,dth2); diff(K,dth3); diff(K,dth4); diff(K,dth5); diff(K,dth6)];

%Diff K1 with t
K2=[diff(K1,dx0) diff(K1,dy0) diff(K1,dth0) diff(K1,dth1) diff(K1,dth2) diff(K1,dth3) diff(K1,dth4) diff(K1,dth5) diff(K1,dth6)];

K3=[diff(K1,x0) diff(K1,y0) diff(K1,th0) diff(K1,th1) diff(K1,th2) diff(K1,th3) diff(K1,th4) diff(K1,th5) diff(K1,th6)]*dq;

%Diff K with q

K4=[diff(K,x0); diff(K,y0); diff(K,th0); diff(K,th1); diff(K,th2); diff(K,th3) ; diff(K,th4); diff(K,th5); diff(K,th6)];

%Equations of motion

M=simplify(K2)

C=simplify(K3-K4)

%EOM

%Minv=inv(M)

F=[fx0; fy0; tau0; tau1; tau2; tau3; tau4; tau5; tau6]

%ddq=simplify(Minv*(F-C))